#!/bin/bash

# 设置脚本所在目录
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

# 打包镜像为本地文件
save_image() {
    local env="$1"
    local version="$2"
    
    log_info "开始打包镜像..."
    
    # 构建完整的镜像标签
    local FULL_IMAGE_TAG="${REGISTRY}/${NAMESPACE}/${IMAGE_NAME}:${version}"
    local IMAGE_TAR="${IMAGE_NAME}_${env}-${version}.tar"
    
    # 保存镜像到文件
    log_info "保存镜像到文件: ${IMAGE_TAR}"
    if ! docker save -o "${IMAGE_TAR}" "${FULL_IMAGE_TAG}"; then
        log_error "保存镜像失败"
        return 1
    fi
    
    log_info "镜像已保存成功"
    return 0
} 

if [[ "${BASH_SOURCE[0]}" == "${0}" ]]; then
    source "${SCRIPT_DIR}/log-utils.sh"
    source "${SCRIPT_DIR}/env-utils.sh"
    
    show_usage() {
        echo "使用方法: $0 <环境> <版本>"
        echo "示例: $0 prod 1.0.0"
        exit 1
    }
    
    [ "$#" -lt 2 ] && show_usage
    
    ENV=$1
    VERSION=$2
    
    # 加载环境变量
    load_env "$ENV" || exit 1
    
    # 打包镜像
    save_image "$ENV" "$VERSION"
fi
