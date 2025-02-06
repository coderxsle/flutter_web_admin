#!/bin/bash

# 设置当前工作目录
cd "$(dirname "$0")"

# 首先加载日志工具
source "scripts/log-utils.sh"
source "scripts/env-utils.sh"
source "scripts/ssh-utils.sh"
source "scripts/docker-utils.sh"
source "scripts/deploy-utils.sh"

# 设置日志级别（可以通过环境变量覆盖）
LOG_LEVEL=${DEPLOY_LOG_LEVEL:-"INFO"}
set_log_level "$LOG_LEVEL"

# 加载其他工具脚本
for script in scripts/*.sh; do
    if [[ "$script" != *"log-utils.sh" ]]; then
        log_debug "加载脚本: $script"
        source "$script"
    fi
done

# 显示帮助信息
show_usage() {
    echo "使用方法: $0 [环境] [版本] [选项]"
    echo "环境:"
    echo "  prod      生产环境"
    echo "  test      测试环境"
    echo "  staging   预发布环境"
    echo "选项:"
    echo "  --force   强制重新部署"
    echo "  --help    显示帮助信息"
    echo "示例:"
    echo "  $0 prod 1.0.0"
    echo "  $0 test 1.0.0 --force"
    exit 1
}

# 初始化部署环境
init_deployment() {
    local env=$1
    
    # 设置基本变量
    IMAGE_NAME="book_store_server"
    IMAGE_TAG="${env}-${VERSION}"
    FULL_IMAGE_NAME="${IMAGE_NAME}:${IMAGE_TAG}"
    
    # 创建必要的目录
    mkdir -p "${env}/logs" "${env}/config" "${env}/data"
    
    log_info "初始化部署环境完成"
}

# 部署前检查
pre_deploy_check() {
    local env=$1
    local force=$2
    
    # 验证环境
    if [[ "$env" != "prod" && "$env" != "test" && "$env" != "staging" ]]; then
        log_error "无效的环境: $env"
        return 1
    fi
    
    # 检查必需工具
    check_required_tools || return 1
    
    # 加载并验证环境变量
    if ! load_env "$env"; then
        if [ "$force" != true ]; then
            log_error "环境变量加载失败"
            return 1
        else
            log_warn "环境变量加载失败，但由于使用了 --force 参数，继续执行"
        fi
    fi
    
    # 显示环境变量配置
    show_env_vars
    
    # 初始化部署环境
    init_deployment "$env" || return 1
    
    return 0
}

# 构建和推送镜像
build_and_push_image() {
    local env=$1
    local version=$2
    
    log_info "是否需要重新构建镜像? (输入1重新构建,其他跳过构建)"
    read -r BUILD_CHOICE
    
    if [ "$BUILD_CHOICE" = "1" ]; then
        build_image "$env" "$version" "$REGISTRY" "$NAMESPACE" "$IMAGE_NAME" || return 1
    else
        log_info "跳过镜像构建"
    fi
    
    return 0
}


# 主要部署逻辑
main() {
    local env=$1
    local version=$2
    local force=$3
    
    log_info "开始部署 ${env} 环境，版本 ${version}"
    
    # 部署前检查
    pre_deploy_check "$env" "$force" || exit 1
    
    # 构建和推送镜像
    build_and_push_image "$env" "$version" || exit 1

    # 保存镜像到本地文件
    save_image "$env" "$version" "$registry" "$namespace" "$image_name"
    
    # 部署到服务器
    deploy_to_server "$env" "$version" "$IMAGE_NAME" || exit 1
    
    # 验证部署
    if ! validate_deployment "$env" "$version"; then
        if [ "$force" != true ]; then
            log_error "部署验证失败，开始回滚..."
            rollback_deployment "$env" || exit 1
        else
            log_warn "部署验证失败，但由于使用了 --force 参数，继续执行"
        fi
    fi
    
    log_info "部署完成"
    show_deployment_info "$FULL_IMAGE_NAME" "$env" "$version"
}

# 处理命令行参数
[ "$#" -lt 2 ] && show_usage
[ "$1" = "--help" ] && show_usage

ENV=$1
VERSION=$2
FORCE=false

for arg in "$@"; do
    case $arg in
        --force) FORCE=true ;;
    esac
done

# 执行主函数
main "$ENV" "$VERSION" "$FORCE"

# 设置 SSH 连接复用
SSH_CONTROL_PATH="/tmp/ssh-control-%r@%h:%p"
SSH_OPTIONS="-o ControlMaster=auto -o ControlPath=${SSH_CONTROL_PATH} -o ControlPersist=yes"

# 验证环境
if [ "$ENV" != "prod" ] && [ "$ENV" != "test" ] && [ "$ENV" != "staging" ]; then
    echo "Invalid environment. Use 'prod', 'test', or 'staging'"
    exit 1
fi

# 加载环境变量
load_env "$ENV"

# 初始化部署环境
init_deployment "${ENV}"

# 验证环境配置
if ! validate_environment "${ENV}"; then
    log_error "环境配置验证失败"
    exit 1
fi

# 备份数据库
if [ "${DB_BACKUP_ENABLED}" = true ]; then
    if ! backup_database "${ENV}"; then
        if [ "${FORCE}" != true ]; then
            log_error "数据库备份失败，部署终止"
            exit 1
        else
            log_warn "数据库备份失败，但由于使用了 --force 参数，继续部署"
        fi
    fi
fi

# 设置镜像名称和标签
IMAGE_NAME="book_store_server"
IMAGE_TAG="${ENV}-${VERSION}"
FULL_IMAGE_NAME="${IMAGE_NAME}:${IMAGE_TAG}"
TEMP_TAR="${IMAGE_NAME}_${ENV}-${VERSION}.tar"

# 清理旧镜像
# cleanup_old_images "${KEEP_IMAGES}"

# 询问是否需要重新构建镜像
log_info "是否需要重新构建镜像? (输入1重新构建,其他跳过构建)"
read -r BUILD_CHOICE

# 传输配置文件到服务器
log_info "传输配置文件到服务器..."
for config_file in "docker-compose.yaml" "nginx.conf"; do
    log_info "传输 ${config_file}..."
    if ! scp ${SSH_OPTIONS} "${ENV}/${config_file}" "${SERVER_USER}@${SERVER_IP}:${DEPLOY_PATH}/"; then
        log_error "配置文件 ${config_file} 传输失败"
        exit 1
    fi
done

# 传输镜像到华为云服务器
log_info "传输镜像到华为云服务器..."
log_info "准备传输文件 ${TEMP_TAR} 到 ${SERVER_USER}@${SERVER_IP}:${DEPLOY_PATH}/"

if ! scp ${SSH_OPTIONS} "${TEMP_TAR}" "${SERVER_USER}@${SERVER_IP}:${DEPLOY_PATH}/"; then
    log_error "镜像传输失败"
    exit 1
fi

# 在远程服务器上加载和运行镜像
log_info "在远程服务器上部署镜像..."
ssh ${SSH_OPTIONS} "${SERVER_USER}@${SERVER_IP}" "cd ${DEPLOY_PATH} && \
    docker load -i ${TEMP_TAR} && \
    rm ${TEMP_TAR} && \
    docker tag ${IMAGE_NAME}:${IMAGE_TAG} ${IMAGE_NAME}:latest && \
    docker compose -f docker-compose.yaml down && \
    IMAGE_NAME=\"${IMAGE_NAME}\" \
    VERSION=\"${VERSION}\" \
    POSTGRES_DB=\"${POSTGRES_DB}\" \
    POSTGRES_USER=\"${POSTGRES_USER}\" \
    POSTGRES_PASSWORD=\"${POSTGRES_PASSWORD}\" \
    REDIS_PASSWORD=\"${REDIS_PASSWORD}\" \
    DOMAIN=\"${DOMAIN}\" \
    REGISTRY=\"${REGISTRY}\" \
    NAMESPACE=\"${NAMESPACE}\" \
    DEPLOY_PATH=\"${DEPLOY_PATH}\" \
    docker compose -f docker-compose.yaml up -d"

# 等待服务启动
log_info "等待服务启动..."
sleep 10  # 给服务一些启动时间

# 记录成功部署
log_deployment_history "${ENV}" "${VERSION}" "SUCCESS"
send_deployment_notification "${ENV}" "${VERSION}" "部署成功"

# 显示部署信息
show_deployment_info "${FULL_IMAGE_NAME}" "${ENV}" "${VERSION}"

echo "部署完成！"
echo "镜像: ${FULL_IMAGE_NAME}"
echo "环境: ${ENV}"
echo "版本: ${VERSION}"

# 检查远程容器状态
ssh ${SSH_OPTIONS} "${SERVER_USER}@${SERVER_IP}" "docker ps --filter name=book-store"

# 在脚本结束时清理连接
cleanup() {
    log_info "清理 SSH 连接..."
    ssh ${SSH_OPTIONS} -O exit "${SERVER_USER}@${SERVER_IP}"
}

# 注册清理函数
trap cleanup EXIT

build_image() {
    echo -e "[INFO] 构建环境: $ENV"
    
    # 添加架构检查
    check_architecture
    ARCH_CHECK_RESULT=$?
    
    echo -e "[INFO] 开始构建镜像: ${IMAGE_NAME}_${ENV}-${VERSION}.tar"
    echo -e "[INFO] 构建目录: ${PROJECT_ROOT}"
    
    # 使用检测到的平台进行构建
    docker buildx create --use
    docker buildx build --platform ${BUILD_PLATFORM} \
        -t ${REGISTRY}/${NAMESPACE}/${IMAGE_NAME}:${VERSION} \
        -f ${PROJECT_ROOT}/Dockerfile \
        --build-arg ENV=${ENV} \
        ${PROJECT_ROOT}
        
    if [ $? -ne 0 ]; then
        echo -e "[ERROR] 镜像构建失败"
        exit 1
    fi
    
    log_info "镜像构建成功"
}







