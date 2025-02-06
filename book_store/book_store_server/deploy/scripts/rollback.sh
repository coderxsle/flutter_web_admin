#!/bin/bash

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

if [[ "${BASH_SOURCE[0]}" == "${0}" ]]; then
    source "${SCRIPT_DIR}/log-utils.sh"
    source "${SCRIPT_DIR}/env-utils.sh"
    source "${SCRIPT_DIR}/ssh-utils.sh"
    
    show_usage() {
        echo "使用方法: $0 <环境> <版本>"
        echo "示例: $0 prod 1.0.0"
        exit 1
    }
    
    [ "$#" -lt 2 ] && show_usage
    
    ENV=$1
    VERSION=$2
    
    # 加载环境变量
    load_env "$ENV" || exit 1
    
    # 执行回滚
    rollback_deployment "$ENV" "$VERSION"
fi

# 回滚部署
rollback_deployment() {
    local env=$1
    local version=$2
    
    log_warn "正在回滚到版本 ${version}..."
    
    # 在这里实现回滚逻辑
    ssh_execute "${SERVER_USER}@${SERVER_IP}" "cd ${DEPLOY_PATH} && \
        docker compose down && \
        docker compose -f docker-compose.yaml.bak up -d"
}

