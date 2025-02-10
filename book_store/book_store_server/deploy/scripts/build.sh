#!/bin/bash

# 设置脚本所在目录
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
# 加载必要的工具脚本
source "${SCRIPT_DIR}/env-utils.sh"
source "${SCRIPT_DIR}/log-utils.sh"
source "${SCRIPT_DIR}/ssh.sh"
source "${SCRIPT_DIR}/system-utils.sh"

# 构建函数定义
build() {
    local env="$1"
    local version="$2"
    
    log_info "构建环境: $env 构建版本: $version"
    
    # 检查架构并设置构建平台
    check_architecture
    if [ $? -ne 0 ]; then
        log_error "架构检查失败"
        return 1
    fi

    # 记录开始时间
    local start_time=$(date +%s)
    
    # 设置缓存目录
    local CACHE_DIR="${PROJECT_ROOT}/.docker-cache"
    mkdir -p "${CACHE_DIR}"
    
    # 构建镜像
    log_info "开始构建镜像: ${FULL_IMAGE_NAME}:${version}"
    
    # 清理并重新创建 buildx 构建器
    docker buildx rm multiarch-builder 2>/dev/null || true
    docker buildx create --name multiarch-builder --use || {
        log_error "创建构建器失败"
        return 1
    }
    
    # 根据缓存目录是否为空决定是否使用缓存
    local cache_options=""
    if [ -f "${CACHE_DIR}/index.json" ] && [ -s "${CACHE_DIR}/index.json" ]; then
        log_info "使用已存在的构建缓存..."
        cache_options="--cache-from type=local,src=${CACHE_DIR}"
    fi
    
    # 启用内联缓存，避免重复拉取基础镜像，使用主机网络加快构建
    docker buildx build \
        --platform ${BUILD_PLATFORM} \
        --load \
        ${cache_options} \
        --cache-to "type=local,dest=${CACHE_DIR}-new,mode=max" \
        --build-arg BUILDKIT_INLINE_CACHE=1 \
        --pull=false \
        --network=host \
        -t "${FULL_IMAGE_NAME}:${version}" \
        --build-arg ENV="${env}" \
        -f "${PROJECT_ROOT}/Dockerfile" \
        "${PROJECT_ROOT}/.."
        
    local BUILD_STATUS=$?
    
    # 更新缓存
    if [ $BUILD_STATUS -eq 0 ] && [ -d "${CACHE_DIR}-new" ]; then
        log_info "更新缓存..."
        rm -rf "${CACHE_DIR}"
        mv "${CACHE_DIR}-new" "${CACHE_DIR}"
    fi
    
    # 清理构建器
    log_info "清理构建器..."
    docker buildx rm multiarch-builder 2>/dev/null || true
    
    if [ $BUILD_STATUS -ne 0 ]; then
        log_error "镜像构建失败"
        return 1
    fi
    
    # 计算并显示耗时
    local end_time=$(date +%s)
    local duration=$((end_time - start_time))
    local minutes=$((duration / 60))
    local seconds=$((duration % 60))
    
    log_info "镜像构建成功"
    log_info "总耗时: ${minutes}分${seconds}秒"
    
    return 0
}

# 主程序入口
if [[ "${BASH_SOURCE[0]}" == "${0}" ]]; then
    show_usage() {
        log_warn "使用方法: $0 <环境> <版本>"
        log_info "示例: $0 prod 1.0.0"
        exit 1
    }
    
    [ "$#" -lt 2 ] && show_usage
    
    ENV=$1
    VERSION=$2
    
    # 加载环境变量
    load_env "$ENV" || exit 1

    build "$ENV" "$VERSION"
fi
