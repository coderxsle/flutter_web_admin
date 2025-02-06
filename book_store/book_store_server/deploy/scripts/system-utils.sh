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
    log_info "本地架构: ${LOCAL_ARCH}"
    
    # 获取服务器架构
    REMOTE_ARCH=$(ssh_execute "${SERVER_USER}@${SERVER_IP}" "uname -m")
    case "$REMOTE_ARCH" in
        "x86_64")  REMOTE_ARCH="amd64" ;;
        "aarch64") REMOTE_ARCH="arm64" ;;
    esac
    log_info "远程服务器架构: ${REMOTE_ARCH}"
    
    # 只有在架构不同时才设置交叉编译
    if [ "$LOCAL_ARCH" != "$REMOTE_ARCH" ]; then
        log_warn "本地与服务器架构不同，将使用多架构构建"
        export NEED_CROSS_BUILD=true
        export BUILD_PLATFORM="linux/${REMOTE_ARCH}"
        
        # 创建并配置构建器
        log_info "清理已存在的构建器..."
        docker buildx rm multiarch-builder 2>/dev/null || true
        
        log_info "创建多架构构建器..."
        docker buildx create --name multiarch-builder --platform "linux/${REMOTE_ARCH}" --use
        log_info "启动多架构构建器..."
        docker buildx inspect --bootstrap
    else
        log_info "本地与服务器架构相同，使用本地架构构建"
        export NEED_CROSS_BUILD=false
        export BUILD_PLATFORM="linux/${LOCAL_ARCH}"
    fi
    
    return 0
}



