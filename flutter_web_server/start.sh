#!/bin/bash

set -e

# 固定脚本所在目录（不要在函数里用 BASH_SOURCE 再计算，避免 cd 后变成相对路径 '.'）
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
REPO_ROOT="$(cd "$SCRIPT_DIR/.." && pwd)"

# ========== 彩色输出定义 ==========
if [[ -t 1 ]]; then
  tty_red="\033[0;31m"
  tty_green="\033[0;32m"
  tty_yellow="\033[0;33m"
  tty_blue="\033[0;34m"
  tty_cyan="\033[0;36m"
  tty_purple="\033[0;35m"
  tty_bold="\033[1m"
  tty_reset="\033[0m"
else
  tty_red="" tty_green="" tty_yellow="" tty_blue="" tty_cyan="" tty_purple="" tty_bold="" tty_reset=""
fi

# 颜色定义 (用于 dotfiles 配置)
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[38;5;226m[!]'
BLUE='\033[0;34m'
CYAN='\033[0;36m'
LIGHT_GRAY='\033[0;37m'
PURPLE='\033[0;35m'
BOLD='\033[1m'
RESET='\033[0m'

# ========== 彩色输出函数 ==========
function info() {
  echo -e "${tty_green}✅ $1${tty_reset}"
}

function warn() {
  echo -e "${tty_yellow}⚠️  $1${tty_reset}"
}

function error() {
  echo -e "${tty_red}❌ $1${tty_reset}"
}

function pause() {
  read -n1 -r -p "按任意键继续..." key
}

# 确保使用项目本地的 FVM Dart（供 dart / serverpod 命令使用）
function ensure_dart_in_path() {
  local dart_bin dart_dir
  dart_bin="$REPO_ROOT/.fvm/flutter_sdk/bin/dart"
  dart_dir="$(dirname "$dart_bin")"

  if [[ -x "$dart_bin" ]]; then
    # 仅当 PATH 中还未包含 dart_dir 时再追加，避免无限变长
    if [[ ":$PATH:" != *":$dart_dir:"* ]]; then
      export PATH="$dart_dir:$PATH"
    fi
  else
    echo -e "${tty_yellow}⚠️  未找到 Dart 可执行文件: $dart_bin，请确认已安装 FVM 并执行过 flutter_sdk 下载。${tty_reset}"
  fi
}

# 修复 system_resources_2 在 macOS 上缺失 dylib 的问题（libsysres-darwin-*.dylib）
# 参考: https://github.com/serverpod/system_resources_2
function fix_sysres_dylib() {
  print_separator
  echo -e "${tty_cyan}🧩 修复 system_resources_2 动态库缺失（macOS）...${tty_reset}"

  local os arch libname script_dir dest_dir
  os="$(uname -s)"
  arch="$(uname -m)"

  if [[ "$os" != "Darwin" ]]; then
    warn "当前系统不是 macOS（$os），无需修复 dylib。"
    return 0
  fi

  case "$arch" in
    arm64)  libname="libsysres-darwin-arm64.dylib" ;;
    x86_64) libname="libsysres-darwin-x86_64.dylib" ;;
    *)
      warn "未知架构：$arch（将尝试使用 arm64 动态库）"
      libname="libsysres-darwin-arm64.dylib"
      ;;
  esac

  script_dir="$SCRIPT_DIR"
  dest_dir="$script_dir/lib/build"
  mkdir -p "$dest_dir"

  # 允许通过环境变量显式指定 system_resources_2 路径
  # 例如：SYSRES2_DIR=/path/to/system_resources_2 ./start.sh
  local candidates=()
  if [[ -n "${SYSRES2_DIR:-}" ]]; then
    candidates+=("${SYSRES2_DIR%/}/lib/build/${libname}")
  fi

  # 你当前仓库结构：flutter_web_admin/system_resources_2 与 flutter_web_admin/flutter_web_server 同级
  candidates+=(
    "$script_dir/../system_resources_2/lib/build/$libname"
    "$script_dir/../../system_resources_2/lib/build/$libname"
    "$HOME/workspace/system_resources_2/lib/build/$libname"
  )

  local src=""
  for c in "${candidates[@]}"; do
    if [[ -f "$c" ]]; then
      src="$c"
      break
    fi
  done

  if [[ -z "$src" ]]; then
    error "未找到 ${libname}"
    echo -e "${tty_yellow}可尝试：${tty_reset}"
    echo -e "${tty_yellow}- 将 system_resources_2 放到 flutter_web_admin 同级目录：flutter_web_admin/system_resources_2${tty_reset}"
    echo -e "${tty_yellow}- 或设置环境变量 SYSRES2_DIR 指向 system_resources_2 目录${tty_reset}"
    echo -e "${tty_yellow}- 仓库地址：https://github.com/serverpod/system_resources_2${tty_reset}"
    return 1
  fi

  cp -f "$src" "$dest_dir/"
  JudgeSuccess "复制 ${libname} 到 flutter_web_server/lib/build"
  info "来源：$src"
  info "目标：$dest_dir/$libname"
  print_separator
}

