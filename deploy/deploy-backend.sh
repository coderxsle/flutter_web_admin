#!/usr/bin/env bash
#
# Serverpod 后端镜像部署脚本（在服务器上执行）
#
# 流程: 预检 -> docker load（记录回滚点）-> 起库补库 -> compose 重启 ->
#       健康检查 -> nginx 检查与 reload -> 清理历史，失败自动回滚
#
# 用法:
#   bash deploy-backend.sh                     # 自动找 images/*_latest_*.tar.gz
#   bash deploy-backend.sh --tag v1.2.0        # 指定版本包
#   bash deploy-backend.sh --image-tar pkg.tgz
#   bash deploy-backend.sh --keep 5 --no-rollback

set -euo pipefail

readonly SCRIPT_NAME="$(basename "${BASH_SOURCE[0]}")"
readonly SCRIPT_VERSION="2.0.0"
readonly DEPLOY_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
readonly WORK_DIR="$(cd "${DEPLOY_DIR}/.." && pwd)"

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
ROLLBACK=true
QUIET=false
DEBUG=false
NO_COLOR=false

readonly LOG_DIR="${DEPLOY_DIR}/logs"
readonly LOG_KEEP=10
LOG_FILE=""
STEP_TOTAL=6
STEP_N=0
STEP_START=0
TOTAL_START=0
PREV_IMAGE=""
LOADED_IMAGE=""
FAIL_LOGGED=false

# ============================== 日志与输出 ==============================
if [[ -t 1 ]]; then
  ESC=$'\033'
  RED=$'\033[0;31m'
  GREEN=$'\033[0;32m'
  GOLD=$'\033[38;5;220m'
  BRIGHT_BLUE=$'\033[38;5;39m'
  NC=$'\033[0m'
else
  ESC=""
  RED=""; GREEN=""; GOLD=""; BRIGHT_BLUE=""; NC=""
fi

disable_color() {
  RED=""; GREEN=""; GOLD=""; BRIGHT_BLUE=""; NC=""
}

strip_ansi() {
  if [[ -n "${ESC}" ]]; then
    sed -E "s/${ESC}\\[[0-9;]*m//g"
  else
    cat
  fi
}

# 终端与日志文件双写
_logline() {
  if [[ -n "${LOG_FILE}" ]]; then
    printf '[%s] [%s] %s\n' "$(date '+%F %T')" "$1" "$2" >> "${LOG_FILE}"
  fi
  return 0
}

log_info() {
  if [[ "${QUIET}" != "true" ]]; then
    printf '%b %s\n' "${BRIGHT_BLUE}[INFO]${NC}" "$*"
  fi
  _logline INFO "$*"
}

log_ok() {
  if [[ "${QUIET}" != "true" ]]; then
    printf '%b %s\n' "${GREEN}[ OK ]${NC}" "$*"
  fi
  _logline " OK " "$*"
}

log_warn() {
  printf '%b %s\n' "${GOLD}[WARN]${NC}" "$*"
  _logline WARN "$*"
}

log_error() {
  FAIL_LOGGED=true
  printf '%b %s\n' "${RED}[FAIL]${NC}" "$*" >&2
  _logline FAIL "$*"
}

log_debug() {
  if [[ "${DEBUG}" == "true" ]]; then
    printf '%b %s\n' "${BRIGHT_BLUE}[DBG ]${NC}" "$*"
    _logline DBG "$*"
  fi
}

# 带颜色的装饰行，同样落盘（去色）
print() {
  local msg="$*"
  if [[ "${QUIET}" != "true" ]]; then
    printf '%b\n' "${msg}"
  fi
  if [[ -n "${LOG_FILE}" ]]; then
    printf '%b\n' "${msg}" | strip_ansi >> "${LOG_FILE}"
  fi
  return 0
}

clear_line() {
  if [[ -t 1 && "${QUIET}" != "true" ]]; then
    printf '\r\033[K'
  fi
}

divider() {
  print "${BRIGHT_BLUE}────────────────────────────────────────────────────────${NC}"
}

step() {
  STEP_N=$((STEP_N + 1))
  STEP_START="$(date +%s)"
  print ""
  print "${BRIGHT_BLUE}▶ [${STEP_N}/${STEP_TOTAL}]${NC} ${GOLD}$*${NC}"
  divider
}

