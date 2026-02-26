#!/bin/bash

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

if [[ "${BASH_SOURCE[0]}" == "${0}" ]]; then
    source "${SCRIPT_DIR}/log_utils.sh"
    source "${SCRIPT_DIR}/env_utils.sh"
    
    show_usage() {
        echo "使用方法: $0 <环境> [保留版本数]"
        echo "示例: $0 prod 3"
        exit 1
    }
    
    [ "$#" -lt 1 ] && show_usage
    
    ENV=$1
    KEEP_VERSIONS=${2:-3}  # 默认保留3个版本
    
    # 加载环境变量
    load_env "$ENV" || exit 1
    
    # 清理旧镜像
    cleanup_old_images "$KEEP_VERSIONS"
fi

# 清理旧镜像
cleanup_old_images() {
    local keep_versions=${1:-3}
    log_info "清理旧镜像..."
    
    # 获取所有相关镜像
    local images=$(docker images "${REGISTRY}/${NAMESPACE}/${IMAGE_NAME}*" --format "{{.Repository}}:{{.Tag}}")
    
    # 按创建时间排序并保留最新的几个版本
    local count=$(echo "${images}" | wc -l)
    if [ $count -gt $keep_versions ]; then
        echo "${images}" | head -n $(($count - $keep_versions)) | xargs -r docker rmi
    fi
}