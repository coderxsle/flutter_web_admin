#!/bin/bash
# 设置脚本所在目录
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
PROJECT_ROOT="$(cd "${SCRIPT_DIR}/../.." && pwd)"
DEPLOY_SCRIPTS_DIR="${SCRIPT_DIR}"

# 加载日志工具
source "${SCRIPT_DIR}/log-utils.sh"

# 环境变量相关的工具函数
load_env() {
    local env=$1
    
    # 环境名称映射
    local env_file_name
    case "$env" in
        "prod")
            env_file_name=".env.production"
            ;;
        "test")
            env_file_name=".env.test"
            ;;
        "staging")
            env_file_name=".env.staging"
            ;;
        *)
            log_error "未知的环境: $env"
            return 1
            ;;
    esac
    
    local env_file="${PROJECT_ROOT}/env/${env_file_name}"
    
    log_debug "脚本目录: ${DEPLOY_SCRIPTS_DIR}"
    log_debug "项目根目录: ${PROJECT_ROOT}"
    log_debug "环境文件路径: ${env_file}"
    
    # 检查环境文件是否存在
    if [ ! -f "$env_file" ]; then
        log_error "环境变量文件不存在: $env_file"
        return 1
    fi
    
    # 导出所有变量
    set -a
    source "$env_file"
    set +a
    
    # 验证环境变量
    validate_env_vars || return 1
    
    return 0
}

validate_env_vars() {
    local required_vars=(
        "POSTGRES_DB"
        "POSTGRES_USER"
        "POSTGRES_PASSWORD"
        "REDIS_PASSWORD"
        "SERVICE_SECRET"
        "HUAWEI_REGISTRY_USERNAME"
        "HUAWEI_REGISTRY_PASSWORD"
        "SERVER_IP"
        "SERVER_USER"
        "SERVER_PORT"
        "DEPLOY_PATH"
        "SSH_KEY_PATH"
    )
    
    local missing_vars=()
    for var in "${required_vars[@]}"; do
        if [ -z "${!var}" ]; then
            missing_vars+=("$var")
        fi
    done
    
    if [ ${#missing_vars[@]} -ne 0 ]; then
        log_error "缺少以下必需的环境变量:"
        for var in "${missing_vars[@]}"; do
            log_error "  - $var"
        done
        return 1
    fi
    
    # 验证 SSH 密钥文件
    if [ ! -f "$SSH_KEY_PATH" ]; then
        log_error "SSH密钥文件不存在，请在环境变量中设置正确的 SSH_KEY_PATH"
        log_error "当前设置的路径: $SSH_KEY_PATH"
        return 1
    fi
    
    log_info "环境变量验证通过"
    return 0
}

# 显示当前环境变量
show_env_vars() {
    log_info "当前环境变量配置:"
    log_info "  项目根目录: ${PROJECT_ROOT}"
    log_info "  部署路径: ${DEPLOY_PATH}"
    log_info "  服务器信息:"
    log_info "    IP: ${SERVER_IP}"
    log_info "    用户: ${SERVER_USER}"
    log_info "    端口: ${SERVER_PORT}"
    log_info "    SSH密钥: ${SSH_KEY_PATH}"
    log_info "  镜像仓库信息:"
    log_info "    仓库: ${REGISTRY}"
    log_info "    命名空间: ${NAMESPACE}"
} 