step_done() {
  local cost=$(( $(date +%s) - STEP_START ))
  log_debug "第 ${STEP_N} 步耗时 ${cost}s"
}

# 后台命令 + 进度动画，输出落盘，返回命令退出码
spin_run() {
  local message="$1" outfile="$2"
  shift 2

  local frames=(
    "▱▱▱▱▱▱▱▱▱▱" "▰▱▱▱▱▱▱▱▱▱" "▰▰▱▱▱▱▱▱▱▱" "▰▰▰▱▱▱▱▱▱▱"
    "▰▰▰▰▱▱▱▱▱▱" "▰▰▰▰▰▱▱▱▱▱" "▰▰▰▰▰▰▱▱▱▱" "▰▰▰▰▰▰▰▱▱▱"
    "▰▰▰▰▰▰▰▰▱▱" "▰▰▰▰▰▰▰▰▰▱" "▰▰▰▰▰▰▰▰▰▰"
  )
  local i=0 start pid rc=0 elapsed

  start="$(date +%s)"
  # 子 shell 里关掉 set -e，失败由下面的 wait 取退出码处理
  ( set +e; "$@" >"${outfile}" 2>&1 ) &
  pid=$!

  if [[ -t 1 && "${QUIET}" != "true" ]]; then
    while kill -0 "${pid}" 2>/dev/null; do
      printf '\r%b %s ' "${BRIGHT_BLUE}${message}${NC}" "${GREEN}${frames[$i]}${NC}"
      i=$(( (i + 1) % ${#frames[@]} ))
      sleep 0.1
    done
  fi

  if wait "${pid}"; then rc=0; else rc=$?; fi
  elapsed=$(( $(date +%s) - start ))

  if [[ -t 1 && "${QUIET}" != "true" ]]; then
    if [[ ${rc} -eq 0 ]]; then
      printf '\r%b ▰▰▰▰▰▰▰▰▰▰ %b (%ss)\n' "${message}" "${GREEN}完成${NC}" "${elapsed}"
    else
      printf '\r%b ▱▱▱▱▱▱▱▱▱▱ %b (%ss)\n' "${message}" "${RED}失败${NC}" "${elapsed}"
    fi
  fi
  return "${rc}"
}

# ============================== 参数 ==============================
usage() {
  cat <<EOF
${SCRIPT_NAME} v${SCRIPT_VERSION} — 部署 Serverpod 后端镜像

用法:
  bash ${SCRIPT_NAME} [选项]

选项:
  --tag TAG          指定版本标签，找对应 tar.gz
  --image-tar FILE   直接指定镜像包路径
  --image NAME       镜像名，默认 ${IMAGE_NAME}
  --keep N           服务器保留 N 个历史镜像，默认 ${KEEP}
  --health-url URL   健康检查地址，默认 ${HEALTH_URL}
  --timeout SEC      健康检查超时秒数，默认 ${HEALTH_TIMEOUT}
  --no-rollback      健康检查失败时不回滚
  -q, --quiet        只输出告警与错误
  -d, --debug        输出调试信息
  --no-color         关闭颜色（写 CI 日志时用）
  -v, --version      显示版本
  -h, --help         显示帮助

示例:
  bash ${SCRIPT_NAME}
  bash ${SCRIPT_NAME} --tag v1.2.0 --keep 5
  bash ${SCRIPT_NAME} --image-tar /data/pkg.tar.gz --no-rollback
EOF
}

parse_args() {
  while [[ $# -gt 0 ]]; do
    case "$1" in
      --tag)         TAG="${2:-}"; shift 2 ;;
      --image-tar)   IMAGE_TAR="${2:-}"; shift 2 ;;
      --image)       IMAGE_NAME="${2:-}"; shift 2 ;;
      --keep)        KEEP="${2:-}"; shift 2 ;;
      --health-url)  HEALTH_URL="${2:-}"; shift 2 ;;
      --timeout)     HEALTH_TIMEOUT="${2:-}"; shift 2 ;;
      --no-rollback) ROLLBACK=false; shift ;;
      -q|--quiet)    QUIET=true; shift ;;
      -d|--debug)    DEBUG=true; shift ;;
      --no-color)    NO_COLOR=true; disable_color; shift ;;
      -v|--version)  printf '%s %s\n' "${SCRIPT_NAME}" "${SCRIPT_VERSION}"; exit 0 ;;
      -h|--help)     usage; exit 0 ;;
      *) log_error "未知参数: $1"; usage; exit 1 ;;
    esac
  done

  [[ "${KEEP}" =~ ^[0-9]+$ ]] && [[ "${KEEP}" -ge 1 ]] || die "--keep 需要 >= 1 的整数"
  [[ "${HEALTH_TIMEOUT}" =~ ^[0-9]+$ ]] || die "--timeout 需要整数秒"
  if [[ "${NO_COLOR}" == "true" ]]; then
    disable_color
  fi
  return 0
}

