#!/bin/bash
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

# 导入必要的工具脚本
source "${SCRIPT_DIR}/log_utils.sh"
source "${SCRIPT_DIR}/env_utils.sh"

# SSH连接状态文件路径
SSH_STATUS_DIR="/tmp/book_store_ssh"
SSH_STATUS_FILE="${SSH_STATUS_DIR}/ssh_status_${USER:-$(whoami)}"

# 清理SSH连接
cleanup_ssh() {
    log_info "开始清理SSH连接..."
    
    # 检查并读取SSH状态文件
    if [ -f "$SSH_STATUS_FILE" ]; then
        log_info "找到SSH状态文件，准备清理连接..."
        SSH_OPTIONS=$(cat "$SSH_STATUS_FILE")
        
        # 关闭控制连接
        log_info "关闭SSH控制连接..."
        ssh -O exit -o ControlPath=/tmp/ssh-%r@%h:%p "${SERVER_USER}@${SERVER_IP}" 2>/dev/null || true
        
        # 删除状态文件
        log_info "删除SSH状态文件..."
        rm -f "$SSH_STATUS_FILE"
        
        # 清理环境变量
        unset SSH_OPTIONS
        
        log_info "SSH连接清理完成"
    else
        log_info "未找到SSH状态文件，无需清理"
    fi
}

# 如果直接运行此脚本
if [[ "${BASH_SOURCE[0]}" == "${0}" ]]; then
    # 加载环境变量
    ENV=${1:-"prod"}  # 默认使用prod环境
    load_env "$ENV" || exit 1
    
    # 执行清理
    cleanup_ssh
fi