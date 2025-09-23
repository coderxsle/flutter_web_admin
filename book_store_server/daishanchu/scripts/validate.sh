#!/bin/bash

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

if [[ "${BASH_SOURCE[0]}" == "${0}" ]]; then
    source "${SCRIPT_DIR}/log_utils.sh"
    source "${SCRIPT_DIR}/env_utils.sh"
    source "${SCRIPT_DIR}/ssh-utils.sh"
    
    show_usage() {
        echo "使用方法: $0 <环境> <版本>"
        echo "示例: $0 prod 1.0.0"
        exit 1
    }
    
    [ "$#" -lt 2 ] && show_usage
    
    ENV=$1
    VERSION=$2
    
    load_env "$ENV" || exit 1
    validate_deployment "$ENV" "$VERSION"
fi

# 验证部署
validate_deployment() {
    local env=$1
    local version=$2
    
    log_info "验证部署状态..."
    
    # 检查容器状态
    if ! ssh_execute "${SERVER_USER}@${SERVER_IP}" "docker ps --format '{{.Names}} {{.Status}}' | grep book-store"; then
        log_error "未找到运行中的服务容器"
        return 1
    fi
    
    # 可以添加更多验证步骤，如：
    # - 健康检查接口调用
    if ! check_service_health "${env}" "server"; then
        log_error "服务健康检查失败"
        return 1
    fi
    # - 日志检查
    # - 数据库连接验证
    
    return 0
}


# 检查服务健康状态
check_service_health() {
    local env=$1
    local service=$2
    local max_retries=${3:-${MAX_RETRY_ATTEMPTS}}
    local retry_count=0
    
    while [ $retry_count -lt $max_retries ]; do
        if curl -s "${HEALTH_CHECK_URL}" | grep -q "ok"; then
            return 0
        fi
        log_warn "服务 ${service} 健康检查失败，重试 $((retry_count + 1))/${max_retries}..."
        sleep ${HEALTH_CHECK_INTERVAL}
        retry_count=$((retry_count + 1))
    done
    
    return 1
}