die() {
  if [[ "${DEBUG}" == "true" ]]; then
    log_error "$*（第 ${BASH_LINENO[0]} 行）"
  else
    log_error "$*"
  fi
  exit 1
}

# ============================== 日志初始化 ==============================
cleanup_logs() {
  local files=() file
  while IFS= read -r file; do
    files+=("${file}")
  done < <(find "${LOG_DIR}" -maxdepth 1 -type f -name 'deploy_*.log*' -exec ls -t {} + 2>/dev/null || true)

  local count="${#files[@]}"
  if [[ "${count}" -le "${LOG_KEEP}" ]]; then
    return 0
  fi

  local i
  for (( i = LOG_KEEP; i < count; i++ )); do
    rm -f "${files[$i]}"
  done
}

init_log() {
  TOTAL_START="$(date +%s)"
  if ! mkdir -p "${LOG_DIR}" 2>/dev/null; then
    log_warn "无法创建日志目录 ${LOG_DIR}，日志只输出到终端"
    return 0
  fi

  LOG_FILE="${LOG_DIR}/deploy_$(date +%Y%m%d_%H%M%S).log"
  if ! : > "${LOG_FILE}" 2>/dev/null; then
    LOG_FILE=""
    log_warn "无法写入日志文件，日志只输出到终端"
    return 0
  fi

  {
    printf '=== 部署日志 ===\n'
    printf '时间: %s\n' "$(date '+%F %T')"
    printf '脚本版本: %s\n' "${SCRIPT_VERSION}"
    printf '主机: %s\n' "$(uname -s) $(hostname 2>/dev/null || echo unknown)"
    printf '工作目录: %s\n' "${WORK_DIR}"
    printf '镜像名: %s\n' "${IMAGE_NAME}"
    printf '===============\n'
  } >> "${LOG_FILE}"

  cleanup_logs
}

cleanup() {
  local rc=$?
  # 非正常退出且没有任何 FAIL 记录时补一行，免得只剩退出码
  if [[ ${rc} -ne 0 && "${FAIL_LOGGED}" != "true" ]]; then
    printf '\n' >&2
    log_error "脚本中止（退出码 ${rc}），现网服务未确认"
  fi
  if [[ -n "${LOG_FILE}" && -f "${LOG_FILE}" ]]; then
    gzip -9 -f "${LOG_FILE}" 2>/dev/null || true
    LOG_FILE="${LOG_FILE}.gz"
  fi
  return 0
}

# ============================== 交互展示 ==============================
show_banner() {
  if [[ -t 1 ]]; then
    printf '\033]0;Serverpod 后端部署\007'
  fi

  local rollback_text="${GREEN}开启${NC}"
  if [[ "${ROLLBACK}" != "true" ]]; then
    rollback_text="${GOLD}关闭${NC}"
  fi

  print ""
  print "${BRIGHT_BLUE}Serverpod 后端镜像部署${NC}  ${GOLD}v${SCRIPT_VERSION}${NC}"
  divider
  print "  ${BRIGHT_BLUE}镜像${NC}     ${GREEN}${IMAGE_NAME}${NC}"
  print "  ${BRIGHT_BLUE}主机${NC}     ${GREEN}$(hostname 2>/dev/null || echo unknown)${NC}"
  print "  ${BRIGHT_BLUE}保留${NC}     ${GREEN}${KEEP}${NC} 个版本    ${BRIGHT_BLUE}回滚${NC} ${rollback_text}"
  print "  ${BRIGHT_BLUE}日志${NC}     ${GREEN}${LOG_FILE:-未启用}${NC}"
}

