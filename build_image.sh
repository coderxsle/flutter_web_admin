#!/usr/bin/env bash
#
# Serverpod 后端镜像本地构建打包脚本
#
# 构建 backend/ 的 Docker 镜像，导出为 tar.gz，并同时打 latest 与时间戳两个标签。
# 产物命名固定带 latest 一份，部署脚本按固定名查找，不会上传历史包。
#
# 用法:
#   ./build_image.sh                       # 构建 linux/amd64，导出 tar.gz
#   ./build_image.sh --tag v1.2.0          # 指定版本标签
#   ./build_image.sh --load                # 额外加载到本地 docker
#   ./build_image.sh --no-cache            # 禁用构建缓存
#   ./build_image.sh --platform linux/arm64
#
# 注意：首次构建某个架构时，需要能拉取 dart:stable 对应平台的 manifest。
# 如果 Docker 配了失效的 registry 镜像，会在 FROM 阶段直接失败。

set -euo pipefail

APP_NAME="serverpod-admin-api"

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
CONTEXT_DIR="${SCRIPT_DIR}/backend"
DOCKERFILE="${CONTEXT_DIR}/flutter_web_server/docker/Dockerfile"
OUTPUT_DIR="${SCRIPT_DIR}/backend/dist"

IMAGE_NAME="${APP_NAME}"
IMAGE_TAG="$(date +%Y%m%d%H%M%S)"
PLATFORM="linux/amd64"
DART_IMAGE="dart:stable"
APT_MIRROR="${APT_MIRROR:-mirrors.ustc.edu.cn}"
# 默认用国内 pub 镜像；能直连 pub.dev 时用 --pub-hosted-url https://pub.dev 覆盖
PUB_HOSTED_URL="${PUB_HOSTED_URL:-https://pub.flutter-io.cn}"
LOAD_IMAGE=false
NO_CACHE=false
KEEP_ARCHIVES=3

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
构建 Serverpod 后端镜像并导出为 tar.gz。

用法:
  ./build_image.sh [选项]

选项:
  --tag TAG            镜像标签，默认当前时间戳 YYYYmmddHHMMSS
  --image-name NAME    镜像名，默认 serverpod-admin-api
  --platform PLATFORM  目标平台，默认 linux/amd64
  --output-dir DIR     产物目录，默认 backend/dist
  --dart-image IMAGE   构建用 Dart 镜像，默认 dart:stable
  --apt-mirror HOST    apt 镜像站域名，加速依赖安装，如 mirrors.ustc.edu.cn
  --pub-hosted-url URL pub 源地址，默认 https://pub.flutter-io.cn
  --keep N             保留最近 N 个历史包，默认 3
  --load               构建后同时加载到本地 docker
  --no-cache           禁用构建缓存
  -h, --help           显示帮助

产物:
  <output-dir>/<image>_<tag>_<platform>.tar.gz    本次版本
  <output-dir>/<image>_latest_<platform>.tar.gz   固定名，部署脚本用它

示例:
  ./build_image.sh --tag v1.2.0 --load
  ./build_image.sh --platform linux/arm64
EOF
}

while [[ $# -gt 0 ]]; do
  case "$1" in
    --tag)         IMAGE_TAG="$2"; shift 2 ;;
    --image-name)  IMAGE_NAME="$2"; shift 2 ;;
    --platform)    PLATFORM="$2"; shift 2 ;;
    --output-dir)  OUTPUT_DIR="$2"; shift 2 ;;
    --dart-image)  DART_IMAGE="$2"; shift 2 ;;
    --apt-mirror)  APT_MIRROR="$2"; shift 2 ;;
    --pub-hosted-url) PUB_HOSTED_URL="$2"; shift 2 ;;
    --keep)        KEEP_ARCHIVES="$2"; shift 2 ;;
    --load)        LOAD_IMAGE=true; shift ;;
    --no-cache)    NO_CACHE=true; shift ;;
    -h|--help)     usage; exit 0 ;;
    *) log_error "未知参数: $1"; usage; exit 1 ;;
  esac
done

# ---------- 预检 ----------
preflight() {
  log_info "检查构建环境..."

  if ! command -v docker >/dev/null 2>&1; then
    log_error "未找到 docker 命令"
    exit 1
  fi

  if ! docker info >/dev/null 2>&1; then
    log_error "Docker 未运行，请先启动 Docker Desktop"
    exit 1
  fi

  if ! docker buildx version >/dev/null 2>&1; then
    log_error "未安装 docker buildx"
    exit 1
  fi

  if [[ ! -f "${DOCKERFILE}" ]]; then
    log_error "未找到 Dockerfile: ${DOCKERFILE}"
    exit 1
  fi

  if [[ ! -f "${CONTEXT_DIR}/flutter_web_server/bin/main.dart" ]]; then
    log_error "未找到入口文件: ${CONTEXT_DIR}/flutter_web_server/bin/main.dart"
    exit 1
  fi

  # 目标平台与当前 builder 支持能力比对，避免跑到一半才报错
  local supported
  supported="$(docker buildx inspect 2>/dev/null | grep -i '^Platforms:' || true)"
  if [[ -n "${supported}" ]] && [[ "${supported}" != *"${PLATFORM}"* ]]; then
    log_warn "当前 builder 未声明支持 ${PLATFORM}，将尝试直接构建"
    log_warn "若失败请执行: docker buildx create --name multiarch --use --bootstrap"
  fi

  log_ok "环境检查通过"
}