# 判断执行是否成功
JudgeSuccess() {
  if [ $? -ne 0 ]; then
    error "步骤失败: $1"
    exit 1
  else
    info "步骤成功: $1"
  fi
}

# 分割线输出函数
print_separator() {
  printf "${LIGHT_GRAY}━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━${RESET}\n"
}

show_banner() {
  echo ""
  echo -e "╭──────────────────────────────────────────────╮"
  echo -e "│         \033[1;34m👋 欢迎使用 Serverpod 初始化脚本\033[0m     │"
  echo -e "╰──────────────────────────────────────────────╯"
  echo "作者: 李雪松"
  echo "版本: 1.0.0"
  echo ""
}

# ========== Serverpod 功能函数 ==========

# 从开发环境 docker-compose.yaml 中获取数据库名
function get_dev_db_name() {
  local compose_dir db_name
  compose_dir="$SCRIPT_DIR/docker/development"
  if [ ! -f "$compose_dir/docker-compose.yaml" ]; then
    error "未找到 $compose_dir/docker-compose.yaml，无法读取 POSTGRES_DB"
    return 1
  fi
  # macOS(BSD grep/sed) 不支持 \s，用 POSIX 空白类保证兼容性
  db_name=$(grep -E "^[[:space:]]*POSTGRES_DB:[[:space:]]*" "$compose_dir/docker-compose.yaml" | head -n 1 | sed -E 's/^[[:space:]]*POSTGRES_DB:[[:space:]]*//' | tr -d ' ')
  if [[ -z "$db_name" ]]; then
    error "无法从 $compose_dir/docker-compose.yaml 中读取 POSTGRES_DB"
    return 1
  fi
  echo "$db_name"
}

# 1. 启动 Serverpod
function start_serverpod() {
  print_separator
  echo -e "${tty_cyan}🚀 启动 Serverpod...${tty_reset}"
  
  # 需要清理的端口
  PORTS=(8080 8081 8082)
  
  echo -e "${tty_blue}🔍 检查并清理占用的端口...${tty_reset}"
  
  for port in "${PORTS[@]}"; do
    pid=$(lsof -ti :$port 2>/dev/null || true)
    if [ -n "$pid" ]; then
      warn "端口 $port 被进程 $pid 占用，正在清理..."
      kill -9 $pid 2>/dev/null
      info "已清理端口 $port"
    else
      info "端口 $port 未被占用"
    fi
  done
  
  echo -e "${tty_blue}🐳 启动 Docker 容器...${tty_reset}"
  cd ../docker/development && docker compose up --build --detach
  JudgeSuccess "Docker 容器启动"
  
  echo -e "${tty_blue}🗄️ 检查并创建数据库...${tty_reset}"
  
  # 从 docker-compose.yaml 文件中读取数据库名称
  DB_NAME=$(get_dev_db_name) || return 1
  
  echo -e "${tty_blue}📝 配置的数据库名称: $DB_NAME${tty_reset}"
  
  # 检查并创建 passwords.yaml 文件
  PASSWORDS_FILE="../../flutter_web_server/config/passwords.yaml"
  if [ ! -f "$PASSWORDS_FILE" ]; then
    warn "flutter_web_server/config/passwords.yaml 文件不存在，请手动创建并配置密码..."
  fi
  
  # 检查数据库是否存在，如果不存在则创建
  DB_EXISTS=$(docker exec development-postgres-1 psql -U postgres -tAc "SELECT 1 FROM pg_database WHERE datname='$DB_NAME';" 2>/dev/null)
  if [ "$DB_EXISTS" != "1" ]; then
    warn "数据库 '$DB_NAME' 不存在，正在创建..."
    CREATE_DB_OUTPUT=$(docker exec development-postgres-1 psql -U postgres -c "CREATE DATABASE \"$DB_NAME\" WITH ENCODING 'UTF8' LC_COLLATE 'en_US.utf8' LC_CTYPE 'en_US.utf8' TEMPLATE template0 OWNER postgres;" 2>&1)
    if [ $? -ne 0 ]; then
      error "数据库创建失败"
      echo -e "${tty_red}错误详情:${tty_reset}"
      echo -e "${tty_red}$CREATE_DB_OUTPUT${tty_reset}"
      return 1
    fi
    info "数据库 '$DB_NAME' 创建成功 (UTF8 编码, en_US.utf8 排序规则)"
  else
    info "数据库 '$DB_NAME' 已存在"
  fi
  
  echo -e "${tty_blue}⚡ 应用迁移...${tty_reset}"
  ensure_dart_in_path
  cd ../../flutter_web_server && dart run ./bin/main.dart --apply-migrations
  # cd ../../flutter_web_server && dart run ./bin/main.dart
  JudgeSuccess "迁移应用"
  
  echo -e "${tty_green}🎉 Serverpod 启动完成！${tty_reset}"
  print_separator
}

