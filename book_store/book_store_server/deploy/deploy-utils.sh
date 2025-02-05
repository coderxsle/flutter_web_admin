#!/bin/bash

# 加载配置
source "$(dirname "${BASH_SOURCE[0]}")/deploy.config"

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
    local env_file="${BASE_DIR}/env/.env.${env}"
    
    if [ ! -f "$env_file" ]; then
        log_error "环境变量文件不存在: $env_file"
        exit 1
    }
    
    set -a
    source "$env_file"
    set +a
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
    local token=$(curl -s -X POST "http://${PORTAINER_HOST}:${PORTAINER_PORT}/api/auth" \
        -H "Content-Type: application/json" \
        -d "{\"username\":\"${PORTAINER_USERNAME}\",\"password\":\"${PORTAINER_PASSWORD}\"}" \
        | jq -r .jwt)
    
    if [ -z "$token" ]; then
        log_error "Portainer 认证失败"
        exit 1
    }
    
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
    docker login ${HUAWEI_REGISTRY} \
        -u ${REGISTRY_USERNAME} \
        -p ${REGISTRY_PASSWORD} &> /dev/null
}

# 构建镜像
build_image() {
    local image_name=$1
    local env=$2
    
    docker build -t ${image_name} \
        --build-arg ENV=${env} \
        --build-arg DB_PASSWORD=${POSTGRES_PASSWORD} \
        --build-arg REDIS_PASSWORD=${REDIS_PASSWORD} \
        --no-cache=${FORCE} \
        -f ${BASE_DIR}/Dockerfile ${BASE_DIR}
}

# 推送镜像
push_image() {
    local image_name=$1
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