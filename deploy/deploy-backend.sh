#!/usr/bin/env bash
#
# Serverpod 后端镜像部署脚本（在服务器上执行）
#
# 流程: 找镜像包 -> docker load -> 记录旧镜像 -> compose 重启 ->
#       健康检查 -> 失败自动回滚 -> 清理旧镜像与旧包
#
# 用法:
#   bash deploy-backend.sh                    # 自动找 images/*_latest_*.tar.gz
#   bash deploy-backend.sh --tag v1.2.0       # 指定版本包
#   bash deploy-backend.sh --image-tar /path/to/pkg.tar.gz
#   bash deploy-backend.sh --keep 5           # 保留 5 个历史版本
#   bash deploy-backend.sh --no-rollback      # 失败不回滚

set -euo pipefail

WORK_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
DEPLOY_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

IMAGE_NAME="serverpod-admin-api"
CONTAINER_NAME="serverpod-api"
NGINX_CONTAINER="serverpod-nginx"
PG_CONTAINER="serverpod-postgres"
COMPOSE_FILE="${WORK_DIR}/docker/production/docker-compose.yaml"
ENV_FILE="${WORK_DIR}/docker/production/.env.production"
IMAGE_DIR="${WORK_DIR}/images"
HEALTH_URL="http://127.0.0.1:8082/api/system/health"
HEALTH_TIMEOUT=30
HEALTH_INTERVAL=5
KEEP=3
TAG=""
IMAGE_TAR=""
ROLLBACK=false

if [[ -t 1 ]]; then
  C_RESET=$'\033[0m'; C_RED=$'\033[0;31m'; C_GREEN=$'\033[0;32m'
  C_YELLOW=$'\033[0;33m'; C_BLUE=$'\033[0;34m'; C_BOLD=$'\033[1m'
else
  C_RESET=""; C_RED=""; C_GREEN=""; C_YELLOW=""; C_BLUE=""; C_BOLD=""
fi

log_info()  { echo "${C_BLUE}[INFO]${C_RESET} $*"; }
log_ok()    { echo "${C_GREEN}[ OK ]${C_RESET} $*"; }
log_warn()  { echo "${C_YELLOW}[WARN]${C_RESET} $*"; }
log_error() { echo "${C_RED}[FAIL]${C_RESET} $*" >&2; }

usage() {
  cat <<'EOF'
部署 Serverpod 后端镜像。

用法:
  bash deploy-backend.sh [选项]

选项:
  --tag TAG          指定版本标签，找对应 tar.gz
  --image-tar FILE   直接指定镜像包路径
  --image NAME       镜像名，默认 serverpod-admin-api
  --keep N           服务器保留 N 个历史镜像，默认 3
  --no-rollback      健康检查失败时不回滚
  -h, --help         显示帮助
EOF
}

while [[ $# -gt 0 ]]; do
  case "$1" in
    --tag)          TAG="$2"; shift 2 ;;
    --image-tar)    IMAGE_TAR="$2"; shift 2 ;;
    --image)        IMAGE_NAME="$2"; shift 2 ;;
    --keep)         KEEP="$2"; shift 2 ;;
    --no-rollback)  ROLLBACK=false; shift ;;
    -h|--help)      usage; exit 0 ;;
    *) log_error "未知参数: $1"; usage; exit 1 ;;
  esac
done

die() { log_error "$*"; exit 1; }

# ---------- 预检 ----------
command -v docker >/dev/null 2>&1 || die "未安装 docker"
docker info >/dev/null 2>&1 || die "docker 服务未运行"
[[ -f "${COMPOSE_FILE}" ]] || die "未找到 compose 文件: ${COMPOSE_FILE}"

compose() {
  [[ -f "${ENV_FILE}" ]] || die "缺少 ${ENV_FILE}，首次部署需手工准备"
  docker compose \
    --env-file "${ENV_FILE}" \
    -f "${COMPOSE_FILE}" "$@"
}

# 从 env 文件取一个变量值
env_get() {
  local key="$1" line
  line="$(grep -E "^${key}=" "${ENV_FILE}" 2>/dev/null | tail -1 || true)"
  line="${line#*=}"
  printf '%s' "${line//[[:space:]\"\']/}"
}

# ---------- 定位镜像包 ----------
find_image_tar() {
  if [[ -n "${IMAGE_TAR}" ]]; then
    echo "${IMAGE_TAR}"
    return
  fi

  [[ -d "${IMAGE_DIR}" ]] || die "镜像目录不存在: ${IMAGE_DIR}"

  local pattern
  if [[ -n "${TAG}" ]]; then
    pattern="${IMAGE_NAME}_${TAG}_*.tar.gz"
  else
    pattern="${IMAGE_NAME}_latest_*.tar.gz"
  fi

  local found
  found="$(find "${IMAGE_DIR}" -maxdepth 1 -type f -name "${pattern}" -exec ls -t {} + 2>/dev/null | head -n 1)"
  [[ -n "${found}" ]] || die "未找到镜像包: ${IMAGE_DIR}/${pattern}"

  echo "${found}"
}

