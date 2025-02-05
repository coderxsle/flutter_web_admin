#!/bin/bash

# 日志函数
log_info() {
    echo -e "\033[32m[INFO] $1\033[0m"
}

log_warn() {
    echo -e "\033[33m[WARN] $1\033[0m"
}

log_error() {
    echo -e "\033[31m[ERROR] $1\033[0m"
}

# 检查命令是否存在
check_command() {
    if ! command -v $1 &> /dev/null; then
        log_error "命令 '$1' 未找到，请先安装"
        exit 1
    fi
}

# 检查必需的工具
check_required_tools() {
    check_command docker
    check_command curl
    check_command jq
    check_command sed
}

# 加载环境变量
load_env() {
    local env=$1
    local env_file
    
    # 根据环境参数确定配置文件路径
    case "$env" in
        "prod")
            env_file="../env/.env.production"
            ;;
        "test")
            env_file="../env/.env.test"
            ;;
        "staging")
            env_file="../env/.env.staging"
            ;;
        *)
            log_error "未知的环境: $env"
            exit 1
            ;;
    esac
    
    # 检查环境变量文件是否存在
    if [ ! -f "$env_file" ]; then
        log_error "环境变量文件不存在: $env_file"
        exit 1
    fi
    
    log_info "加载环境配置文件: $(realpath $env_file)"
    
    # 加载环境变量
    set -a
    source "$env_file"
    set +a
    
    # 验证必要的环境变量
    local required_vars=(
        "HUAWEI_REGISTRY_USERNAME"
        "HUAWEI_REGISTRY_PASSWORD"
        "SERVER_IP"
        "SERVER_USER"
        "SERVER_PORT"
        "DEPLOY_PATH"
    )
    
    for var in "${required_vars[@]}"; do
        if [ -z "${!var}" ]; then
            log_error "缺少必需的环境变量: ${var}"
            exit 1
        fi
    done
}

# 构建镜像标签
build_image_tag() {
    local env=$1
    local version=$2
    echo "${env}-${version}"
}

# 构建完整的镜像名称
build_full_image_name() {
    local image_tag=$1
    echo "${HUAWEI_REGISTRY}/${HUAWEI_REGISTRY_NAMESPACE}/${PROJECT_NAME}:${image_tag}"
}

# 获取 Portainer 认证令牌
get_portainer_token() {
    log_info "尝试连接 Portainer API: http://${PORTAINER_HOST}:${PORTAINER_PORT}/api/auth"
    
    local token=$(curl -s -X POST "http://${PORTAINER_HOST}:${PORTAINER_PORT}/api/auth" \
        -H "Content-Type: application/json" \
        -d "{\"username\":\"${PORTAINER_USERNAME}\",\"password\":\"${PORTAINER_PASSWORD}\"}" \
        --verbose \
        | jq -r .jwt)
    
    if [ $? -ne 0 ]; then
        log_error "curl 命令执行失败，返回码: $?"
        log_error "无法连接到 Portainer API"
        exit 1
    fi
    
    if [ -z "$token" ]; then
        log_error "用户名: ${PORTAINER_USERNAME}"
        log_error "密码: ${PORTAINER_PASSWORD}"
        log_error "Portainer 认证失败"
        exit 1
    fi
    
    echo "$token"
}

# 检查堆栈是否存在
check_stack_exists() {
    local token=$1
    local stack_name=$2
    
    curl -s -H "Authorization: Bearer ${token}" \
        "http://${PORTAINER_HOST}:${PORTAINER_PORT}/api/stacks" \
        | jq -r ".[] | select(.Name==\"${stack_name}\") | .Id"
}

# 等待容器健康检查
wait_for_healthy() {
    local token=$1
    local container_name=$2
    local max_attempts=30
    local attempt=1
    
    while [ $attempt -le $max_attempts ]; do
        local status=$(curl -s \
            -H "Authorization: Bearer ${token}" \
            "http://${PORTAINER_HOST}:${PORTAINER_PORT}/api/endpoints/${PORTAINER_ENDPOINT_ID}/docker/containers/json" \
            | jq -r ".[] | select(.Names[] | contains(\"${container_name}\")) | .State")
        
        if [ "$status" = "running" ]; then
            log_info "容器 ${container_name} 已经启动并运行正常"
            return 0
        fi
        
        log_warn "等待容器 ${container_name} 启动... (${attempt}/${max_attempts})"
        sleep 2
        attempt=$((attempt + 1))
    done
    
    log_error "容器 ${container_name} 启动超时"
    return 1
}

