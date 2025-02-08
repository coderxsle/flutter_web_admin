#!/bin/bash

# 系统相关的工具函数
# 检查必需的工具
check_required_tools() {
    local tools=("docker" "curl" "jq" "sed" "ssh")
    for tool in "${tools[@]}"; do
        if ! command -v $tool &> /dev/null; then
            log_error "命令 '$tool' 未找到，请先安装"
            return 1
        fi
    done
    
    # 检查 Docker 版本
    DOCKER_VERSION=$(docker version --format '{{.Server.Version}}' 2>/dev/null)
    if [ $? -eq 0 ]; then
        # 比较版本号
        if [ "$(printf '%s\n' "19.03" "$DOCKER_VERSION" | sort -V | head -n1)" != "$DOCKER_VERSION" ]; then
            log_info "Docker 版本 ($DOCKER_VERSION) 支持多架构构建"
        else
            log_warn "Docker 版本 ($DOCKER_VERSION) 可能不支持多架构构建，建议升级到 19.03 或更高版本"
        fi
    else
        log_error "无法获取 Docker 版本信息"
        return 1
    fi
    
    return 0
} 

# 验证 SSH 认证方式
check_ssh_key_or_password() {
    if [ ! -f "$SSH_KEY_PATH" ]; then
        if [ -z "$SSH_PASSWORD" ]; then
            log_error "SSH密钥文件不存在，且未设置 SSH_PASSWORD"
            log_error "请提供以下任一认证方式:"
            log_error "1. 设置正确的 SSH_KEY_PATH (当前: $SSH_KEY_PATH)"
            log_error "2. 在环境变量中设置 SSH_PASSWORD"
            return 1
        else
            log_warn "SSH密钥文件不存在，将使用密码认证"
            export USE_SSH_PASSWORD=true
        fi
    else
        export USE_SSH_PASSWORD=false
        log_info "将使用 SSH 密钥认证"
    fi
}

# 检查并获取系统架构
check_architecture() {
    check_required_tools
    
    log_info "检查系统架构..."
    # 获取本地架构
    LOCAL_ARCH=$(uname -m)
    case "$LOCAL_ARCH" in
        "x86_64")  LOCAL_ARCH="amd64" ;;
        "aarch64") LOCAL_ARCH="arm64" ;;
    esac
    
    # 获取服务器架构
    log_info "获取远程服务器架构..."
    check_ssh_key_or_password
    REMOTE_ARCH=$(ssh_execute "${SERVER_USER}@${SERVER_IP}" "uname -m")
    case "$REMOTE_ARCH" in
        "x86_64")  REMOTE_ARCH="amd64" ;;
        "aarch64") REMOTE_ARCH="arm64" ;;
    esac
    log_info "本地架构: ${LOCAL_ARCH}"
    log_info "远程服务器架构: ${REMOTE_ARCH}"

    # 只有在架构不同时才设置交叉编译
    if [ "$LOCAL_ARCH" != "$REMOTE_ARCH" ]; then
        log_warn "本地与服务器架构不同，将自动启用支持多架构的构建器..."
        export NEED_CROSS_BUILD=true
        export BUILD_PLATFORM="linux/${REMOTE_ARCH}"
        
        # 创建并配置构建器
        log_info "清理已存在的构建器..."
        docker buildx rm multiarch-builder 2>/dev/null || true
        
        log_info "创建并启动支持多架构的构建器..."
        docker buildx create --name multiarch-builder --platform "linux/${REMOTE_ARCH}" --use
        docker buildx inspect --bootstrap
    else
        log_info "本地与服务器架构相同，使用本地架构构建"
        export NEED_CROSS_BUILD=false
        export BUILD_PLATFORM="linux/${LOCAL_ARCH}"
    fi
    
    return 0
}