show_summary() {
  local cost=$(( $(date +%s) - TOTAL_START ))
  local log_path="${LOG_FILE:-未启用}"

  print ""
  print "${GREEN}════════════════════ 部署完成 ════════════════════${NC}"
  print "  ${BRIGHT_BLUE}镜像${NC}      ${GREEN}${LOADED_IMAGE}${NC}"
  print "  ${BRIGHT_BLUE}回滚点${NC}    ${GREEN}${PREV_IMAGE:-无}${NC}"
  print "  ${BRIGHT_BLUE}健康检查${NC}  ${GREEN}${HEALTH_URL}${NC}"
  print "  ${BRIGHT_BLUE}总耗时${NC}    ${GREEN}${cost}s${NC}"
  print "  ${BRIGHT_BLUE}日志${NC}      ${GREEN}${log_path}${NC}${GOLD}（退出后压缩为 .gz）${NC}"
  print "${GREEN}══════════════════════════════════════════════════${NC}"
  print ""
}

# ============================== 预检 ==============================
compose() {
  [[ -f "${ENV_FILE}" ]] || die "缺少 ${ENV_FILE}，首次部署需手工准备"
  docker compose --env-file "${ENV_FILE}" -f "${COMPOSE_FILE}" "$@"
}

# 从 env 文件取一个变量值
env_get() {
  local key="$1" line
  line="$(grep -E "^${key}=" "${ENV_FILE}" 2>/dev/null | tail -1 || true)"
  line="${line#*=}"
  printf '%s' "${line//[[:space:]\"\']/}"
}

preflight() {
  command -v docker >/dev/null 2>&1 || die "未安装 docker"
  command -v curl >/dev/null 2>&1 || die "未安装 curl，健康检查无法执行"
  docker info >/dev/null 2>&1 || die "docker 服务未运行"
  [[ -f "${COMPOSE_FILE}" ]] || die "未找到 compose 文件: ${COMPOSE_FILE}"
  [[ -f "${ENV_FILE}" ]] || die "缺少 ${ENV_FILE}，首次部署需手工准备"

  # docker load 需要接近包体两倍的空间，空间不够直接说清楚
  local avail_mb
  avail_mb="$(df -Pm "${WORK_DIR}" 2>/dev/null | awk 'NR==2 {print $4}')"
  if [[ -n "${avail_mb}" && "${avail_mb}" -lt 3072 ]]; then
    log_warn "工作目录剩余空间仅 ${avail_mb}MB，docker load 可能失败"
  fi

  log_ok "环境检查通过"
}

# ============================== 镜像 ==============================
find_image_tar() {
  if [[ -n "${IMAGE_TAR}" ]]; then
    [[ -f "${IMAGE_TAR}" ]] || die "镜像包不存在: ${IMAGE_TAR}"
    printf '%s' "${IMAGE_TAR}"
    return 0
  fi

  [[ -d "${IMAGE_DIR}" ]] || die "镜像目录不存在: ${IMAGE_DIR}"

  local pattern found
  if [[ -n "${TAG}" ]]; then
    pattern="${IMAGE_NAME}_${TAG}_*.tar.gz"
  else
    pattern="${IMAGE_NAME}_latest_*.tar.gz"
  fi

  found="$(find "${IMAGE_DIR}" -maxdepth 1 -type f -name "${pattern}" -exec ls -t {} + 2>/dev/null | head -n 1)"
  [[ -n "${found}" ]] || die "未找到镜像包: ${IMAGE_DIR}/${pattern}"

  printf '%s' "${found}"
}

_do_load() {
  if [[ "$1" == *.gz ]]; then
    gzip -dc "$1" | docker load
  else
    docker load -i "$1"
  fi
}

