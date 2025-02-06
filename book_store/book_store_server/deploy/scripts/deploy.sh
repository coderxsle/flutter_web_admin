#!/bin/bash

# 设置脚本所在目录
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

# 加载必要的工具脚本
source "${SCRIPT_DIR}/log-utils.sh"
source "${SCRIPT_DIR}/env-utils.sh"
source "${SCRIPT_DIR}/ssh-utils.sh"
    
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

# 部署相关的工具函数



# 部署到服务器
deploy_to_server() {
    local env=$1
    local version=${2:-$VERSION}  # 如果未传入则使用全局 VERSION
    local image_name=${3:-$IMAGE_NAME}  # 如果未传入则使用全局 IMAGE_NAME
    
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
    
    # 设置SSH连接
    setup_ssh_connection "$SERVER_IP" "$SERVER_USER" "$SERVER_PORT" "$SSH_KEY_PATH" || return 1
    
    # 传输配置文件
    log_info "上传配置文件到云端服务器..."
    for config_file in "docker-compose.yaml" "nginx.conf"; do
        log_info "上传配置文件 ${config_file}..."
        if ! scp -i "${SSH_KEY_PATH}" -P "${SERVER_PORT}" \
            "${PROJECT_ROOT}/deploy/${env}/${config_file}" \
            "${SERVER_USER}@${SERVER_IP}:${DEPLOY_PATH}/"; then
            log_error "配置文件 ${config_file} 上传失败"
            return 1
        fi
    done
    
    # 上传镜像文件
    local image_tar="${image_name}_${env}-${version}.tar"
    log_info "上传 Docker 镜像到云端服务器..."
    if ! scp -i "${SSH_KEY_PATH}" -P "${SERVER_PORT}" \
        "${image_tar}" \
        "${SERVER_USER}@${SERVER_IP}:${DEPLOY_PATH}/"; then
        log_error "镜像文件上传失败"
        return 1
    fi
    
    # 在服务器上加载镜像
    log_info "在云端服务器上加载 Docker 镜像..."
    if ! ssh_execute "${SERVER_USER}@${SERVER_IP}" "cd ${DEPLOY_PATH} && \
        docker load -i ${image_tar} && \
        rm -f ${image_tar}"; then
        log_error "镜像加载失败"
        return 1
    fi
    
    # 部署服务
    log_info "部署服务到云端服务器..."
    if ! ssh_execute "${SERVER_USER}@${SERVER_IP}" "cd ${DEPLOY_PATH} && \
        docker compose down && \
        docker compose up -d"; then
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





