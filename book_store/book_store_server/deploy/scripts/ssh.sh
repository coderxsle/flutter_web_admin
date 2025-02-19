#!/bin/bash

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

# 导入必要的工具脚本
source "${SCRIPT_DIR}/log_utils.sh"
source "${SCRIPT_DIR}/env_utils.sh"

# 设置日志级别为DEBUG以显示更多信息
set_log_level "DEBUG"

# SSH连接状态文件，使用更安全的临时目录路径
SSH_STATUS_DIR="/tmp/book_store_ssh"
SSH_STATUS_FILE="${SSH_STATUS_DIR}/ssh_status_${USER:-$(whoami)}"

# 确保SSH状态文件目录存在
if [ ! -d "$SSH_STATUS_DIR" ]; then
    mkdir -p "$SSH_STATUS_DIR"
    # 设置目录权限为700（只有所有者可以读写执行）
    chmod 700 "$SSH_STATUS_DIR"
fi

# 初始化SSH选项变量
export SSH_OPTIONS=""

# 清理SSH连接
cleanup_ssh() {
    if [ -f "$SSH_STATUS_FILE" ]; then
        rm -f "$SSH_STATUS_FILE"
    fi
    unset SSH_OPTIONS
    # 清理控制连接
    ssh -O exit -o ControlPath=/tmp/%r@%h:%p "${SERVER_USER}@${SERVER_IP}" 2>/dev/null || true
}

# 清理指定 IP 的 known_hosts 记录
__clean_host_key() {
    local host="$1"
    if [ -f ~/.ssh/known_hosts ]; then
        ssh-keygen -R "$host" &>/dev/null || true
    fi
}

# 私有函数：设置SSH连接
__setup_ssh_connection() {
    local server_ip=${SERVER_IP}
    local server_user=${SERVER_USER}
    local server_port=${SERVER_PORT}
    local ssh_key_path=${SSH_KEY_PATH}
    
    log_info "开始设置SSH连接，服务器IP: ${server_ip}, 用户: ${server_user}, 端口: ${server_port}, 密钥路径: ${ssh_key_path}"
    
    # 检查是否已经建立了连接
    if [ -f "$SSH_STATUS_FILE" ]; then
        log_info "检测到已存在的SSH连接配置..."
        SSH_OPTIONS=$(cat "$SSH_STATUS_FILE")
        log_info "读取到的SSH连接配置：${SSH_OPTIONS}"
        if [ -z "${SSH_OPTIONS}" ]; then
            log_warn "SSH连接配置为空，需要重新建立连接"
            rm -f "$SSH_STATUS_FILE"
        else
            log_info "使用已存在的SSH连接配置"
            return 0
        fi
    fi
    
    # 清理主机密钥
    __clean_host_key "${server_ip}"
    
    # 设置SSH选项，添加连接复用配置
    SSH_OPTIONS="-o ControlMaster=auto \
            -o ControlPath=/tmp/ssh-%r@%h:%p \
            -o ControlPersist=10m \
            -o StrictHostKeyChecking=no \
            -o UserKnownHostsFile=/dev/null \
            -o ServerAliveInterval=60"
    
    # 先尝试使用SSH密钥
    __key_connect || return 1
    
    # 如果密钥连接失败，尝试使用密码连接
    log_info "尝试使用密码连接到 ${server_user}@${server_ip}..."
    log_info "====================================="
    log_info "现在请输入服务器密码："
    __password_connect || return 1
}


# 私有函数：密钥连接
__key_connect() {
    if [ -f "$ssh_key_path" ]; then
        log_info "正在使用SSH密钥进行连接服务器..."
        if ! ssh -i ${ssh_key_path} ${SSH_OPTIONS} "${SERVER_USER}@${SERVER_IP}" "echo '服务器连接已建立!'" 2>&1; then
            log_warn "SSH密钥连接失败，错误信息："
            ssh -i ${ssh_key_path} ${SSH_OPTIONS} "${SERVER_USER}@${SERVER_IP}" "echo test" 2>&1 || true
            log_info "将尝试使用密码连接..."
        else
            # 保存成功的连接配置
            echo "${SSH_OPTIONS} -i ${ssh_key_path}" > "$SSH_STATUS_FILE"
            log_info "SSH密钥连接已建立并保存"
            return 0
        fi
    else
        log_warn "未找到SSH密钥文件: ${ssh_key_path}"
        log_info "将尝试使用密码连接..."
    fi
}

