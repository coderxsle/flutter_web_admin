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
    local env=$1
    local version=$2
    
    log_info "构建环境: $env"
    
    # 检查架构并设置构建平台
    check_architecture
    if [ $? -ne 0 ]; then
        log_error "架构检查失败"
        return 1
    fi
    
    log_info "开始构建镜像: ${IMAGE_NAME}_${env}-${version}"
    log_info "构建平台: ${BUILD_PLATFORM}"
    
    # 确保在正确的目录中构建
    cd "${PROJECT_ROOT}/.."
    
    # 检查必要的目录是否存在
    if [ ! -d "book_store_server" ] || [ ! -d "book_store_shared" ]; then
        log_error "找不到必要的源代码目录"
        return 1
    fi
    
    # 检查 Dockerfile 是否存在
    if [ ! -f "book_store_server/Dockerfile" ]; then
        log_error "Dockerfile 不存在: ${PROJECT_ROOT}/book_store_server/Dockerfile"
        return 1
    fi
    
    # 构建打包 Docker 镜像的命令
    local BUILD_CMD="docker"
    if [ "$NEED_CROSS_BUILD" = true ]; then
        # 使用项目目录下的持久化缓存位置
        local CACHE_DIR="${PROJECT_ROOT}/.docker-cache"
        mkdir -p "${CACHE_DIR}"
        
        # 确保缓存目录存在并初始化
        if [ ! -f "${CACHE_DIR}/index.json" ]; then
            log_info "[INFO] 初始化构建缓存..."
            log_warn '{"Layers":[]}' > "${CACHE_DIR}/index.json"
        fi
        
        # 使用新的缓存路径
        BUILD_CMD="docker buildx build --platform ${BUILD_PLATFORM} --load \
            --cache-from type=local,src=${CACHE_DIR} \
            --cache-to type=local,dest=${CACHE_DIR}-new,mode=max"
    else
        BUILD_CMD="docker build"
    fi
    
    # 执行构建
    ${BUILD_CMD} \
        -t ${REGISTRY}/${NAMESPACE}/${IMAGE_NAME}:${version} \
        -t ${REGISTRY}/${NAMESPACE}/${IMAGE_NAME}:latest \
        --build-arg ENV=${env} \
        -f book_store_server/Dockerfile \
        .
        
    local BUILD_STATUS=$?
    
    # 更新缓存（使用新路径）
    if [ "$NEED_CROSS_BUILD" = true ] && [ -d "${CACHE_DIR}-new" ]; then
        log_info "更新缓存..."
        rm -rf "${CACHE_DIR}"
        mv "${CACHE_DIR}-new" "${CACHE_DIR}"
    fi
    
    # 清理构建器
    if [ "$NEED_CROSS_BUILD" = true ]; then
        log_info "清理构建器..."
        docker buildx rm multiarch-builder || true
    fi
    
    # 返回到原始目录
    cd - > /dev/null
    
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
    
    # 使用环境变量中的配置
    build "$ENV" "$VERSION"
fi
