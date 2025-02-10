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
    log_info "检查系统架构..."
    check_required_tools || return 1
    
    # 获取本地架构
    LOCAL_ARCH=$(uname -m)
    case "${LOCAL_ARCH}" in
        x86_64)  LOCAL_ARCH="amd64" ;;
        aarch64) LOCAL_ARCH="arm64" ;;
    esac
    
    # 获取远程服务器架构
    log_info "获取远程服务器架构..."
    
    # 直接执行命令获取架构
    REMOTE_ARCH=$(ssh ${SSH_OPTIONS} "${SERVER_USER}@${SERVER_IP}" "uname -m" 2>/dev/null) || {
        log_error "无法获取远程服务器架构"
        return 1
    }
    
    if [ -z "$REMOTE_ARCH" ]; then
        log_error "获取远程架构失败"
        return 1
    fi
    
    case "${REMOTE_ARCH}" in
        x86_64)  REMOTE_ARCH="amd64" ;;
        aarch64) REMOTE_ARCH="arm64" ;;
        *)
            log_error "不支持的架构: ${REMOTE_ARCH}"
            return 1
            ;;
    esac
    
    log_info "本地架构: ${LOCAL_ARCH}"
    log_info "远程架构: ${REMOTE_ARCH}"
    
    # 设置构建平台
    if [ "${LOCAL_ARCH}" = "${REMOTE_ARCH}" ]; then
        export BUILD_PLATFORM="linux/${LOCAL_ARCH}"
    else
        export BUILD_PLATFORM="linux/${REMOTE_ARCH}"
        log_warn "本地架构与远程服务器架构不同，将使用 ${BUILD_PLATFORM} 进行构建"
    fi
    
    return 0
}



