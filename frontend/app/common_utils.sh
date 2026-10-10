#!/bin/bash

# Common Script Utilities Library
# Author: Claude Assistant
# Purpose: 提供通用的脚本工具函数，方便其他脚本快速复用

set -e  # Exit on error

# =============================================================================
# 颜色定义
# =============================================================================
RED='\033[1;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
PURPLE='\033[0;35m'
CYAN='\033[0;36m'
WHITE='\033[1;37m'
NC='\033[0m' # No Color

# =============================================================================
# 输出函数
# =============================================================================

# 打印信息
print_info() {
    echo -e "${BLUE}[INFO]${NC} $1"
}

# 打印成功信息
print_success() {
    echo -e "${GREEN}[SUCCESS]${NC} $1"
}

# 打印错误信息
print_error() {
    echo -e "${RED}[ERROR]${NC} $1"
}

# 打印警告信息
print_warning() {
    echo -e "${YELLOW}[WARNING]${NC} $1"
}

# 打印调试信息
print_debug() {
    echo -e "${PURPLE}[DEBUG]${NC} $1"
}

# 打印标题
print_title() {
    echo -e "\n${CYAN}========================================${NC}"
    echo -e "${CYAN}$1${NC}"
    echo -e "${CYAN}========================================${NC}\n"
}

# 打印分隔线
print_separator() {
    echo -e "${BLUE}----------------------------------------${NC}"
}

# =============================================================================
# 环境检测函数
# =============================================================================

# 检测操作系统和Shell
detect_os_and_shell() {
    print_info "检测操作系统和Shell环境..."
    
    # 检测操作系统
    if [[ "$OSTYPE" == "darwin"* ]]; then
        OS="macOS"
    elif [[ "$OSTYPE" == "linux-gnu"* ]]; then
        OS="Linux"
    elif [[ "$OSTYPE" == "msys" ]] || [[ "$OSTYPE" == "cygwin" ]]; then
        OS="Windows"
    else
        print_error "不支持的操作系统: $OSTYPE"
        return 1
    fi
    
    # 检测Shell
    CURRENT_SHELL=$(basename "$SHELL")
    
    # 根据Shell确定配置文件
    case "$CURRENT_SHELL" in
        bash)
            if [[ "$OS" == "macOS" ]]; then
                CONFIG_FILE="$HOME/.bash_profile"
            else
                CONFIG_FILE="$HOME/.bashrc"
            fi
            ;;
        zsh)
            CONFIG_FILE="$HOME/.zshrc"
            ;;
        fish)
            CONFIG_FILE="$HOME/.config/fish/config.fish"
            ;;
        *)
            print_error "不支持的Shell: $CURRENT_SHELL"
            return 1
            ;;
    esac
    
    print_success "检测完成 - 系统: $OS, Shell: $CURRENT_SHELL"
    print_info "配置文件: $CONFIG_FILE"
    
    # 导出变量供其他函数使用
    export OS
    export CURRENT_SHELL
    export CONFIG_FILE
}

# 检查命令是否存在
check_command() {
    local cmd="$1"
    local install_hint="$2"
    
    if ! command -v "$cmd" &> /dev/null; then
        print_error "需要安装 $cmd 工具"
        if [ -n "$install_hint" ]; then
            print_info "$install_hint"
        fi
        return 1
    fi
    return 0
}

# =============================================================================
# 配置文件管理函数
# =============================================================================

# 备份配置文件
backup_config() {
    local config_file="$1"
    
    if [ -f "$config_file" ]; then
        local backup_file="${config_file}.backup.$(date +%Y%m%d_%H%M%S)"
        cp "$config_file" "$backup_file"
        print_info "已备份原配置文件到: $backup_file"
        return 0
    else
        print_warning "配置文件不存在，无需备份: $config_file"
        return 1
    fi
}

# 清理环境变量配置
cleanup_env_vars() {
    local config_file="$1"
    local var_prefix="$2"
    
    if [ ! -f "$config_file" ]; then
        print_warning "配置文件不存在: $config_file"
        return 1
    fi
    
    print_info "清理环境变量配置..."
    
    if [[ "$CURRENT_SHELL" == "fish" ]]; then
        # Fish shell: 移除 'set -x VARIABLE ...' 模式
        sed -i.tmp -E "/^[[:space:]]*set[[:space:]]+-x[[:space:]]+${var_prefix}/d" "$config_file" 2>/dev/null || true
    else
        # Bash/Zsh: 移除 'export VARIABLE=...' 模式
        sed -i.tmp -E "/^[[:space:]]*export[[:space:]]+${var_prefix}/d" "$config_file" 2>/dev/null || true
    fi
    
    # 清理临时文件
    rm -f "$config_file.tmp"
    print_success "已清理环境变量配置"
}

# 添加环境变量到配置文件
add_env_vars() {
    local config_file="$1"
    local var_prefix="$2"
    local base_url="$3"
    local api_key="$4"
    local auth_token="${5:-}"
    
    print_info "添加环境变量到配置文件..."
    
    # 备份原配置
    backup_config "$config_file"
    
    # 清理现有配置
    cleanup_env_vars "$config_file" "$var_prefix"
    
    # 根据Shell类型添加环境变量
    if [[ "$CURRENT_SHELL" == "fish" ]]; then
        cat >> "$config_file" << EOF

# ${var_prefix} Environment Variables
set -x ${var_prefix}_BASE_URL "$base_url"
set -x ${var_prefix}_API_KEY "$api_key"
set -x ${var_prefix}_AUTH_TOKEN "$auth_token"
# End ${var_prefix} Environment Variables
EOF
    else
        cat >> "$config_file" << EOF

# ${var_prefix} Environment Variables
export ${var_prefix}_BASE_URL="$base_url"
export ${var_prefix}_API_KEY="$api_key"
export ${var_prefix}_AUTH_TOKEN="$auth_token"
# End ${var_prefix} Environment Variables
EOF
    fi
    
    print_success "环境变量已写入配置文件"
}

