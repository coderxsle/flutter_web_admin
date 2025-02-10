#!/bin/bash

# 设置脚本所在目录
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
# 加载必要的工具脚本
source "${SCRIPT_DIR}/env-utils.sh"
source "${SCRIPT_DIR}/log-utils.sh"
source "${SCRIPT_DIR}/ssh.sh"
source "${SCRIPT_DIR}/system-utils.sh"


# 部署到服务器
deploy_to_server() {
    local env=$1
    local version=${2:-$VERSION}  # 如果未传入则使用全局 VERSION
    local image_name=${3:-$IMAGE_NAME}  # 如果未传入则使用全局 IMAGE_NAME
    local should_upload_image=true
    
    # 询问是否上传镜像
    log_info "是否需要上传镜像到服务器？(y/n，10秒后默认上传)"
    read -t 10 -n 1 answer
    echo
    
    if [ "$?" -gt 128 ]; then
        log_info "未收到输入，将执行默认操作：上传镜像"
    elif [[ "${answer}" =~ ^[Nn]$ ]]; then
        log_info "已选择不上传镜像"
        should_upload_image=false
    else
        log_info "已选择上传镜像"
    fi
    
    # 验证必需的环境变量
    local required_vars=(
        "SERVER_IP"
        "SERVER_USER"
        "SERVER_PORT"
        "SSH_KEY_PATH"
        "DEPLOY_PATH"
        "PROJECT_ROOT"
    )
    
    for var in "${required_vars[@]}"; do
        if [ -z "${!var}" ]; then
            log_error "缺少必需的环境变量: ${var}"
            return 1
        fi
    done
    
    # 设置 SSH 选项
    local SSH_OPTS=""
    if [ "$USE_SSH_PASSWORD" = true ]; then
        # 使用 sshpass 进行密码认证
        if ! command -v sshpass &> /dev/null; then
            log_error "请先安装 sshpass: apt-get install sshpass 或 brew install sshpass"
            return 1
        fi
        SSH_OPTS="sshpass -p ${SSH_PASSWORD}"
        SCP_OPTS="sshpass -p ${SSH_PASSWORD} scp -o StrictHostKeyChecking=no"
    else
        SSH_OPTS="ssh -i ${SSH_KEY_PATH}"
        SCP_OPTS="scp -i ${SSH_KEY_PATH}"
    fi
    
    # 传输配置文件
    log_info "上传配置文件到云端服务器..."
    for config_file in "docker-compose.yaml" "nginx.conf"; do
        log_info "上传配置文件 ${config_file}..."
        if ! ${SCP_OPTS} -P "${SERVER_PORT}" \
            "${PROJECT_ROOT}/deploy/${env}/${config_file}" \
            "${SERVER_USER}@${SERVER_IP}:${DEPLOY_PATH}/"; then
            log_error "配置文件 ${config_file} 上传失败"
            return 1
        fi
    done
    
    # 传输环境变量文件
    log_info "上传环境变量文件到云端服务器..."
    local env_file_name
    env_file_name=$(get_env_file_name "$env") || return 1

    if ! ${SCP_OPTS} -P "${SERVER_PORT}" \
        "${PROJECT_ROOT}/env/${env_file_name}" \
        "${SERVER_USER}@${SERVER_IP}:${DEPLOY_PATH}/${env_file_name}"; then
        log_error "环境变量文件上传失败"
        return 1
    fi
    
    # 上传镜像文件
    if [ "$should_upload_image" = true ]; then
        local image_tar="${image_name}_${env}-${version}.tar"
        log_info "上传 Docker 镜像到云端服务器..."
        log_info "本地镜像文件路径: ${PWD}/${image_tar}"
        log_info "目标服务器路径: ${SERVER_USER}@${SERVER_IP}:${DEPLOY_PATH}/${image_tar}"
        if ! ${SCP_OPTS} -P "${SERVER_PORT}" \
            "${image_tar}" \
            "${SERVER_USER}@${SERVER_IP}:${DEPLOY_PATH}/"; then
            log_error "镜像文件上传失败"
            return 1
        fi
        
        # 在服务器上加载镜像
        log_info "在云端服务器上加载 Docker 镜像..."
        log_info "服务器上的镜像文件路径: ${DEPLOY_PATH}/${image_tar}"
        
        # 询问是否保留tar文件
        log_info "是否需要删除镜像文件？(y/n，10秒后默认保留)"
        read -t 10 -n 1 delete_tar
        echo
        
        if ! ${SSH_OPTS} -p "${SERVER_PORT}" "${SERVER_USER}@${SERVER_IP}" \
            "cd ${DEPLOY_PATH} && docker load -i ${image_tar}"; then
            log_error "镜像加载失败"
            return 1
        fi

        # 根据用户选择决定是否删除tar文件
        if [[ "${delete_tar}" =~ ^[Yy]$ ]]; then
            log_info "删除服务器上的镜像文件..."
            if ! ${SSH_OPTS} -p "${SERVER_PORT}" "${SERVER_USER}@${SERVER_IP}" "rm -f ${DEPLOY_PATH}/${image_tar}"; then
                log_warn "删除镜像文件失败，但不影响部署过程"
            fi
        else
            if [ "$?" -gt 128 ]; then
                log_info "等待超时，默认保留镜像文件: ${DEPLOY_PATH}/${image_tar}"
            else
                log_info "保留镜像文件: ${DEPLOY_PATH}/${image_tar}"
            fi
        fi
    else
        log_info "跳过镜像上传步骤"
    fi
    
    # 检查并配置Docker配置文件
    log_info "检查 Docker 配置文件..."
    if ! ${SSH_OPTS} -p "${SERVER_PORT}" "${SERVER_USER}@${SERVER_IP}" "test -f /etc/docker/daemon.json"; then
        log_info "Docker 配置文件不存在，准备上传配置文件..."
        # 确保目标目录存在并设置权限
        if ! ${SSH_OPTS} -p "${SERVER_PORT}" "${SERVER_USER}@${SERVER_IP}" "sudo mkdir -p /etc/docker && sudo chown ${SERVER_USER}: /etc/docker"; then
            log_error "创建Docker配置目录或设置权限失败"
            return 1
        fi
        
        # 直接上传配置文件到目标目录
        if ! ${SCP_OPTS} -P "${SERVER_PORT}" \
            "${SCRIPT_DIR}/docker-config.json" \
            "${SERVER_USER}@${SERVER_IP}:/etc/docker/daemon.json"; then
            log_error "Docker配置文件上传失败"
            return 1
        fi
        
        # 重启Docker服务
        if ! ${SSH_OPTS} -p "${SERVER_PORT}" "${SERVER_USER}@${SERVER_IP}" \
            "sudo systemctl daemon-reload && sudo systemctl restart docker"; then
            log_error "重启Docker服务失败"
            return 1
        fi
        
        # 等待Docker服务完全启动并验证镜像仓库连接
        log_info "等待 Docker 服务重启完成并验证镜像仓库连接..."
        for i in {1..60}; do
            if ${SSH_OPTS} -p "${SERVER_PORT}" "${SERVER_USER}@${SERVER_IP}" "docker info > /dev/null 2>&1 && docker pull hello-world > /dev/null 2>&1"; then
                log_info "Docker服务已就绪，镜像仓库连接正常"
                break
            fi
            if [ $i -eq 60 ]; then
                log_error "等待 Docker 服务启动或验证镜像仓库连接超时"
                return 1
            fi
            sleep 2
        done
        
        log_info "Docker配置更新完成，服务已重启的就绪"
    fi
    
    # 部署服务前验证Docker服务状态
    log_info "验证 Docker 服务状态..."
    for i in {1..30}; do
        if ${SSH_OPTS} -p "${SERVER_PORT}" "${SERVER_USER}@${SERVER_IP}" "docker info > /dev/null 2>&1"; then
            log_info "Docker 服务正常"
            break
        fi
        if [ $i -eq 30 ]; then
            log_error "Docker 服务异常"
            return 1
        fi
        log_info "等待 Docker 服务就绪...（${i}/30）"
        sleep 2
    done

    # 部署服务
    log_info "正在部署服务到云端服务器..."
    local local_image_name="${image_name}_${env}-${version}"
    log_info "使用本地镜像: ${local_image_name}"
    if ! ${SSH_OPTS} -t -p "${SERVER_PORT}" "${SERVER_USER}@${SERVER_IP}" "cd ${DEPLOY_PATH} && \
        set -a && source ${env_file_name} && set +a && \
        docker compose --env-file ${env_file_name} down && \
        IMAGE_NAME=${local_image_name} REGISTRY='' NAMESPACE='' docker compose --env-file ${env_file_name} up -d"; then
        log_error "服务部署失败"
        return 1
    fi
    
    log_info "服务部署成功"
    return 0
}