# 登录到华为云镜像仓库
login_to_registry() {
    log_info "正在登录到 ${HUAWEI_REGISTRY}..."
    log_info "使用账号: ${HUAWEI_REGISTRY_USERNAME}"
    
    if docker login ${HUAWEI_REGISTRY} \
        -u ${HUAWEI_REGISTRY_USERNAME} \
        -p ${HUAWEI_REGISTRY_PASSWORD}; then
        log_info "登录成功！"
        return 0
    else
        log_error "登录失败！"
        return 1
    fi
}

# 构建镜像
build_image() {
    local image_name=$1
    local env=$2
    
    log_info "构建环境: ${env}"
    log_info "开始构建镜像: ${image_name}"
    
    # 获取项目根目录（修正目录层级）
    local current_dir=$(pwd)
    local project_root="${current_dir}/../.."
    
    log_info "构建目录: ${project_root}"
    
    # 启用 buildx
    docker buildx create --use

    # 构建多架构 Docker 镜像
    if ! docker buildx build \
        --platform linux/amd64,linux/arm64 \
        --build-arg ENV=${env} \
        -t "${IMAGE_NAME}:${IMAGE_TAG}" \
        --load \
        -f "${current_dir}/../Dockerfile" \
        "${project_root}"; then
        return 1
    fi
    
    return 0
}

# 推送镜像
push_image() {
    local image_name=$1
    log_info "开始推送镜像: ${image_name}"
    docker push ${image_name}
}

# 回滚部署
rollback_deployment() {
    local stack_id=$1
    local token=$2
    
    log_warn "正在回滚到上一个版本..."
    curl -s -X POST "${PORTAINER_URL}/api/stacks/${stack_id}/rollback" \
        -H "Authorization: Bearer ${token}"
}

# 显示部署信息
show_deployment_info() {
    local image_name=$1
    local env=$2
    local version=$3
    
    log_info "部署完成！"
    log_info "----------------------------------------"
    log_info "镜像: ${image_name}"
    log_info "环境: ${env}"
    log_info "版本: ${version}"
    log_info "----------------------------------------"
    
    # 获取容器运行状态
    log_info "容器状态:"
    docker ps --filter "name=book-store-${env}" --format "table {{.Names}}\t{{.Status}}\t{{.Ports}}"
}

# 检查端口是否可用
check_port_available() {
    local port=$1
    if lsof -i :${port} > /dev/null; then
        return 1
    fi
    return 0
}

# 验证环境配置
validate_environment() {
    local env=$1
    
    # 检查必需的环境变量
    local required_vars=(
        "POSTGRES_PASSWORD"
        "REDIS_PASSWORD"
        "HUAWEI_REGISTRY_NAMESPACE"
        "HUAWEI_REGISTRY_USERNAME"
        "HUAWEI_REGISTRY_PASSWORD"
        "PORTAINER_USERNAME"
        "PORTAINER_PASSWORD"
    )
    
    for var in "${required_vars[@]}"; do
        if [ -z "${!var}" ]; then
            log_error "缺少必需的环境变量: ${var}"
            return 1
        fi
    done
    
    return 0
}

# 初始化部署环境
init_deployment() {
    local env=$1
    
    # 创建必要的目录
    local dirs=(
        "${env}/logs"
        "${env}/config"
        "${env}/data"
    )
    
    for dir in "${dirs[@]}"; do
        if [ ! -d "$dir" ]; then
            mkdir -p "$dir" || log_warn "无法创建目录: $dir"
        fi
    done
}