# 私有函数：密码连接
__password_connect() {
    if ssh ${SSH_OPTIONS} "${SERVER_USER}@${SERVER_IP}" "echo '服务器连接已建立!'"; then
        # 保存成功的连接配置
        echo "${SSH_OPTIONS}" > "$SSH_STATUS_FILE"
        log_info "SSH密码连接已建立并保存"
        return 0
    else
        log_error "SSH连接失败！"
        log_error "请检查："
        log_error "1. 服务器地址是否正确: ${SERVER_IP}"
        log_error "2. 用户名是否正确: ${SERVER_USER}"
        log_error "3. 端口是否正确: ${SERVER_PORT}"
        log_error "4. 密码是否正确"
        return 1
    fi
}

# 私有函数：检查SSH连接状态
__check_ssh_connection() {
    # 添加调试信息
    log_debug "当前环境变量状态："
    log_debug "SERVER_IP=${SERVER_IP}"
    log_debug "SERVER_USER=${SERVER_USER}"
    log_debug "SERVER_PORT=${SERVER_PORT}"
    log_debug "SSH_KEY_PATH=${SSH_KEY_PATH}"
    
    # 检查SSH状态文件是否存在
    if [ ! -f "$SSH_STATUS_FILE" ]; then
        log_warn "未找到SSH连接配置文件，正在建立连接..."
        __setup_ssh_connection || return 1
    else
        SSH_OPTIONS=$(cat "$SSH_STATUS_FILE")
        log_info "读取到的SSH连接配置：${SSH_OPTIONS}"
        # 验证连接是否还有效
        if ! ssh ${SSH_OPTIONS} "${SERVER_USER}@${SERVER_IP}" "exit" 2>/dev/null; then
            log_warn "SSH连接已失效，需要重新建立连接"
            rm -f "$SSH_STATUS_FILE"
            __setup_ssh_connection || return 1
        fi
    fi
    log_info "SSH连接检查完成"
    return 0
}

# 公开函数：执行远程命令
ssh_execute() {
    local cmd=$1
    local output

    log_info "===== SSH Execute Debug ====="
    log_debug "开始执行ssh_execute，命令: ${cmd}"
    log_debug "当前环境变量状态："
    log_debug "SERVER_IP=${SERVER_IP}"
    log_debug "SERVER_USER=${SERVER_USER}"
    log_debug "SERVER_PORT=${SERVER_PORT}"
    log_info "==========================="
    
    # 检查并确保SSH连接可用
    if ! __check_ssh_connection; then
        log_info "===== SSH Connection Failed ====="
        log_error "SSH连接检查失败"
        return 1
    fi
    
    # 使用已建立的连接执行命令
    log_info "正在执行命令: ${cmd}"
    log_info "使用SSH选项: ${SSH_OPTIONS}"
    
    output=$(ssh ${SSH_OPTIONS} "${SERVER_USER}@${SERVER_IP}" "${cmd}" 2>&1)
    local status=$?
    
    if [ $status -ne 0 ]; then
        log_info "===== SSH Command Failed ====="
        log_error "命令执行失败，错误信息: ${output}"
        return 1
    fi
    
    # 只返回命令的输出，不包含日志信息
    printf "%s\n" "$output"
    return 0
}

# 公开函数：执行SCP传输
scp_transfer() {
    local src=$1
    local dest=$2
    
    # 检查并确保SSH连接可用
    if ! __check_ssh_connection; then
        log_error "SSH连接检查失败"
        return 1
    fi
    
    # 执行传输，使用已建立的SSH连接配置，并禁用进度条
    scp ${SSH_OPTIONS} -P ${SERVER_PORT} "${src}" "${dest}"
    return $?
}

# 如果直接运行此脚本
if [[ "${BASH_SOURCE[0]}" == "${0}" ]]; then
    show_usage() {
        echo "使用方法: $0 <环境>"
        echo "示例:"
        echo "  $0 prod 'env.production'"
        exit 1
    }
    
    [ "$#" -lt 1 ] && show_usage
    
    ENV=$1
    
    # 加载环境变量
    load_env "$ENV" || exit 1
    
    # 设置 SSH 连接
    # __setup_ssh_connection || exit 1
fi

