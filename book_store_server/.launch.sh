#!/bin/bash

set -e

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

# 判断执行是否成功
JudgeSuccess() {
  if [ $? -ne 0 ]; then
    error "步骤失败: $1"
    exit 1
  else
    info "步骤成功"
  fi
}

# 分割线输出函数
print_separator() {
  printf "${LIGHT_GRAY}━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━${RESET}\n"
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

# 1. 启动 Serverpod
function start_serverpod() {
  print_separator
  echo -e "${tty_cyan}🚀 启动 Serverpod...${tty_reset}"
  
  # 需要清理的端口
  PORTS=(8080 8081 8082)
  
  echo -e "${tty_blue}🔍 检查并清理占用的端口...${tty_reset}"
  
  for port in "${PORTS[@]}"; do
    pid=$(lsof -ti :$port 2>/dev/null)
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
  
  echo -e "${tty_blue}⚡ 应用迁移...${tty_reset}"
  cd ../../book_store_server && dart ./bin/main.dart --apply-migrations
  JudgeSuccess "迁移应用"
  
  echo -e "${tty_green}🎉 Serverpod 启动完成！${tty_reset}"
  print_separator
}

# 2. 创建新的迁移文件并应用
function create_and_apply_migration() {
  print_separator
  echo -e "${tty_cyan}📝 创建新的迁移文件并应用...${tty_reset}"
  
  echo -e "${tty_blue}📝 创建新的迁移文件...${tty_reset}"
  serverpod create-migration --force
  JudgeSuccess "迁移文件创建"
  
  echo -e "${tty_blue}⚡ 应用新的迁移...${tty_reset}"
  dart ./bin/main.dart --apply-migrations
  JudgeSuccess "迁移应用"
  
  echo -e "${tty_green}🎉 迁移文件创建并应用完成！${tty_reset}"
  print_separator
}

# 3. 重置数据库中的迁移记录
function reset_migration_records() {
  print_separator
  echo -e "${tty_cyan}🔄 重置数据库中的迁移记录...${tty_reset}"
  
  echo -e "${tty_blue}🐳 确保 Docker 容器运行中...${tty_reset}"
  cd ../docker/development && docker compose up --detach
  JudgeSuccess "Docker 容器启动"
  
  echo -e "${tty_blue}🔄 重置数据库中的迁移记录...${tty_reset}"
  docker exec development-postgres-1 psql -U postgres -d book_store -c "DELETE FROM serverpod_migrations WHERE module = 'book_store';" 2>/dev/null
  JudgeSuccess "迁移记录重置"
  
  echo -e "${tty_green}🎉 迁移记录重置完成！${tty_reset}"
  print_separator
}

# 4. 清理数据库（删除所有表）
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
  docker exec development-postgres-1 psql -U postgres -d book_store -c "DROP SCHEMA public CASCADE; CREATE SCHEMA public;" 2>/dev/null
  JudgeSuccess "数据库清理"
  
  echo -e "${tty_green}🎉 数据库清理完成！${tty_reset}"
  print_separator
}

# 主菜单
function main_menu() {
  clear
  show_banner
  echo -e "\033[1;34m📦 请选择要执行的操作：\033[0m"
  echo ""
  echo -e "\033[1;33m1. 🚀 启动 Serverpod\033[0m"
  echo -e "\033[1;32m2. 📝 创建新的迁移文件并应用\033[0m"
  echo -e "\033[1;36m3. 🔄 重置数据库中的迁移记录\033[0m"
  echo -e "\033[1;31m4. 🗄️ 清理数据库（删除所有表）\033[0m"
  echo -e "\033[1;31m0. ❌ 退出\033[0m"
  echo ""

  read -p "请选择你要执行的操作: " option
  case $option in
    1) start_serverpod && pause ;;
    2) create_and_apply_migration && pause ;;
    3) reset_migration_records && pause ;;
    4) clean_database && pause ;;
    0) exit 0 ;;
    *) error "未知选项: $option" && pause ;;
  esac
}

# 启动菜单
main_menu
