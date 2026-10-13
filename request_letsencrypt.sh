#!/usr/bin/env bash
set -Eeuo pipefail
umask 077

# ==============================================================================
#  Let's Encrypt 证书申请脚本（交互式版）
#  用法：bash request_letsencrypt.sh
#
#  验证模式：
#    HTTP-01  acme.sh standalone，要求域名解析到本机、公网 TCP 80 可访问且空闲。
#    DNS-01   当前支持阿里云 DNS API，可在 Mac、A 服务器或其他联网机器上申请。
#
#  可提供的环境变量（非必需，供无人值守/复用凭据时使用）：
#    Ali_Key / Ali_Secret  阿里云 DNS AccessKey（DNS-01 模式）
#    DEBUG=true            输出调试信息
#
#  安全说明：
#   - 不自动停止/启动 Nginx，避免误停其他业务；HTTP-01 需用户自行释放 80 端口。
#   - 不使用 --force，避免重复签发触发 CA 速率限制。
#   - 私钥文件权限 600，完整证书链文件权限 644。
# ==============================================================================

readonly SCRIPT_NAME="$(basename "$0")"

# ============================== 颜色定义（沿用 archiver） ==============================
readonly RED='\033[0;31m'
readonly GREEN='\033[0;32m'
readonly GOLD='\033[38;5;220m'
readonly BRIGHT_BLUE='\033[38;5;39m'
readonly NC='\033[0m'

# ============================== 输出函数（沿用 archiver） ==============================
log_info()  { echo -e "${GREEN}[INFO]${NC} $*"; }
log_warn()  { echo -e "${GOLD}[WARN]${NC} $*"; }
log_error() { echo -e "${RED}[ERROR]${NC} $*" >&2; }

log_debug() {
  if [[ "${DEBUG:-false}" == "true" ]]; then
    echo -e "${BRIGHT_BLUE}[DEBUG]${NC} $*"
  fi
  return 0
}

# 替代 echo -e，统一走 printf 处理转义
print() { printf "%b\n" "$*"; }

fail() { log_error "$*"; exit 1; }

# 错误处理：定位出错行号，便于排查
trap 'log_error "脚本在第 ${LINENO} 行发生错误，已退出。"' ERR

# ============================== 全局配置 ==============================
DOMAIN=""
EMAIL=""
MODE=""
DNS_PROVIDER=""
SSL_DIR=""
KEY_LENGTH="ec-256"
DNS_SLEEP="30"

ACME_HOME="${HOME}/.acme.sh"
ACME_BIN="${ACME_HOME}/acme.sh"

# 阿里云 DNS 凭据：优先取环境变量，未设置时由交互流程补全
Ali_Key="${Ali_Key:-}"
Ali_Secret="${Ali_Secret:-}"

# ============================== 帮助与校验 ==============================
print_help() {
  cat <<EOF
用法：
  bash ${SCRIPT_NAME}

本脚本为交互式脚本，直接运行即可，按提示依次选择/填写域名、邮箱、验证模式等选项。
不再接受命令行参数（仅保留 -h/--help）。

可选环境变量：
  Ali_Key / Ali_Secret  阿里云 DNS AccessKey（DNS-01 模式，未设置时交互式询问）
  DEBUG=true            输出调试信息

输出文件：
  <证书目录>/server.pem    完整证书链
  <证书目录>/server.key    证书私钥

注意：
  HTTP-01 standalone 要求域名公网解析到本机，且外部可访问本机 TCP 80 端口。
  DNS-01 只要求能管理该域名在阿里云 DNS 的解析记录，可在本地或另一台机器执行。
EOF
}

is_valid_domain() {
  [[ "$1" =~ ^([A-Za-z0-9]([A-Za-z0-9-]{0,61}[A-Za-z0-9])?\.)+[A-Za-z]{2,63}$ ]]
}

is_valid_email() {
  [[ "$1" =~ ^[A-Za-z0-9._%+-]+@[A-Za-z0-9.-]+\.[A-Za-z]{2,63}$ ]]
}

need_command() {
  command -v "$1" >/dev/null 2>&1 || fail "缺少必要命令：$1"
}

# 读取普通输入，结果存入全局变量 ANS（bash 3.2 无 nameref，故用全局变量）
ask() {
  printf "%b" "$1"
  if ! IFS= read -r ANS; then
    fail "输入被中断（EOF），已退出。"
  fi
}

