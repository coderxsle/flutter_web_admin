#!/bin/bash

# 加载工具函数
source "$(dirname "${BASH_SOURCE[0]}")/deploy-utils.sh"

# 检查必需的工具
check_required_tools

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

# 设置镜像名称
IMAGE_TAG=$(build_image_tag "$ENV" "$VERSION")
FULL_IMAGE_NAME=$(build_full_image_name "$IMAGE_TAG")

# 登录华为云镜像仓库
log_info "登录华为云镜像仓库..."
if ! login_to_registry; then
    log_error "华为云镜像仓库登录失败"
    exit 1
fi

# 构建镜像
log_info "构建镜像: ${FULL_IMAGE_NAME}"
if ! build_image "${FULL_IMAGE_NAME}" "${ENV}"; then
    log_error "镜像构建失败"
    exit 1
fi

# 推送镜像到华为云
log_info "推送镜像到华为云..."
if ! push_image "${FULL_IMAGE_NAME}"; then
    log_error "镜像推送失败"
    exit 1
fi

# 获取 Portainer 认证令牌
log_info "获取 Portainer 认证..."
TOKEN=$(get_portainer_token)

if [ -z "$TOKEN" ]; then
    echo "Portainer 认证失败"
    exit 1
fi

# 准备容器配置
STACK_NAME="book-store-${ENV}"
COMPOSE_FILE="../${ENV}/docker-compose.yaml"

if [ ! -f "$COMPOSE_FILE" ]; then
    echo "Error: Docker Compose file not found: $COMPOSE_FILE"
    exit 1
fi

# 更新 Portainer 堆栈
echo "更新 Portainer 堆栈..."
ENDPOINT_ID=1  # 默认端点ID，根据实际情况修改

# 读取并修改 docker-compose 文件
TMP_COMPOSE_FILE=$(mktemp)
sed "s|image: book_store_server:.*|image: ${FULL_IMAGE_NAME}|g" ${COMPOSE_FILE} > ${TMP_COMPOSE_FILE}
COMPOSE_CONTENT=$(cat ${TMP_COMPOSE_FILE} | base64)
rm ${TMP_COMPOSE_FILE}

# 检查堆栈是否已存在
STACK_ID=$(curl -s -H "Authorization: Bearer ${TOKEN}" \
    "${PORTAINER_URL}/api/stacks" | jq -r ".[] | select(.Name==\"${STACK_NAME}\") | .Id")

if [ -n "$STACK_ID" ]; then
    echo "更新现有堆栈..."
    ENDPOINT_ID=$(curl -s -H "Authorization: Bearer ${TOKEN}" \
        "${PORTAINER_URL}/api/stacks/${STACK_ID}" | jq -r .EndpointId)
    
    # 更新堆栈
    curl -s -X PUT "${PORTAINER_URL}/api/stacks/${STACK_ID}" \
        -H "Authorization: Bearer ${TOKEN}" \
        -H "Content-Type: application/json" \
        -d "{
            \"stackFileContent\": \"${COMPOSE_CONTENT}\",
            \"env\": [{
                \"name\": \"IMAGE_TAG\",
                \"value\": \"${IMAGE_TAG}\"
            }],
            \"prune\": true
        }"
else
    echo "创建新堆栈..."
    # 创建新堆栈
    curl -s -X POST "${PORTAINER_URL}/api/stacks" \
        -H "Authorization: Bearer ${TOKEN}" \
        -H "Content-Type: application/json" \
        -d "{
            \"name\": \"${STACK_NAME}\",
            \"stackFileContent\": \"${COMPOSE_CONTENT}\",
            \"env\": [{
                \"name\": \"IMAGE_TAG\",
                \"value\": \"${IMAGE_TAG}\"
            }],
            \"endpointId\": ${ENDPOINT_ID}
        }"
fi

# 部署后的健康检查
log_info "执行部署后检查..."
if ! wait_for_healthy "${TOKEN}" "book-store-${ENV}"; then
    log_error "部署后检查失败"
    if [ "$FORCE" != true ]; then
        log_info "尝试回滚部署..."
        rollback_deployment "${STACK_ID}" "${TOKEN}"
    fi
    exit 1
fi

# 显示部署信息
show_deployment_info "${FULL_IMAGE_NAME}" "${ENV}" "${VERSION}"

echo "部署完成！"
echo "镜像: ${FULL_IMAGE_NAME}"
echo "环境: ${ENV}"
echo "版本: ${VERSION}"

# 验证部署
echo "验证部署状态..."
sleep 10  # 等待容器启动
curl -s "${PORTAINER_URL}/api/endpoints/${ENDPOINT_ID}/docker/containers/json" \
    -H "Authorization: Bearer ${TOKEN}" \
    | jq '.[] | select(.Names[] | contains("book-store")) | {name: .Names[0], status: .State, health: .Status}' 