# 显示部署完成信息
show_deployment_done_info() {
    local image_name=$1
    local env=$2
    local version=$3
    
    log_info "部署完成！"
    log_info "--------------------------------------------------"
    show_deployment_info "$image_name" "$env" "$version"
    log_info "--------------------------------------------------"
    
    # 获取容器运行状态
    log_info "容器状态:"
    docker ps --filter "name=book-store-${env}" --format "table {{.Names}}\t{{.Status}}\t{{.Ports}}"
}

# 显示部署信息
show_deployment_info() {
    local image_name=$1
    local env=$2
    local version=$3
    
    log_info "部署信息:"
    log_info "  镜像: ${image_name}"
    log_info "  环境: ${env}"
    log_info "  版本: ${version}"
    log_info "  部署路径: ${DEPLOY_PATH}"
    log_info "  服务器: ${SERVER_USER}@${SERVER_IP}"
}


# 记录部署历史
log_deployment_history() {
    local env=$1
    local version=$2
    local status=$3
    local timestamp=$(date '+%Y-%m-%d %H:%M:%S')
    log_info "${timestamp} ${env} ${version} ${status}" >> "${BASE_DIR}/deploy/deploy_history.log"
}



# 发送部署通知
send_deployment_notification() {
    local env=$1
    local version=$2
    local status=$3
    local message="环境: ${env}\n版本: ${version}\n状态: ${status}\n时间: $(date '+%Y-%m-%d %H:%M:%S')"
    
    # 如果配置了通知 URL，发送通知
    if [ ! -z "${NOTIFICATION_URL}" ]; then
        curl -X POST "${NOTIFICATION_URL}" \
            -H "Content-Type: application/json" \
            -d "{\"text\":\"${message}\"}"
    fi
}


# 如果是直接运行此脚本
if [[ "${BASH_SOURCE[0]}" == "${0}" ]]; then

    # 显示使用方法
    show_usage() {
        echo "使用方法: $0 <环境> <版本>"
        echo "示例: $0 prod 1.0.0"
        exit 1
    }
    
    # 检查参数
    if [ "$#" -lt 2 ]; then
        show_usage
    fi
    
    # 获取参数
    ENV=$1
    VERSION=$2
    
    # 加载环境变量
    load_env "$ENV" || exit 1
    
    # 使用环境变量中的配置
    deploy_to_server "$ENV" "$VERSION"
fi




