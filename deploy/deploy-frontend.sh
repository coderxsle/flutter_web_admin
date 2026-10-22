#!/usr/bin/env bash
#
# Serverpod 前端静态文件部署脚本（在服务器上执行）
#
# 解压到临时目录校验后再整体切换，避免解压过程中出现 404/白屏。
# 切换用同分区 mv（rename），对 nginx alias 目录是原子的。
#
# 用法:
#   bash deploy-frontend.sh                        # 用 web/dist.tar.gz 部署
#   bash deploy-frontend.sh --tar other.tar.gz
#   bash deploy-frontend.sh --keep 3               # 保留 3 份历史版本
#   bash deploy-frontend.sh --reload-nginx         # 切换后 reload nginx

set -euo pipefail

DEPLOY_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
WORK_DIR="$(cd "${DEPLOY_DIR}/.." && pwd)"

WEB_ROOT="${WORK_DIR}/web"
TAR_FILE="${WEB_ROOT}/dist.tar.gz"
TARGET_DIR="${WEB_ROOT}/dist"
KEEP=3
RELOAD_NGINX=false

if [[ -t 1 ]]; then
  C_RESET=$'\033[0m'; C_RED=$'\033[0;31m'; C_GREEN=$'\033[0;32m'
  C_YELLOW=$'\033[0;33m'; C_BLUE=$'\033[0;34m'
else
  C_RESET=""; C_RED=""; C_GREEN=""; C_YELLOW=""; C_BLUE=""
fi

log_info()  { echo "${C_BLUE}[INFO]${C_RESET} $*"; }
log_ok()    { echo "${C_GREEN}[ OK ]${C_RESET} $*"; }
log_warn()  { echo "${C_YELLOW}[WARN]${C_RESET} $*"; }
log_error() { echo "${C_RED}[FAIL]${C_RESET} $*" >&2; }

usage() {
  cat <<'EOF'
部署前端静态文件（原子切换）。

用法:
  bash deploy-frontend.sh [选项]

选项:
  --web-root DIR   静态目录根，默认 <项目>/web
  --tar FILE       压缩包路径，默认 <web-root>/dist.tar.gz
  --keep N         保留 N 份历史 dist，默认 3
  --reload-nginx   切换后执行 nginx -s reload
  -h, --help       显示帮助
EOF
}

while [[ $# -gt 0 ]]; do
  case "$1" in
    --web-root)
      WEB_ROOT="$2"
      TAR_FILE="${WEB_ROOT}/dist.tar.gz"
      TARGET_DIR="${WEB_ROOT}/dist"
      shift 2 ;;
    --tar)          TAR_FILE="$2"; shift 2 ;;
    --keep)         KEEP="$2"; shift 2 ;;
    --reload-nginx) RELOAD_NGINX=true; shift ;;
    -h|--help)      usage; exit 0 ;;
    *) log_error "未知参数: $1"; usage; exit 1 ;;
  esac
done

die() { log_error "$*"; exit 1; }

[[ -f "${TAR_FILE}" ]] || die "未找到前端包: ${TAR_FILE}"
mkdir -p "${WEB_ROOT}"

STAMP="$(date +%Y%m%d%H%M%S)"
NEW_DIR="${WEB_ROOT}/.dist_new_${STAMP}"
PREV_DIR="${WEB_ROOT}/dist_prev_${STAMP}"

cleanup_tmp() {
  [[ -d "${NEW_DIR}" ]] && rm -rf "${NEW_DIR}"
}
trap cleanup_tmp EXIT

# ---------- 解压到临时目录 ----------
log_info "解压到临时目录: ${NEW_DIR}"
mkdir -p "${NEW_DIR}"
if ! tar -xzf "${TAR_FILE}" -C "${NEW_DIR}"; then
  die "解压失败，现网文件未改动"
fi

[[ -f "${NEW_DIR}/index.html" ]] || die "包内缺少 index.html，现网文件未改动"
log_ok "包内容校验通过"

# ---------- 原子切换 ----------
if [[ -d "${TARGET_DIR}" ]]; then
  log_info "备份当前版本 -> $(basename "${PREV_DIR}")"
  mv "${TARGET_DIR}" "${PREV_DIR}"
fi

mv "${NEW_DIR}" "${TARGET_DIR}"
trap - EXIT
log_ok "已切换到新版本"

# 归档本次压缩包，避免下次同名覆盖
ARCHIVED_TAR="${WEB_ROOT}/dist_${STAMP}.tar.gz"
mv -f "${TAR_FILE}" "${ARCHIVED_TAR}"
log_info "压缩包已归档: $(basename "${ARCHIVED_TAR}")"

if [[ "${RELOAD_NGINX}" == "true" ]]; then
  if command -v nginx >/dev/null 2>&1; then
    nginx -s reload && log_ok "nginx 已 reload"
  else
    log_warn "未找到 nginx 命令，跳过 reload"
  fi
fi

# ---------- 清理历史 ----------
cleanup_prev() {
  local dirs=() dir
  while IFS= read -r dir; do
    if [[ -n "${dir}" ]]; then
      dirs+=("${dir}")
    fi
  done < <(find "${WEB_ROOT}" -maxdepth 1 -type d -name 'dist_prev_*' -exec ls -dt {} + 2>/dev/null || true)

  local count="${#dirs[@]}"
  if [[ "${count}" -le "${KEEP}" ]]; then
    return 0
  fi

  local i
  for (( i = KEEP; i < count; i++ )); do
    rm -rf "${dirs[$i]}"
    log_info "已移除历史版本: $(basename "${dirs[$i]}")"
  done
}

cleanup_archives() {
  local files=() file
  while IFS= read -r file; do
    if [[ -n "${file}" ]]; then
      files+=("${file}")
    fi
  done < <(find "${WEB_ROOT}" -maxdepth 1 -type f -name 'dist_[0-9]*.tar.gz' -exec ls -t {} + 2>/dev/null || true)

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

cleanup_prev
cleanup_archives
log_ok "前端部署完成"