# 2. 生成代码
function generate_code() {
  print_separator
  echo -e "${tty_blue}⚙️ 执行代码生成...${tty_reset}"

  ensure_dart_in_path
  serverpod generate --experimental-features=all
  JudgeSuccess "代码生成"
  
  echo -e "${tty_green}🎉 代码生成完成！${tty_reset}"
  print_separator
}

# 3. 创建新的迁移文件并应用
function create_and_apply_migration() {
  print_separator
  echo -e "${tty_cyan}📝 创建新的迁移文件并应用...${tty_reset}"
  
  echo -e "${tty_blue}📝 创建新的迁移文件...${tty_reset}"
  ensure_dart_in_path
  serverpod create-migration --force
  JudgeSuccess "迁移文件创建"
  
  echo -e "${tty_blue}⚡ 应用新的迁移...${tty_reset}"
  dart run ./bin/main.dart --apply-migrations
  JudgeSuccess "迁移应用"
  
  echo -e "${tty_green}🎉 迁移文件创建并应用完成！${tty_reset}"
  print_separator
}

# 3b. 仅同步数据库表/字段注释
function sync_schema_comments() {
  print_separator
  echo -e "${tty_cyan}📝 同步数据库表/字段注释...${tty_reset}"

  echo -e "${tty_blue}🐳 确保 Docker 容器运行中...${tty_reset}"
  cd "$SCRIPT_DIR/docker/development" && docker compose up --detach
  JudgeSuccess "Docker 容器启动"

  DB_NAME=$(get_dev_db_name) || return 1
  echo -e "${tty_blue}📝 配置的数据库名称: $DB_NAME${tty_reset}"

  echo -e "${tty_blue}📝 生成注释 SQL...${tty_reset}"
  cd "$SCRIPT_DIR"
  ensure_dart_in_path
  dart run tool/generate_schema_comments.dart --out tool/generated/schema_comments.sql
  JudgeSuccess "注释SQL生成"

  if [ -f "tool/generated/schema_comments.sql" ]; then
    echo -e "${tty_blue}⚡ 应用注释 SQL 到数据库...${tty_reset}"
    cat "tool/generated/schema_comments.sql" | docker exec -i development-postgres-1 psql -U postgres -d "$DB_NAME" -v ON_ERROR_STOP=1 >/dev/null
    JudgeSuccess "注释SQL应用"
  else
    warn "未找到注释SQL文件，跳过应用"
  fi

  echo -e "${tty_green}🎉 数据库注释同步完成！${tty_reset}"
  print_separator
}

# 4. 重置数据库中的迁移记录
function reset_migration_records() {
  print_separator
  echo -e "${tty_cyan}🔄 重置数据库中的迁移记录...${tty_reset}"
  
  echo -e "${tty_blue}🐳 确保 Docker 容器运行中...${tty_reset}"
  cd ../docker/development && docker compose up --detach
  JudgeSuccess "Docker 容器启动"
  
  echo -e "${tty_blue}🔄 重置数据库中的迁移记录...${tty_reset}"
  docker exec development-postgres-1 psql -U postgres -d flutter_web_admin -c "DELETE FROM serverpod_migrations WHERE module = 'flutter_web_admin';" 2>/dev/null
  JudgeSuccess "迁移记录重置"
  
  echo -e "${tty_green}🎉 迁移记录重置完成！${tty_reset}"
  print_separator
}

# 5. 清理数据库（删除所有表）
function clean_database() {
  print_separator
  echo -e "${tty_cyan}🗄️ 清理数据库（删除所有表）...${tty_reset}"
  
  echo -e "${tty_yellow}⚠️ 警告：此操作将删除数据库中的所有数据！${tty_reset}"
  read -p "确认继续吗？(y/N): " confirm
  if [[ $confirm != [yY] ]]; then
    echo -e "${tty_yellow}操作已取消${tty_reset}"
    return
  fi
  
  echo -e "${tty_blue}🐳 确保 Docker 容器运行中...${tty_reset}"
  cd ../docker/development && docker compose up --detach
  JudgeSuccess "Docker 容器启动"
  
  echo -e "${tty_blue}🗄️ 清理数据库，删除所有现有的表...${tty_reset}"
  docker exec development-postgres-1 psql -U postgres -d flutter_web_admin -c "DROP SCHEMA public CASCADE; CREATE SCHEMA public;" 2>/dev/null
  JudgeSuccess "数据库清理"
  
  echo -e "${tty_green}🎉 数据库清理完成！${tty_reset}"
  print_separator
}

