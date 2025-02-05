#!/bin/bash

# 设置当前工作目录
cd "$(dirname "$0")"

# 加载工具函数
source $(pwd)/deploy-utils.sh

# 检查必需的工具
check_required_tools

# 设置 SSH 连接复用
SSH_CONTROL_PATH="/tmp/ssh-control-%r@%h:%p"
SSH_OPTIONS="-o ControlMaster=auto -o ControlPath=${SSH_CONTROL_PATH} -o ControlPersist=yes"

# 建立主 SSH 连接
log_info "建立 SSH 连接..."
ssh ${SSH_OPTIONS} "${SERVER_USER}@${SERVER_IP}" "echo '连接已建立'"

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

# 检查参数
if [ "$#" -lt 2 ]; then
    show_usage
fi

# 处理帮助参数
for arg in "$@"; do
    if [ "$arg" = "--help" ]; then
        show_usage
    fi
done

ENV=$1
VERSION=$2
FORCE=false

# 参数检查
for arg in "$@"; do
    case $arg in
        --force)
            FORCE=true
            ;;
    esac
done

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

if [ "$BUILD_CHOICE" = "1" ]; then
    # 构建镜像
    if ! build_image "${TEMP_TAR}" "${ENV}"; then
        log_error "镜像构建失败"
        exit 1
    fi
else
    log_info "跳过镜像构建..."
    # 检查镜像文件是否存在
    if [ -f "${TEMP_TAR}" ]; then
        log_info "发现已有镜像文件: ${TEMP_TAR}"
        log_info "文件大小: $(ls -lh ${TEMP_TAR} | awk '{print $5}')"
    else
        log_error "镜像文件 ${TEMP_TAR} 不存在,请先构建镜像"
        exit 1
    fi
fi

# 保存镜像为tar文件
log_info "保存镜像为tar文件..."
CURRENT_DIR=$(pwd)
log_info "当前目录: ${CURRENT_DIR}"
log_info "将保存镜像到: ${CURRENT_DIR}/${TEMP_TAR}"

# 确保有写入权限
if ! touch "${TEMP_TAR}" 2>/dev/null; then
    log_error "无法在当前目录创建文件，请检查权限"
    exit 1
fi

# 修复这里：添加镜像名称作为参数
if ! docker save -o "${TEMP_TAR}" "${IMAGE_NAME}"; then
    log_error "保存镜像失败"
    exit 1
fi

# 检查文件是否创建成功
if [ -f "${TEMP_TAR}" ]; then
    log_info "镜像文件创建成功，大小: $(ls -lh ${TEMP_TAR} | awk '{print $5}')"
    log_info "文件详细信息:"
    ls -la "${TEMP_TAR}"
else
    log_error "镜像文件未找到: ${TEMP_TAR}"
    log_info "目录内容:"
    ls -la
    exit 1
fi

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

# 验证部署
# log_info "验证部署..."
# if ! validate_deployment "${ENV}" "${VERSION}"; then
#     log_error "部署验证失败"
#     if [ "${FORCE}" != true ]; then
#         log_info "尝试回滚部署..."
#         ssh ${SSH_OPTIONS} "${SERVER_USER}@${SERVER_IP}" "cd ${DEPLOY_PATH} && \
#             docker compose down && \
#             docker compose -f docker-compose.yaml.bak up -d"
#         log_deployment_history "${ENV}" "${VERSION}" "FAILED_ROLLBACK"
#         send_deployment_notification "${ENV}" "${VERSION}" "部署失败，已回滚"
#         exit 1
#     fi
# fi

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