# 结果写入全局 LOADED_IMAGE，输出落临时文件再解析，避免日志混进返回值
load_image() {
  local tar_path="$1" tmp output tag size
  tmp="$(mktemp)"

  size="$(du -h "${tar_path}" 2>/dev/null | awk '{print $1}')"
  log_info "镜像包: ${tar_path}（${size:-未知大小}）"

  if ! spin_run "加载镜像" "${tmp}" _do_load "${tar_path}"; then
    log_error "docker load 失败，输出如下："
    tail -20 "${tmp}" >&2 || true
    rm -f "${tmp}"
    die "镜像加载失败，现网服务未改动"
  fi

  output="$(cat "${tmp}")"
  rm -f "${tmp}"

  tag="$(printf '%s\n' "${output}" | sed -n 's/.*Loaded image:  *//p' | head -n 1)"

  # buildx 导出的 tar 常丢仓库标签，load 出来只有 sha256，补一个可读标签
  if [[ -z "${tag}" || "${tag}" == sha256:* ]]; then
    local version
    version="$(date -r "${tar_path}" +%Y%m%d%H%M%S 2>/dev/null || date +%Y%m%d%H%M%S)"
    if [[ -z "${tag}" ]]; then
      tag="$(printf '%s\n' "${output}" | sed -n 's/.*Loaded image ID: *//p' | head -n 1)"
    fi
    [[ -n "${tag}" ]] || die "docker load 成功但未解析到镜像，请用 --image 显式指定"

    docker tag "${tag}" "${IMAGE_NAME}:${version}"
    log_warn "镜像包无仓库标签，已标记为 ${IMAGE_NAME}:${version}"
    tag="${IMAGE_NAME}:${version}"
  fi

  LOADED_IMAGE="${tag}"
  log_ok "镜像已加载: ${tag}"
}

# ============================== 服务 ==============================
wait_healthy() {
  local elapsed=0 status

  log_info "健康检查: ${HEALTH_URL}"
  while [[ ${elapsed} -lt ${HEALTH_TIMEOUT} ]]; do
    if curl -fsS --max-time 5 "${HEALTH_URL}" >/dev/null 2>&1; then
      clear_line
      log_ok "健康检查通过（${elapsed}s）"
      return 0
    fi

    status="$(docker inspect -f '{{if .State.Health}}{{.State.Health.Status}}{{else}}none{{end}}' "${CONTAINER_NAME}" 2>/dev/null || echo none)"
    if [[ "${status}" == "unhealthy" ]]; then
      clear_line
      log_error "容器状态 unhealthy: ${CONTAINER_NAME}"
      return 1
    fi

    if [[ -t 1 && "${QUIET}" != "true" ]]; then
      printf '\r  %b %b %3ds/%ds  ' "${GOLD}等待 API 就绪${NC}" "${GREEN}▰▰▰▰▰▰▰▰▱▱${NC}" "${elapsed}" "${HEALTH_TIMEOUT}"
    fi

    sleep "${HEALTH_INTERVAL}"
    elapsed=$((elapsed + HEALTH_INTERVAL))
  done

  clear_line
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
    return 0
  fi

  log_error "创建数据库失败: ${db}"
  return 1
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
    docker exec "${NGINX_CONTAINER}" nginx -t 2>&1 | tail -5 || true
    return 1
  fi

  if docker exec "${NGINX_CONTAINER}" nginx -s reload >/dev/null 2>&1; then
    log_ok "nginx 已重载最新配置"
    return 0
  fi

  log_error "nginx reload 失败"
  return 1
}

# ============================== 清理 ==============================
cleanup_images() {
  local current="${1:-}"
  local tags=() tag count i

  while IFS= read -r tag; do
    if [[ -z "${tag}" || "${tag}" == "latest" || "${tag}" == "<none>" ]]; then
      continue
    fi
    if [[ "${IMAGE_NAME}:${tag}" == "${current}" ]]; then
      continue
    fi
    tags+=("${tag}")
  done < <(docker images "${IMAGE_NAME}" --format '{{.CreatedAt}}|{{.Tag}}' 2>/dev/null | sort -r | cut -d'|' -f2)

  count="${#tags[@]}"
  if [[ "${count}" -le "${KEEP}" ]]; then
    log_debug "历史镜像 ${count} 个，无需清理"
    return 0
  fi

  log_info "清理旧镜像，保留最近 ${KEEP} 个版本"
  for (( i = KEEP; i < count; i++ )); do
    # rmi 失败不影响部署
    if docker rmi "${IMAGE_NAME}:${tags[$i]}" >/dev/null 2>&1; then
      log_info "已移除镜像: ${IMAGE_NAME}:${tags[$i]}"
    fi
  done
  return 0
}