# 读取敏感输入（不回显）
ask_secret() {
  printf "%b" "$1"
  if ! IFS= read -r -s ANS; then
    fail "输入被中断（EOF），已退出。"
  fi
  printf '\n'
}

# ============================== 菜单交互函数 ==============================
show_welcome() {
  print "${BRIGHT_BLUE}=================================================${NC}"
  print "${BRIGHT_BLUE}   Let's Encrypt 证书申请脚本（交互式）${NC}"
  print "${BRIGHT_BLUE}   作者：${GOLD}李雪松${NC} ${BRIGHT_BLUE}微信：${GREEN}CoderXSLee${NC}"
  print "${BRIGHT_BLUE}=================================================${NC}"
}

check_environment() {
  log_info "检查运行环境..."
  need_command curl
  need_command openssl
  log_info "环境检查通过。"
}

select_domain() {
  print "${GREEN}请输入需要签发证书的域名。${NC}"
  print "     例如：${GOLD}api.example.com${NC}"
  while true; do
    ask "${GREEN}请输入域名: ${NC}"
    DOMAIN="${ANS}"
    if [[ -z "${DOMAIN}" ]]; then
      log_error "域名不能为空，请重新输入。"
      continue
    fi
    if ! is_valid_domain "${DOMAIN}"; then
      log_error "域名格式不正确：${DOMAIN}，请重新输入。"
      continue
    fi
    break
  done
}

select_email() {
  print "${GREEN}请输入 Let's Encrypt 账户邮箱（用于到期提醒与账户找回）。${NC}"
  while true; do
    ask "${GREEN}请输入邮箱: ${NC}"
    EMAIL="${ANS}"
    if [[ -z "${EMAIL}" ]]; then
      log_error "邮箱不能为空，请重新输入。"
      continue
    fi
    if ! is_valid_email "${EMAIL}"; then
      log_error "邮箱格式不正确：${EMAIL}，请重新输入。"
      continue
    fi
    break
  done
}

select_mode() {
  print "${GREEN}请选择证书验证模式:${NC}"
  print "     1. http-01   （standalone，需域名解析到本机且公网 TCP 80 可访问）"
  print "     2. dns-01    （阿里云 DNS API，无需 80 端口，可在任意机器执行）"
  while true; do
    ask "${GREEN}请输入你的选择 (1-2): ${NC}"
    case "${ANS}" in
      1) MODE="http-01"; break ;;
      2) MODE="dns-01"; break ;;
      *) log_error "无效的选择，请输入 1 或 2" ;;
    esac
  done
}

select_dns_provider() {
  print "${GREEN}请选择 DNS 服务商:${NC}"
  print "     1. aliyun（阿里云）"
  print "${GOLD}当前仅支持阿里云，后续可按同一接口扩展其他服务商。${NC}"
  while true; do
    ask "${GREEN}请输入你的选择 (1): ${NC}"
    case "${ANS}" in
      1) DNS_PROVIDER="aliyun"; break ;;
      *) log_error "无效的选择，请输入 1" ;;
    esac
  done
}

select_key_length() {
  print "${GREEN}请选择证书密钥类型:${NC}"
  print "     1. ec-256    （推荐，默认，体积小、性能好）"
  print "     2. rsa-2048"
  print "     3. rsa-4096"
  while true; do
    ask "${GREEN}请输入你的选择 (1-3，直接回车默认 1): ${NC}"
    case "${ANS:-1}" in
      1) KEY_LENGTH="ec-256"; break ;;
      2) KEY_LENGTH="rsa-2048"; break ;;
      3) KEY_LENGTH="rsa-4096"; break ;;
      *) log_error "无效的选择，请输入 1-3" ;;
    esac
  done
}