# 备份数据库
backup_database() {
    local env=$1
    local timestamp=$(date '+%Y%m%d_%H%M%S')
    local backup_file="${BACKUP_DIR}/${env}/db_${timestamp}.sql"
    
    log_info "备份数据库..."
    if docker exec ${env}-postgres-1 pg_dump -U ${POSTGRES_USER} ${POSTGRES_DB} > "${backup_file}"; then
        if [ "${DB_BACKUP_COMPRESS}" = true ]; then
            gzip "${backup_file}"
            log_info "数据库备份已压缩: ${backup_file}.gz"
        else
            log_info "数据库备份成功: ${backup_file}"
        fi
        return 0
    else
        log_error "数据库备份失败"
        return 1
    fi
}

# 检查服务健康状态
check_service_health() {
    local env=$1
    local service=$2
    local max_retries=${3:-${MAX_RETRY_ATTEMPTS}}
    local retry_count=0
    
    while [ $retry_count -lt $max_retries ]; do
        if curl -s "http://localhost:8080/health" | grep -q "ok"; then
            return 0
        fi
        log_warn "服务 ${service} 健康检查失败，重试 $((retry_count + 1))/${max_retries}..."
        sleep ${HEALTH_CHECK_INTERVAL}
        retry_count=$((retry_count + 1))
    done
    
    return 1
}

# 清理旧镜像
cleanup_old_images() {
    local keep_versions=${1:-3}
    log_info "清理旧镜像..."
    
    # 获取所有相关镜像
    local images=$(docker images "${HUAWEI_REGISTRY}/${HUAWEI_REGISTRY_NAMESPACE}/${PROJECT_NAME}*" --format "{{.Repository}}:{{.Tag}}")
    
    # 按创建时间排序并保留最新的几个版本
    local count=$(echo "${images}" | wc -l)
    if [ $count -gt $keep_versions ]; then
        echo "${images}" | head -n $(($count - $keep_versions)) | xargs -r docker rmi
    fi
}

# 验证部署结果
validate_deployment() {
    local env=$1
    local version=$2
    
    # 检查必需的服务是否运行
    local required_services=("server" "postgres" "redis" "nginx")
    for service in "${required_services[@]}"; do
        if ! docker ps --format '{{.Names}}' | grep -q "${env}-${service}"; then
            log_error "服务 ${service} 未运行"
            return 1
        fi
    done
    
    # # 检查服务健康状态
    # if ! check_service_health "${env}" "server"; then
    #     log_error "服务健康检查失败"
    #     return 1
    # fi
    
    return 0
}

# 记录部署历史
log_deployment_history() {
    local env=$1
    local version=$2
    local status=$3
    local timestamp=$(date '+%Y-%m-%d %H:%M:%S')
    
    echo "${timestamp} ${env} ${version} ${status}" >> "${BASE_DIR}/deploy/deploy_history.log"
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

# 添加环境变量验证函数
validate_env_vars() {
    local env=$1
    local required_vars=(
        "POSTGRES_DB"
        "POSTGRES_USER"
        "POSTGRES_PASSWORD"
        "REDIS_PASSWORD"
        "SERVICE_SECRET"
    )
    
    for var in "${required_vars[@]}"; do
        if [ -z "${!var}" ]; then
            log_error "缺少必需的环境变量: ${var}"
            return 1
        fi
        
        # 检查密码强度
        if [[ $var == *"PASSWORD"* || $var == *"SECRET"* ]]; then
            if [ ${#var} -lt 16 ]; then
                log_warn "${var} 长度小于16位，建议使用更强的密码"
            fi
        fi
    done
    return 0
}

# SSH连接函数
ssh_execute() {
    local host="${SERVER_USER}@${SERVER_IP}"
    local cmd="$1"
    local ssh_cmd="ssh"

    # 添加SSH选项
    [ -n "${SSH_PORT}" ] && ssh_cmd+=" -p ${SSH_PORT}"
    [ -n "${SSH_KEY_PATH}" ] && ssh_cmd+=" -i ${SSH_KEY_PATH}"
    [ -n "${SSH_OPTS}" ] && ssh_cmd+=" ${SSH_OPTS}"

    ${ssh_cmd} ${host} "${cmd}"
} 