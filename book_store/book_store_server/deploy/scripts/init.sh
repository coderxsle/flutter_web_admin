#!/bin/bash

# 设置基础路径
export SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
export PROJECT_ROOT="$(cd "${SCRIPT_DIR}/../.." && pwd)"
export DEPLOY_SCRIPTS_DIR="${SCRIPT_DIR}"

# 加载基础工具
source "${SCRIPT_DIR}/log-utils.sh"

# 检查必需的工具
check_required_tools() {
    local tools=("docker" "curl" "ssh" "scp" "jq")
    local missing_tools=()
    
    for tool in "${tools[@]}"; do
        if ! command -v "$tool" &> /dev/null; then
            missing_tools+=("$tool")
        fi
    done
    
    if [ ${#missing_tools[@]} -ne 0 ]; then
        log_error "缺少以下必需工具:"
        for tool in "${missing_tools[@]}"; do
            log_error "  - $tool"
        done
        return 1
    fi
    
    return 0
}

# 初始化部署环境
init_deploy_env() {
    local env=$1
    
    # 检查工具
    check_required_tools || return 1
    
    # 创建必要的目录
    mkdir -p "${PROJECT_ROOT}/deploy/${env}/logs"
    mkdir -p "${PROJECT_ROOT}/deploy/${env}/config"
    mkdir -p "${PROJECT_ROOT}/deploy/${env}/data"
    
    return 0
}

# 如果直接运行此脚本
if [[ "${BASH_SOURCE[0]}" == "${0}" ]]; then
    show_usage() {
        echo "使用方法: $0 <环境>"
        echo "示例: $0 prod"
        exit 1
    }
    
    [ "$#" -lt 1 ] && show_usage
    
    ENV=$1
    init_deploy_env "$ENV"
fi 