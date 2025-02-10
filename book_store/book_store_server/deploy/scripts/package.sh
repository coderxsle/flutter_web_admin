#!/bin/bash

# 设置脚本所在目录
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
PROJECT_ROOT="$(cd "${SCRIPT_DIR}/../../" && pwd)"

# 加载必要的工具脚本
source "${SCRIPT_DIR}/log-utils.sh"
source "${SCRIPT_DIR}/env-utils.sh"

# 打包镜像为本地文件
package_image() {
    local env="$1"      # 使用引号包裹
    local version="$2"  # 使用引号包裹
    
    # 构建完整的镜像标签
    local image_name="${REGISTRY}/${NAMESPACE}/${IMAGE_NAME}:${version}"
    
    log_info "检查镜像是否存在..."
    if ! docker image inspect "$image_name" >/dev/null 2>&1; then
        log_error "镜像 ${image_name} 不存在，请先构建镜像"
        log_info "当前系统中的相关镜像："
        docker images | grep -E "${REGISTRY}/${NAMESPACE}/${IMAGE_NAME}|${IMAGE_NAME}" || true
        log_warn "提示：请先运行 build.sh 构建镜像"
        log_warn "示例：./deploy/scripts/build.sh ${env} ${version}"
        return 1
    fi
    
    # 设置输出文件名
    local output_file="${IMAGE_NAME}-${env}-${version}.tar"
    # 保存镜像到文件
    log_info "开始保存镜像: ${image_name}"
    if ! docker save -o "${output_file}" "${image_name}"; then
        log_error "保存镜像失败"
        return 1
    fi
    
    log_info "镜像已保存成功: ${output_file}"
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
    
    # 打包镜像
    package_image "$ENV" "$VERSION"
fi