# ---------- 加载镜像 ----------
# 结果写入全局 LOADED_IMAGE，避免日志混进命令替换的返回值
LOADED_IMAGE=""
load_image() {
  local tar_path="$1"
  local output tag

  log_info "加载镜像包: ${tar_path}"

  if [[ "${tar_path}" == *.gz ]]; then
    output="$(gzip -dc "${tar_path}" | docker load)"
  else
    output="$(docker load -i "${tar_path}")"
  fi

  tag="$(echo "${output}" | sed -n 's/.*Loaded image:  *//p' | head -n 1)"

  if [[ -z "${tag}" ]]; then
    die "docker load 成功但未能解析镜像标签，请用 --image 显式指定"
  fi

  # buildx 导出的 docker tar 常丢仓库标签，load 出来只有 sha256，补一个可读标签
  if [[ "${tag}" == sha256:* ]]; then
    local version
    version="$(date -r "${tar_path}" +%Y%m%d%H%M%S 2>/dev/null || date +%Y%m%d%H%M%S)"
    docker tag "${tag}" "${IMAGE_NAME}:${version}"
    log_warn "镜像包无仓库标签，已标记为 ${IMAGE_NAME}:${version}"
    tag="${IMAGE_NAME}:${version}"
  fi

  LOADED_IMAGE="${tag}"
  log_ok "镜像已加载: ${tag}"
}

# ---------- 健康检查 ----------
wait_healthy() {
  local elapsed=0 status

  log_info "等待健康检查: ${HEALTH_URL}"
  while [[ ${elapsed} -lt ${HEALTH_TIMEOUT} ]]; do
    if curl -fsS --max-time 5 "${HEALTH_URL}" >/dev/null 2>&1; then
      log_ok "健康检查通过（${elapsed}s）"
      return 0
    fi
    status="$(docker inspect -f '{{if .State.Health}}{{.State.Health.Status}}{{else}}none{{end}}' "${CONTAINER_NAME}" 2>/dev/null || echo none)"
    if [[ "${status}" == "unhealthy" ]]; then
      log_error "容器状态 unhealthy: ${CONTAINER_NAME}"
      return 1
    fi
    sleep "${HEALTH_INTERVAL}"
    elapsed=$((elapsed + HEALTH_INTERVAL))
    echo "  等待中... ${elapsed}s/${HEALTH_TIMEOUT}s"
  done

  log_error "健康检查超时（${HEALTH_TIMEOUT}s）"
  return 1
}

# POSTGRES_DB 只在空卷首启时建库，卷里是旧库名时不会补，这里每次发布前对一次
ensure_database() {
  local db user elapsed=0 exists
  db="$(env_get POSTGRES_DB)"; db="${db:-serverpod}"
  user="$(env_get POSTGRES_USER)"; user="${user:-postgres}"

  log_info "确认数据库: ${db}"
  while ! docker exec "${PG_CONTAINER}" pg_isready -U "${user}" -q 2>/dev/null; do
    if [[ ${elapsed} -ge 60 ]]; then
      log_error "postgres 未就绪（60s），跳过建库"
      return 1
    fi
    sleep 2
    elapsed=$((elapsed + 2))
  done

  exists="$(docker exec "${PG_CONTAINER}" psql -U "${user}" -d postgres -tAc \
    "SELECT 1 FROM pg_database WHERE datname='${db}'" 2>/dev/null || true)"
  if [[ "${exists}" == "1" ]]; then
    log_ok "数据库已存在: ${db}"
    return 0
  fi

  if docker exec "${PG_CONTAINER}" psql -U "${user}" -d postgres -c \
       "CREATE DATABASE \"${db}\" OWNER \"${user}\"" >/dev/null; then
    log_ok "已创建数据库: ${db}"
  else
    log_error "创建数据库失败: ${db}"
    return 1
  fi
}

# 探活只打 8082，nginx 不在这条链路上，单独确认它在跑
wait_nginx() {
  local elapsed=0 status

  log_info "确认 nginx: ${NGINX_CONTAINER}"
  while [[ ${elapsed} -lt 60 ]]; do
    status="$(docker inspect -f '{{if .State.Health}}{{.State.Health.Status}}{{else}}{{.State.Status}}{{end}}' "${NGINX_CONTAINER}" 2>/dev/null || echo missing)"
    case "${status}" in
      healthy|running) log_ok "nginx 已就绪"; return 0 ;;
      starting|created) ;;
      *) log_error "nginx 状态异常: ${status}"; break ;;
    esac
    sleep 3
    elapsed=$((elapsed + 3))
  done

  log_error "nginx 未就绪，打印最近日志："
  docker logs --tail 40 "${NGINX_CONTAINER}" 2>&1 || true
  return 1
}