# 6. 删除数据库
function drop_database() {
  print_separator
  echo -e "${tty_cyan}🗑️ 删除数据库...${tty_reset}"
  
  # 获取数据库名称
  echo -e "${tty_blue}📝 请输入要删除的数据库名称:${tty_reset}"
  read -p "数据库名称: " db_name
  
  # 验证数据库名称不为空
  if [[ -z "$db_name" ]]; then
    error "数据库名称不能为空！"
    return
  fi
  
  # 显示警告信息
  echo -e "${tty_red}⚠️ 警告：此操作将永久删除数据库 '$db_name' 及其所有数据！${tty_reset}"
  echo -e "${tty_yellow}此操作不可撤销！${tty_reset}"
  
  # 第一次确认
  read -p "确认要删除数据库 '$db_name' 吗？(y/N): " confirm1
  if [[ $confirm1 != [yY] ]]; then
    echo -e "${tty_yellow}操作已取消${tty_reset}"
    return
  fi
  
  # 第二次确认
  echo -e "${tty_red}⚠️ 最后确认：您真的要删除数据库 '$db_name' 吗？${tty_reset}"
  read -p "请输入 'DELETE' 来确认删除: " confirm2
  if [[ $confirm2 != "DELETE" && $confirm2 != "delete" ]]; then
    echo -e "${tty_yellow}操作已取消${tty_reset}"
    return
  fi
  
  echo -e "${tty_blue}🐳 确保 Docker 容器运行中...${tty_reset}"
  cd ../docker/development && docker compose up --detach
  JudgeSuccess "Docker 容器启动"
  
  echo -e "${tty_blue}🗑️ 正在删除数据库 '$db_name'...${tty_reset}"
  
  # 先断开所有连接到该数据库的连接
  docker exec development-postgres-1 psql -U postgres -c "SELECT pg_terminate_backend(pid) FROM pg_stat_activity WHERE datname = '$db_name' AND pid <> pg_backend_pid();" 2>/dev/null
  
  # 删除数据库
  docker exec development-postgres-1 psql -U postgres -c "DROP DATABASE IF EXISTS \"$db_name\";" 2>/dev/null
  JudgeSuccess "数据库删除"
  echo -e "${tty_green}🎉 数据库 '$db_name' 删除完成！${tty_reset}"
  
  echo -e "${tty_blue}🛑 停止 Docker 容器...${tty_reset}"
  docker compose down
  JudgeSuccess "Docker 容器停止"
  
  print_separator
}

# 主菜单
function main_menu() {
  clear
  show_banner
  echo -e "\033[1;34m📦 请选择要执行的操作：\033[0m"
  echo ""
  echo -e "\033[1;33m1. 🚀 启动 Serverpod\033[0m"
  echo -e "\033[1;35m2. ⚙️  生成代码\033[0m"
  echo -e "\033[1;32m3. 📝 创建新的迁移文件并应用\033[0m"
  echo -e "\033[1;36m4. 🔄 重置数据库中的迁移记录\033[0m"
  echo -e "\033[1;31m5. 🗄️ 清理数据库（删除所有表）\033[0m"
  echo -e "\033[1;31m6. 🗑️ 删除数据库\033[0m"
  echo -e "\033[1;33m7. 📝 仅同步数据库表/字段注释\033[0m"
  echo -e "\033[1;34m8. 🧩 修复 system_resources_2 动态库缺失（macOS）\033[0m"
  echo -e "\033[1;31m0. ❌ 退出\033[0m"
  echo ""

  read -p "请选择你要执行的操作: " option
  case $option in
    1) start_serverpod && pause ;;
    2) generate_code && pause ;;
    3) create_and_apply_migration && pause ;;
    4) reset_migration_records && pause ;;
    5) clean_database && pause ;;
    6) drop_database && pause ;;
    7) sync_schema_comments && pause ;;
    8) fix_sysres_dylib && pause ;;
    0) exit 0 ;;
    *) error "未知选项: $option" && pause ;;
  esac
}

# 非交互模式入口，用于 VS Code Task
if [[ "$1" == "--start-serverpod" ]]; then
  start_serverpod
  exit $?
fi

# 默认进入交互菜单
main_menu