cleanup_archives() {
  local keep_path="${1:-}"
  local files=() file count i

  while IFS= read -r file; do
    if [[ -n "${file}" && "${file}" != "${keep_path}" ]]; then
      files+=("${file}")
    fi
  done < <(find "${IMAGE_DIR}" -maxdepth 1 -type f -name "${IMAGE_NAME}_[0-9]*_*.tar.gz" -exec ls -t {} + 2>/dev/null || true)

  count="${#files[@]}"
  if [[ "${count}" -le "${KEEP}" ]]; then
    log_debug "历史镜像包 ${count} 个，无需清理"
    return 0
  fi

  for (( i = KEEP; i < count; i++ )); do
    if rm -f "${files[$i]}"; then
      log_info "已移除旧包: $(basename "${files[$i]}")"
    fi
  done
  return 0
}

# ============================== 主流程 ==============================
main() {
  parse_args "$@"
  init_log
  show_banner

  step "环境预检"
  preflight
  step_done

  step "加载镜像包"
  local tar_path
  tar_path="$(find_image_tar)"
  load_image "${tar_path}"

  # 重启前记录当前运行镜像，用于回滚
  PREV_IMAGE="$(docker inspect -f '{{.Config.Image}}' "${CONTAINER_NAME}" 2>/dev/null || true)"
  if [[ -n "${PREV_IMAGE}" ]]; then
    log_info "当前运行镜像（回滚点）: ${PREV_IMAGE}"
  else
    log_warn "未找到运行中的容器 ${CONTAINER_NAME}，跳过回滚保护"
    ROLLBACK=false
  fi
  step_done

  # 先起数据库和缓存，库名对不上时能当场补建，别让 api 起来就崩
  step "启动数据库与缓存"
  if ! IMAGE_NAME="${LOADED_IMAGE}" compose up -d postgres redis; then
    die "数据库/缓存启动失败"
  fi
  if ! ensure_database; then
    die "数据库准备失败，需要人工介入"
  fi
  step_done

  step "启动 API 并健康检查"
  log_info "启动服务: ${LOADED_IMAGE}"
  if ! IMAGE_NAME="${LOADED_IMAGE}" compose up -d; then
    log_error "compose 启动失败"
    if [[ "${ROLLBACK}" == "true" ]]; then
      log_warn "回滚到 ${PREV_IMAGE}"
      IMAGE_NAME="${PREV_IMAGE}" compose up -d || true
    fi
    die "部署失败"
  fi

  if ! wait_healthy; then
    log_error "部署失败，打印最近日志："
    docker logs --tail 60 "${CONTAINER_NAME}" 2>&1 || true
    if [[ "${ROLLBACK}" == "true" ]]; then
      log_warn "回滚到 ${PREV_IMAGE}"
      if IMAGE_NAME="${PREV_IMAGE}" compose up -d && wait_healthy; then
        log_ok "已回滚，服务恢复正常"
      else
        log_error "回滚后仍未通过健康检查，需要人工介入"
      fi
    fi
    die "部署失败"
  fi
  step_done

  # nginx 挂了不跟着回滚镜像，回滚也修不好端口占用或证书问题
  step "nginx 检查并重载"
  if ! wait_nginx; then
    die "部署失败：nginx 未就绪，需要人工介入"
  fi
  # 容器没被重建时（只改了 nginx.conf 内容），必须 reload 才生效
  if ! reload_nginx; then
    die "部署失败：nginx 未加载最新配置，需要人工介入"
  fi
  step_done

  printf '%s\n' "${LOADED_IMAGE}" > "${DEPLOY_DIR}/.deployed_backend"

  step "清理历史版本"
  # 清理失败不影响部署结果，两个函数内部都做了容错
  cleanup_images "${LOADED_IMAGE}"
  cleanup_archives "${tar_path}"
  step_done

  show_summary
}

trap cleanup EXIT

main "$@"