# nginx.conf 是 bind mount，文件内容变了容器不会自动重读，每次发布 reload 一次
reload_nginx() {
  if ! docker exec "${NGINX_CONTAINER}" nginx -t >/dev/null 2>&1; then
    log_error "nginx 配置有语法错误，跳过 reload（旧 worker 仍在服务）："
    docker exec "${NGINX_CONTAINER}" nginx -t 2>&1 | tail -5
    return 1
  fi

  if docker exec "${NGINX_CONTAINER}" nginx -s reload >/dev/null 2>&1; then
    log_ok "nginx 已重载最新配置"
    return 0
  fi

  log_error "nginx reload 失败"
  return 1
}

# ---------- 清理 ----------
cleanup_images() {
  log_info "清理旧镜像，保留最近 ${KEEP} 个版本..."

  local tags=() line
  while IFS= read -r line; do
    if [[ -n "${line}" ]]; then
      tags+=("${line}")
    fi
  done < <(docker images --format '{{.Repository}}:{{.Tag}}' "${IMAGE_NAME}" 2>/dev/null | grep -v ':latest$' || true)

  local count="${#tags[@]}"
  if [[ "${count}" -le "${KEEP}" ]]; then
    return 0
  fi

  local i
  for (( i = KEEP; i < count; i++ )); do
    # 不删 latest 指向的镜像；rmi 失败不影响部署
    docker rmi "${tags[$i]}" >/dev/null 2>&1 || true
    log_info "已移除镜像: ${tags[$i]}"
  done
}

cleanup_archives() {
  local files=() file
  while IFS= read -r file; do
    if [[ -n "${file}" ]]; then
      files+=("${file}")
    fi
  done < <(find "${IMAGE_DIR}" -maxdepth 1 -type f -name "${IMAGE_NAME}_[0-9]*_*.tar.gz" -exec ls -t {} + 2>/dev/null || true)

  local count="${#files[@]}"
  if [[ "${count}" -le "${KEEP}" ]]; then
    return 0
  fi

  local i
  for (( i = KEEP; i < count; i++ )); do
    rm -f "${files[$i]}"
    log_info "已移除旧包: $(basename "${files[$i]}")"
  done
}

# ---------- 主流程 ----------
main() {
  local tar_path loaded prev_image
  tar_path="$(find_image_tar)"
  load_image "${tar_path}"
  loaded="${LOADED_IMAGE}"

  # 重启前记录当前运行镜像，用于回滚
  prev_image="$(docker inspect -f '{{.Config.Image}}' "${CONTAINER_NAME}" 2>/dev/null || true)"
  if [[ -n "${prev_image}" ]]; then
    log_info "当前运行镜像: ${prev_image}"
  else
    log_warn "未找到运行中的容器 ${CONTAINER_NAME}，跳过回滚保护"
    ROLLBACK=false
  fi

  # 先起数据库和缓存，库名对不上时能当场补建，别让 api 起来就崩
  log_info "启动数据库与缓存..."
  if ! IMAGE_NAME="${loaded}" compose up -d postgres redis; then
    log_error "数据库/缓存启动失败"
    exit 1
  fi
  if ! ensure_database; then
    log_error "数据库准备失败，需要人工介入"
    exit 1
  fi

  log_info "启动服务: ${loaded}"
  if ! IMAGE_NAME="${loaded}" compose up -d; then
    log_error "compose 启动失败"
    if [[ "${ROLLBACK}" == "true" ]]; then
      log_warn "回滚到 ${prev_image}"
      IMAGE_NAME="${prev_image}" compose up -d || true
    fi
    exit 1
  fi

  if ! wait_healthy; then
    log_error "部署失败，打印最近日志："
    docker logs --tail 60 "${CONTAINER_NAME}" 2>&1 || true
    if [[ "${ROLLBACK}" == "true" ]]; then
      log_warn "回滚到 ${prev_image}"
      if IMAGE_NAME="${prev_image}" compose up -d && wait_healthy; then
        log_ok "已回滚，服务恢复正常"
      else
        log_error "回滚后仍未通过健康检查，需要人工介入"
      fi
    fi
    exit 1
  fi

  # nginx 挂了不跟着回滚镜像，回滚也修不好端口占用或证书问题
  if ! wait_nginx; then
    log_error "部署失败：nginx 未就绪，需要人工介入"
    exit 1
  fi

  # 容器没被重建时（只改了 nginx.conf 内容），必须 reload 才生效
  if ! reload_nginx; then
    log_error "部署失败：nginx 未加载最新配置，需要人工介入"
    exit 1
  fi

  echo "${loaded}" > "${DEPLOY_DIR}/.deployed_backend"
  log_ok "部署成功: ${loaded}"

  cleanup_images
  cleanup_archives
}

main
