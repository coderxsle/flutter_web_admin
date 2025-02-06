#!/bin/bash

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

if [[ "${BASH_SOURCE[0]}" == "${0}" ]]; then
    source "${SCRIPT_DIR}/log-utils.sh"
    source "${SCRIPT_DIR}/env-utils.sh"
    
    show_usage() {
        echo "使用方法: $0 <环境> <命令>"
        echo "示例:"
        echo "  $0 prod 'docker ps'"
        echo "  $0 prod 'cd /opt/book_store && docker compose ps'"
        exit 1
    }
    
    [ "$#" -lt 2 ] && show_usage
    
    ENV=$1
    CMD=$2
    
    # 加载环境变量
    load_env "$ENV" || exit 1
    
    # 设置 SSH 连接
    setup_ssh_connection "$SERVER_IP" "$SERVER_USER" "$SERVER_PORT" "$SSH_KEY_PATH" || exit 1
    
    # 执行远程命令
    ssh_execute "${SERVER_USER}@${SERVER_IP}" "$CMD"
fi

# SSH相关的工具函数

# 设置SSH连接
setup_ssh_connection() {
    local server_ip=$1
    local server_user=$2
    local server_port=$3
    local ssh_key_path=$4
    
    # 检查SSH密钥文件是否存在
    if [ ! -f "$ssh_key_path" ]; then
        log_error "SSH密钥文件不存在: $ssh_key_path"
        return 1
    fi
    
    # 设置SSH选项
    export SSH_OPTIONS="-i ${ssh_key_path} -p ${server_port} -o StrictHostKeyChecking=no"
    
    # 测试SSH连接
    log_info "正在与云端服务器建立 SSH 连接..."
    if ! ssh ${SSH_OPTIONS} "${server_user}@${server_ip}" "echo '连接已建立'"; then
        log_error "SSH连接失败"
        return 1
    fi
    
    return 0
}

# 清理SSH连接
cleanup_ssh() {
    unset SSH_OPTIONS
}

# 执行远程命令
ssh_execute() {
    local host=$1
    local cmd=$2
    ssh $SSH_OPTIONS "${host}" "${cmd}"
    return $?
} 