# =============================================================================
# 环境变量显示函数
# =============================================================================

# 显示当前环境变量状态
display_env_vars() {
    local var_prefix="$1"
    
    print_info "当前环境变量状态："
    print_separator
    
    # 获取当前Shell类型以正确显示变量
    local current_shell=$(basename "$SHELL")
    
    if [[ "$current_shell" == "fish" ]]; then
        # Fish shell语法
        echo "${var_prefix}_BASE_URL=$(set -q ${var_prefix}_BASE_URL && echo \$${var_prefix}_BASE_URL || echo '(未设置)')"
        echo "${var_prefix}_API_KEY=$(set -q ${var_prefix}_API_KEY && echo '****'\$${var_prefix}_API_KEY: -4 || echo '(未设置)')"
        echo "${var_prefix}_AUTH_TOKEN=$(set -q ${var_prefix}_AUTH_TOKEN && echo \$${var_prefix}_AUTH_TOKEN || echo '(未设置)')"
    else
        # Bash/Zsh语法
        if [ -n "${!var_prefix}_BASE_URL" ]; then
            echo "${var_prefix}_BASE_URL=${!var_prefix}_BASE_URL"
        else
            echo "${var_prefix}_BASE_URL=(未设置)"
        fi
        
        if [ -n "${!var_prefix}_API_KEY" ]; then
            local api_key="${!var_prefix}_API_KEY"
            echo "${var_prefix}_API_KEY=****${api_key: -4}"
        else
            echo "${var_prefix}_API_KEY=(未设置)"
        fi
        
        if [ -n "${!var_prefix}_AUTH_TOKEN" ]; then
            echo "${var_prefix}_AUTH_TOKEN=${!var_prefix}_AUTH_TOKEN"
        else
            echo "${var_prefix}_AUTH_TOKEN=(未设置)"
        fi
    fi
    
    print_separator
}

# =============================================================================
# 验证函数
# =============================================================================

# 验证环境变量
verify_env_vars() {
    local var_prefix="$1"
    local base_url="${!var_prefix}_BASE_URL"
    local api_key="${!var_prefix}_API_KEY"
    local auth_token="${!var_prefix}_AUTH_TOKEN"
    
    print_info "验证环境变量..."
    
    if [ -n "$base_url" ] && [ -n "$api_key" ]; then
        print_success "环境变量验证成功"
        echo "${var_prefix}_BASE_URL: $base_url"
        echo "${var_prefix}_API_KEY: ****${api_key: -4}"
        echo "${var_prefix}_AUTH_TOKEN: ${auth_token:-\"\"}"
        return 0
    else
        print_error "环境变量验证失败"
        return 1
    fi
}

# 验证文件存在
verify_file() {
    local file_path="$1"
    local description="$2"
    
    if [ -f "$file_path" ]; then
        print_success "$description 验证成功: $file_path"
        return 0
    else
        print_error "$description 不存在: $file_path"
        return 1
    fi
}

# =============================================================================
# 激活配置函数
# =============================================================================

# 激活配置文件
activate_config() {
    local config_file="$1"
    
    print_info "激活配置..."
    
    if [ -f "$config_file" ]; then
        source "$config_file"
        print_success "配置文件已激活"
    else
        print_error "配置文件不存在: $config_file"
        return 1
    fi
    
    print_info "要在新的终端会话中使用，请运行以下命令："
    echo -e "${GREEN}source $config_file${NC}"
    print_info "或者重新打开终端窗口"
}

# =============================================================================
# 通用工具函数
# =============================================================================

# 显示重要提醒
show_important_reminder() {
    local message="$1"
    
    echo
    echo -e "${RED}╔══════════════════════════════════════════════════════════╗${NC}"
    echo -e "${RED}║                                                          ║${NC}"
    echo -e "${RED}║    $message${NC}"
    echo -e "${RED}║                                                          ║${NC}"
    echo -e "${RED}╚══════════════════════════════════════════════════════════╝${NC}"
    echo
}

# 检查是否为root用户
check_root() {
    if [[ $EUID -eq 0 ]]; then
        print_warning "检测到root用户权限，请确保这是预期的操作"
        return 0
    fi
    return 1
}

# 创建目录（如果不存在）
ensure_directory() {
    local dir_path="$1"
    
    if [ ! -d "$dir_path" ]; then
        mkdir -p "$dir_path"
        print_info "创建目录: $dir_path"
    fi
}

# 获取脚本所在目录
get_script_dir() {
    echo "$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
}

# 获取脚本名称
get_script_name() {
    echo "$(basename "${BASH_SOURCE[0]}")"
}

# =============================================================================
# 示例用法
# =============================================================================

# 如果直接运行此脚本，显示使用示例
if [[ "${BASH_SOURCE[0]}" == "${0}" ]]; then
    print_title "Common Script Utilities Library"
    print_info "这是一个工具库文件，不应该直接运行。"
    print_info "请在其他脚本中使用 'source common_utils.sh' 来引入这些函数。"
    print_info "查看 example_script.sh 了解使用示例。"
    exit 0
fi 