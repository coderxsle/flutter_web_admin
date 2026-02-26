#!/bin/bash

# 设置脚本所在目录
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
# 加载必要的工具脚本
source "${SCRIPT_DIR}/env_utils.sh"
source "${SCRIPT_DIR}/log_utils.sh"
source "${SCRIPT_DIR}/ssh.sh"
source "${SCRIPT_DIR}/system_utils.sh"

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
    
    # 设置缓存目录，加入平台信息
    local platform_suffix="${BUILD_PLATFORM//\//-}"  # 将 linux/amd64 转换为 linux-amd64
    local CACHE_DIR="${HOME}/.docker/cache/${platform_suffix}"
    mkdir -p "${CACHE_DIR}"
    
    # 获取当前缓存的哈希值
    local current_cache_hash=""
    if [ -f "${CACHE_DIR}/index.json" ]; then
        current_cache_hash=$(sha256sum "${CACHE_DIR}/index.json" | cut -d' ' -f1)
    fi
    
    log_info "开始构建镜像: ${IMAGE_NAME}:${version} (平台: ${BUILD_PLATFORM})"
    
    # 清理并重新创建 buildx 构建器
    docker buildx rm multiarch-builder 2>/dev/null || true
    docker buildx create --name multiarch-builder --use || {
        log_error "创建构建器失败"
        return 1
    }
    
    # 根据缓存目录是否为空决定是否使用缓存
    local cache_options=""
    if [ -f "${CACHE_DIR}/index.json" ] && [ -s "${CACHE_DIR}/index.json" ]; then
        log_info "使用已存在的构建缓存 (${platform_suffix})..."
        cache_options="--cache-from type=local,src=${CACHE_DIR},mode=max"
    fi

    # 检查 QEMU 镜像是否已存在
    if [ -z "$(docker images -q multiarch/qemu-user-static:latest 2>/dev/null)" ]; then
        log_info "multiarch/qemu-user-static 镜像不存在，正在拉取..."
        docker pull multiarch/qemu-user-static:latest || {
            log_error "拉取 multiarch/qemu-user-static 失败"
            return 1
        }
    else
        
        log_info "multiarch/qemu-user-static 已存在，跳过拉取及安装!"
    fi
    # 运行 QEMU 以注册二进制格式支持
    log_info "运行 multiarch/qemu-user-static 以确保 QEMU 正确注册..."
    docker run --rm --privileged multiarch/qemu-user-static --reset -p yes || {
        log_error "无法启动 multiarch/qemu-user-static"
        return 1
    }


    # 检查 binfmt 镜像是否已存在
    if [ -z "$(docker images -q tonistiigi/binfmt:latest 2>/dev/null)" ]; then
        log_info "tonistiigi/binfmt 镜像不存在，正在拉取..."
        docker pull tonistiigi/binfmt:latest || {
            log_error "拉取 tonistiigi/binfmt 失败"
            return 1
        }
    else 
        log_info "tonistiigi/binfmt 已存在，跳过拉取及安装!"
    fi
    # 运行 binfmt 以注册多架构支持
    log_info "运行 tonistiigi/binfmt 以确保多架构支持..."
    docker run --rm --privileged tonistiigi/binfmt --install all || {
        log_error "无法安装 binfmt"
        return 1
    }


    # 启用内联缓存，避免重复拉取基础镜像
    docker buildx build \
        --platform ${BUILD_PLATFORM} \
        --output type=docker \
        ${cache_options} \
        --cache-from "type=local,src=${CACHE_DIR}" \
        --cache-to "type=local,dest=${CACHE_DIR}-new,mode=max" \
        --build-arg BUILDKIT_INLINE_CACHE=1 \
        --pull=false \
        --network=host \
        -t "${IMAGE_NAME}:${version}" \
        --build-arg ENV="${env}" \
        -f "${PROJECT_ROOT}/Dockerfile" \
        "${PROJECT_ROOT}/.."

    local BUILD_STATUS=$?
    
    # 更新缓存
    if [ $BUILD_STATUS -eq 0 ] && [ -d "${CACHE_DIR}-new" ]; then
        # 检查新缓存的哈希值
        local new_cache_hash=""
        if [ -f "${CACHE_DIR}-new/index.json" ]; then
            new_cache_hash=$(sha256sum "${CACHE_DIR}-new/index.json" | cut -d' ' -f1)
        fi
        
        # 比较缓存哈希值
        if [ "$current_cache_hash" != "$new_cache_hash" ]; then
            log_info "检测到缓存内容变化，更新缓存 (${platform_suffix})..."
            rm -rf "${CACHE_DIR}"
            mv "${CACHE_DIR}-new" "${CACHE_DIR}"
        else
            log_info "缓存内容未变化，跳过更新"
            rm -rf "${CACHE_DIR}-new"
        fi
    fi
    
    # 清理构建器
    # log_info "清理构建器..."
    # docker buildx rm multiarch-builder 2>/dev/null || true
    
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