# ---------- 构建 ----------
build_image() {
  local platform_suffix archive_name latest_name
  platform_suffix="$(echo "${PLATFORM}" | tr '/' '-')"
  archive_name="${IMAGE_NAME}_${IMAGE_TAG}_${platform_suffix}.tar.gz"
  latest_name="${IMAGE_NAME}_latest_${platform_suffix}.tar.gz"

  mkdir -p "${OUTPUT_DIR}"

  local full_tag="${IMAGE_NAME}:${IMAGE_TAG}"
  local tmp_tar="${OUTPUT_DIR}/${IMAGE_NAME}_${IMAGE_TAG}_${platform_suffix}.tar"
  rm -f "${tmp_tar}"

  local build_args=(
    --platform "${PLATFORM}"
    -f "${DOCKERFILE}"
    --build-arg "DART_IMAGE=${DART_IMAGE}"
    --build-arg "APT_MIRROR=${APT_MIRROR}"
    --build-arg "PUB_HOSTED_URL=${PUB_HOSTED_URL}"
    --provenance=false
  )

  if [[ "${NO_CACHE}" == "true" ]]; then
    build_args+=(--no-cache)
  fi

  # 直接导出 docker 格式 tar，跨架构比 --load + docker save 可靠
  build_args+=(
    --output "type=docker,dest=${tmp_tar}"
    -t "${full_tag}"
    -t "${IMAGE_NAME}:latest"
  )

  log_info "开始构建: ${full_tag} (平台: ${PLATFORM})"
  log_info "构建上下文: ${CONTEXT_DIR}"
  local start_time
  start_time="$(date +%s)"

  if ! docker buildx build "${build_args[@]}" "${CONTEXT_DIR}"; then
    log_error "镜像构建失败"
    rm -f "${tmp_tar}"
    exit 1
  fi

  local duration=$(( $(date +%s) - start_time ))
  log_ok "镜像构建完成，耗时 $((duration / 60)) 分 $((duration % 60)) 秒"

  if [[ ! -f "${tmp_tar}" ]]; then
    log_error "未生成镜像包: ${tmp_tar}"
    exit 1
  fi

  # ---------- 压缩 ----------
  log_info "压缩镜像包 ..."
  if ! gzip -9 -f "${tmp_tar}"; then
    log_error "压缩镜像包失败"
    exit 1
  fi

  mv -f "${tmp_tar}.gz" "${OUTPUT_DIR}/${archive_name}"
  cp -f "${OUTPUT_DIR}/${archive_name}" "${OUTPUT_DIR}/${latest_name}"

  if [[ "${LOAD_IMAGE}" == "true" ]]; then
    log_info "加载镜像到本地 docker ..."
    if docker load -i "${OUTPUT_DIR}/${archive_name}"; then
      log_ok "已加载: ${full_tag}"
    else
      log_warn "本地加载失败，但镜像包已生成，不影响部署"
    fi
  fi

  local size_bytes
  size_bytes="$(wc -c < "${OUTPUT_DIR}/${archive_name}" | tr -d ' ')"
  local size_human
  size_human="$(awk -v b="${size_bytes}" 'BEGIN{printf "%.1f MB", b/1024/1024}')"

  local checksum
  if command -v sha256sum >/dev/null 2>&1; then
    checksum="$(sha256sum "${OUTPUT_DIR}/${archive_name}" | awk '{print $1}')"
  else
    checksum="$(shasum -a 256 "${OUTPUT_DIR}/${archive_name}" | awk '{print $1}')"
  fi

  echo
  echo "${C_BOLD}================ 构建结果 ================${C_RESET}"
  echo "  镜像      : ${IMAGE_NAME}:${IMAGE_TAG}"
  echo "  别名      : ${IMAGE_NAME}:latest"
  echo "  平台      : ${PLATFORM}"
  echo "  大小      : ${size_human}"
  echo "  版本包    : ${OUTPUT_DIR}/${archive_name}"
  echo "  固定名包  : ${OUTPUT_DIR}/${latest_name}"
  echo "  sha256    : ${checksum}"
  echo "${C_BOLD}=========================================${C_RESET}"
  echo
}

# ---------- 清理本地历史包 ----------
cleanup_archives() {
  local platform_suffix
  platform_suffix="$(echo "${PLATFORM}" | tr '/' '-')"

  local archives=()
  while IFS= read -r file; do
    if [[ -n "${file}" ]]; then
      archives+=("${file}")
    fi
  done < <(find "${OUTPUT_DIR}" -maxdepth 1 -type f -name "${IMAGE_NAME}_[0-9]*_${platform_suffix}.tar.gz" -exec ls -t {} + 2>/dev/null || true)

  local count="${#archives[@]}"
  if [[ "${count}" -le "${KEEP_ARCHIVES}" ]]; then
    return 0
  fi

  log_info "清理本地历史包，保留最近 ${KEEP_ARCHIVES} 个..."
  local i
  for (( i = KEEP_ARCHIVES; i < count; i++ )); do
    log_info "删除: $(basename "${archives[$i]}")"
    rm -f "${archives[$i]}"
  done
}

preflight
build_image
cleanup_archives
log_ok "全部完成"
