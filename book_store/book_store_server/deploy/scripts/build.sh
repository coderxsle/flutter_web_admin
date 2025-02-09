#!/bin/bash

# 设置脚本所在目录
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
# 修改 PROJECT_ROOT 指向仓库根目录，假设 build.sh 位于 repo-root/book_store_server/deploy/scripts/
PROJECT_ROOT="$(cd "${SCRIPT_DIR}/../../.." && pwd)"

# 加载必要的工具脚本
source "${SCRIPT_DIR}/env-utils.sh"
source "${SCRIPT_DIR}/log-utils.sh"
source "${SCRIPT_DIR}/ssh.sh"
source "${SCRIPT_DIR}/system-utils.sh"

# 构建函数定义
build() {
    local env="$1"      # 使用引号包裹
    local version="$2"  # 使用引号包裹
    
    log_info "构建环境: $env 构建版本: $version"
    
    # 检查架构并设置构建平台
    check_architecture
    if [ $? -ne 0 ]; then
        log_error "架构检查失败"
        return 1
    fi
    
    # 设置缓存目录
    local CACHE_DIR="${PROJECT_ROOT}/.docker-cache"
    mkdir -p "${CACHE_DIR}"
    
    # 正确初始化缓存文件
    if [ ! -f "${CACHE_DIR}/index.json" ]; then
        log_info "初始化构建缓存..."
        echo '{"Layers":[]}' > "${CACHE_DIR}/index.json"  # 移除 -e 和颜色代码
    fi
    
    # 构建镜像
    log_info "开始构建镜像: ${IMAGE_NAME}_${env}-${version}"
    
    # 使用 buildx
    docker buildx create --use --name multiarch-builder || true
    
    # 构建命令
    docker buildx build \
        --platform ${BUILD_PLATFORM} \
        --load \
        --cache-from "type=local,src=${CACHE_DIR}" \
        --cache-to "type=local,dest=${CACHE_DIR}-new,mode=max" \
        -t ${REGISTRY}/${NAMESPACE}/${IMAGE_NAME}:${version} \
        -t ${REGISTRY}/${NAMESPACE}/${IMAGE_NAME}:latest \
        --build-arg ENV=${env} \
        -f ${PROJECT_ROOT}/Dockerfile \
        ${PROJECT_ROOT}
        
    local BUILD_STATUS=$?
    
    # 更新缓存
    if [ $BUILD_STATUS -eq 0 ] && [ -d "${CACHE_DIR}-new" ]; then
        log_info "更新缓存..."
        rm -rf "${CACHE_DIR}"
        mv "${CACHE_DIR}-new" "${CACHE_DIR}"
    fi
    
    # 清理构建器
    log_info "清理构建器..."
    docker buildx rm multiarch-builder || true
    
    if [ $BUILD_STATUS -ne 0 ]; then
        log_error "镜像构建失败"
        return 1
    fi
    
    log_info "镜像构建成功"
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