select_ssl_dir() {
  local default_dir="${PWD}/ssl/${DOMAIN}"
  print "${GREEN}请输入证书输出目录。${NC}"
  print "     直接回车使用默认目录：${GOLD}${default_dir}${NC}"
  ask "${GREEN}证书目录: ${NC}"
  SSL_DIR="${ANS}"
  if [[ -z "${SSL_DIR}" ]]; then
    SSL_DIR="${default_dir}"
  else
    SSL_DIR="${SSL_DIR/#\~/${HOME}}"          # 展开 ~ 为家目录
    if [[ "${SSL_DIR}" != /* ]]; then
      SSL_DIR="${PWD}/${SSL_DIR}"             # 相对路径转绝对路径
    fi
  fi
  log_info "证书目录：${SSL_DIR}"
}

# DNS-01 凭据收集：环境变量 > acme.sh 已保存 > 交互式询问
collect_dns_credentials() {
  local account_conf="${ACME_HOME}/account.conf"
  local has_saved_key=0
  local has_saved_secret=0

  if [[ -f "${account_conf}" ]]; then
    grep -q '^SAVED_Ali_Key=' "${account_conf}" && has_saved_key=1 || true
    grep -q '^SAVED_Ali_Secret=' "${account_conf}" && has_saved_secret=1 || true
  fi

  if [[ -n "${Ali_Key}" ]]; then
    log_info "已从环境变量读取 Ali_Key。"
  elif [[ "${has_saved_key}" == "1" ]]; then
    log_info "检测到 acme.sh 已保存 Ali_Key，将直接复用。"
  else
    print "${GOLD}未检测到阿里云 DNS 凭据，请输入（建议使用权限受限的 RAM 子账号）。${NC}"
    while true; do
      ask "${GREEN}请输入阿里云 AccessKey ID（Ali_Key）: ${NC}"
      Ali_Key="${ANS}"
      if [[ -n "${Ali_Key}" ]]; then
        break
      fi
      log_error "Ali_Key 不能为空，请重新输入。"
    done
    export Ali_Key
  fi

  if [[ -n "${Ali_Secret}" ]]; then
    log_info "已从环境变量读取 Ali_Secret。"
  elif [[ "${has_saved_secret}" == "1" ]]; then
    log_info "检测到 acme.sh 已保存 Ali_Secret，将直接复用。"
  else
    while true; do
      ask_secret "${GREEN}请输入阿里云 AccessKey Secret（Ali_Secret，输入不回显）: ${NC}"
      Ali_Secret="${ANS}"
      if [[ -n "${Ali_Secret}" ]]; then
        break
      fi
      log_error "Ali_Secret 不能为空，请重新输入。"
    done
    export Ali_Secret
  fi
}

confirm_config() {
  print ""
  print "${BRIGHT_BLUE}==================== 配置确认 ====================${NC}"
  print "  ${BRIGHT_BLUE}目标域名${NC}：${GREEN}${DOMAIN}${NC}"
  print "  ${BRIGHT_BLUE}账户邮箱${NC}：${GREEN}${EMAIL}${NC}"
  print "  ${BRIGHT_BLUE}验证模式${NC}：${GREEN}${MODE}${NC}"
  if [[ "${MODE}" == "dns-01" ]]; then
    print "  ${BRIGHT_BLUE}DNS 服务商${NC}：${GREEN}${DNS_PROVIDER}${NC}"
  fi
  print "  ${BRIGHT_BLUE}密钥类型${NC}：${GREEN}${KEY_LENGTH}${NC}"
  print "  ${BRIGHT_BLUE}证书目录${NC}：${GREEN}${SSL_DIR}${NC}"
  print "${BRIGHT_BLUE}=================================================${NC}"
  print "     1. 确认并开始申请"
  print "     2. 取消"
  while true; do
    ask "${GREEN}请输入你的选择 (1-2): ${NC}"
    case "${ANS}" in
      1) break ;;
      2) log_warn "已取消，未执行任何操作。"; exit 0 ;;
      *) log_error "无效的选择，请输入 1 或 2" ;;
    esac
  done
}

# ============================== 执行流程 ==============================
install_acme() {
  if [[ ! -x "${ACME_BIN}" ]]; then
    log_info "未发现 acme.sh，开始安装到 ${ACME_HOME} ..."
    curl -fsSL https://get.acme.sh | sh -s email="${EMAIL}"
  fi
  [[ -x "${ACME_BIN}" ]] || fail "acme.sh 安装失败。请检查网络后重试。"

  log_info "设置默认 CA 为 Let's Encrypt..."
  "${ACME_BIN}" --set-default-ca --server letsencrypt
}

precheck_http_01() {
  # 仅做端口预检，不自动停止服务，避免误停用户的业务。
  if command -v lsof >/dev/null 2>&1; then
    if lsof -nP -iTCP:80 -sTCP:LISTEN >/dev/null 2>&1; then
      log_error "当前机器 TCP 80 端口已被占用："
      lsof -nP -iTCP:80 -sTCP:LISTEN >&2 || true
      fail "请自行停止占用 80 端口的服务，或重新运行并选择 DNS-01 模式。"
    fi
  elif command -v ss >/dev/null 2>&1; then
    if ss -ltn 'sport = :80' 2>/dev/null | grep -q ':80'; then
      fail "当前机器 TCP 80 端口已被占用。请释放端口或改用 DNS-01 模式。"
    fi
  else
    log_warn "未找到 lsof/ss，跳过本地 80 端口检查；请自行确认端口空闲。"
  fi
}

do_issue() {
  # 必须显式传 -m 邮箱：否则 acme.sh 会回落到 account.conf 里残留的旧值（可能是被 LE 拒绝的 example.com）
  local issue_args=(--issue -d "${DOMAIN}" -m "${EMAIL}" --server letsencrypt --keylength "${KEY_LENGTH}")

  if [[ "${MODE}" == "http-01" ]]; then
    precheck_http_01
    log_info "开始 HTTP-01 standalone 验证..."
    log_info "请确认 ${DOMAIN} 的公网 DNS 已解析到本机，且公网 TCP 80 可以访问。"
    issue_args+=(--standalone)
  else
    log_info "开始阿里云 DNS-01 验证..."
    log_info "此模式不会停止 Nginx，也不要求目标服务器开放 TCP 80 端口。"
    issue_args+=(--dns dns_ali --dnssleep "${DNS_SLEEP}")
  fi

  # 不加 --force：已有有效证书时由 acme.sh 按自身规则处理，避免不必要地重复签发。
  "${ACME_BIN}" "${issue_args[@]}"
}

install_cert() {
  log_info "将证书安装到固定路径..."
  local install_args=(--install-cert -d "${DOMAIN}"
    --key-file "${SSL_DIR}/server.key"
    --fullchain-file "${SSL_DIR}/server.pem")
  # ECC 证书需要 --ecc；RSA 证书不能带该参数。
  if [[ "${KEY_LENGTH}" == ec-* ]]; then
    install_args+=(--ecc)
  fi
  "${ACME_BIN}" "${install_args[@]}"

  [[ -s "${SSL_DIR}/server.key" ]] || fail "私钥文件未生成：${SSL_DIR}/server.key"
  [[ -s "${SSL_DIR}/server.pem" ]] || fail "证书文件未生成：${SSL_DIR}/server.pem"

  chmod 600 "${SSL_DIR}/server.key"
  chmod 644 "${SSL_DIR}/server.pem"
}

show_cert_info() {
  log_info "检查证书信息..."
  openssl x509 -in "${SSL_DIR}/server.pem" -noout -dates -issuer -subject
}

show_summary() {
  print ""
  log_info "证书申请并安装完成。"
  print "  ${BRIGHT_BLUE}完整证书链${NC}：${GOLD}${SSL_DIR}/server.pem${NC}"
  print "  ${BRIGHT_BLUE}私钥文件${NC}：  ${GOLD}${SSL_DIR}/server.key${NC}"
  print ""
  log_warn "DNS-01 使用 API 凭据可自动续期；HTTP-01 standalone 续期时仍要求公网 TCP 80 可用。"
  log_info "如果证书用于另一台服务器，请通过 SSH/SCP 等安全方式传输，并在目标服务器上配置证书路径。"
}

# ============================== 主程序 ==============================
main() {
  if [[ "${1:-}" == "-h" || "${1:-}" == "--help" ]]; then
    print_help
    exit 0
  fi
  if [[ $# -gt 0 ]]; then
    log_error "本脚本为交互式脚本，不支持参数：$*"
    print_help
    exit 2
  fi

  # 设置终端窗口标题
  echo -ne "\033]0;Let's Encrypt 证书申请脚本\007"

  show_welcome
  check_environment

  # 采集所有配置项
  select_domain
  select_email
  select_mode
  if [[ "${MODE}" == "dns-01" ]]; then
    select_dns_provider
  fi
  select_key_length
  select_ssl_dir
  if [[ "${MODE}" == "dns-01" ]]; then
    collect_dns_credentials
  fi

  # 二次确认，避免误操作
  confirm_config

  # 准备证书目录
  mkdir -p "${SSL_DIR}"
  chmod 700 "${SSL_DIR}"

  log_debug "MODE=${MODE} KEY_LENGTH=${KEY_LENGTH} SSL_DIR=${SSL_DIR}"
  install_acme
  do_issue
  install_cert
  show_cert_info
  show_summary
}

main "$@"
