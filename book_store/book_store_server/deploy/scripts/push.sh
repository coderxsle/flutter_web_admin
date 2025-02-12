#!/bin/bash

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

# 登录到华为云镜像仓库
login_to_registry() {
    log_info "正在登录到 ${HUAWEI_REGISTRY}..."
    log_info "使用账号: ${HUAWEI_REGISTRY_USERNAME}"
    
    if docker login ${HUAWEI_REGISTRY} \
        -u ${HUAWEI_REGISTRY_USERNAME} \
        -p ${HUAWEI_REGISTRY_PASSWORD}; then
        log_info "登录成功！"
        return 0
    else
        log_error "登录失败！"
        return 1
    fi
}

# 推送镜像
push_image() {
    local image_name=$1
    log_info "开始推送镜像: ${image_name}"
    docker push ${image_name}
}

# 初始化部署环境
init_deployment() {
    local env=$1
    
    # 创建必要的目录
    local dirs=(
        "${env}/logs"
        "${env}/config"
        "${env}/data"
    )
    
    for dir in "${dirs[@]}"; do
        if [ ! -d "$dir" ]; then
            mkdir -p "$dir" || log_warn "无法创建目录: $dir"
        fi
    done
}


if [[ "${BASH_SOURCE[0]}" == "${0}" ]]; then
    source "${SCRIPT_DIR}/log_utils.sh"
    source "${SCRIPT_DIR}/env_utils.sh"
    
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
    
    # 登录到镜像仓库
    # login_to_registry || exit 1
    
    # 构建完整的镜像标签
    local FULL_IMAGE_TAG="${REGISTRY}/${NAMESPACE}/${IMAGE_NAME}:${VERSION}"
    
    # 推送镜像
    push_image "$FULL_IMAGE_TAG"
fi



