#!/bin/bash

# 爱自然书店管理系统 - 字体下载脚本
# 此脚本用于下载和安装中文字体

# 定义颜色变量
readonly RED='\033[0;31m'
readonly GREEN='\033[0;32m'
readonly GOLD='\033[38;5;220m'
readonly BRIGHT_BLUE='\033[38;5;39m'
readonly NC='\033[0m'

# 定义表情符号
readonly EMOJI_INFO="📘"
readonly EMOJI_WARN="⚠️"
readonly EMOJI_ERROR="❌"
readonly EMOJI_DEBUG="🐛"
readonly EMOJI_SUCCESS="✅"
readonly EMOJI_START="🚀"
readonly EMOJI_END="🎉"
readonly EMOJI_FILE="📂"
readonly EMOJI_NETWORK="🌐"
readonly EMOJI_TOOLS="🛠️"
readonly EMOJI_CLEAN="🧹"

# 日志文件路径
readonly BUILD_LOG_FILE="download_font.log"

# 日志函数
log_info() { 
    local message="$*"
    echo -e "${GREEN}${EMOJI_INFO}[INFO] $message${NC}"
    echo "[$(date '+%Y-%m-%d %H:%M:%S')] [INFO] $message" >> "$BUILD_LOG_FILE"
}

log_warn() { 
    local message="$*"
    echo -e "${GOLD}${EMOJI_WARN}[WARN] $message${NC}"
    echo "[$(date '+%Y-%m-%d %H:%M:%S')] [WARN] $message" >> "$BUILD_LOG_FILE"
}

log_error() { 
    local message="$*"
    echo -e "${RED}${EMOJI_ERROR}[ERROR] $message${NC}"
    echo "[$(date '+%Y-%m-%d %H:%M:%S')] [ERROR] $message" >> "$BUILD_LOG_FILE"
}

log_debug() { 
    if [[ "${DEBUG:-false}" == "true" ]]; then
        local message="$*"
        echo -e "${BRIGHT_BLUE}${EMOJI_DEBUG} [DEBUG] $message${NC}"
        echo "[$(date '+%Y-%m-%d %H:%M:%S')] [DEBUG] $message" >> "$BUILD_LOG_FILE"
    fi
}

log_success() {
    local message="$*"
    echo -e "${GREEN}${EMOJI_SUCCESS} [SUCCESS] $message${NC}"
    echo "[$(date '+%Y-%m-%d %H:%M:%S')] [SUCCESS] $message" >> "$BUILD_LOG_FILE"
}

# 脚本开始
log_info "${EMOJI_START} 开始下载中文字体..."

# 创建字体目录
log_info "${EMOJI_FILE} 创建字体目录..."
mkdir -p web/assets/fonts

# 下载 Noto Serif CJK SC 字体包
log_info "${EMOJI_NETWORK} 下载 Noto Serif CJK SC 字体包..."

# 创建临时目录
TEMP_DIR=$(mktemp -d)
log_info "${EMOJI_FILE} 创建临时目录: $TEMP_DIR"

# 下载字体文件
log_info "${EMOJI_NETWORK} 下载字体文件..."
FONT_ZIP="$TEMP_DIR/NotoSerifCJKsc.zip"
curl -L "https://github.com/notofonts/noto-cjk/releases/download/Serif2.003/09_NotoSerifCJKsc.zip" -o "$FONT_ZIP"

# 解压字体文件
log_info "${EMOJI_FILE} 解压字体文件..."
unzip -q "$FONT_ZIP" -d "$TEMP_DIR"

# 复制需要的字体文件
log_info "${EMOJI_FILE} 复制字体文件..."
find "$TEMP_DIR" -name "NotoSerifCJKsc-Regular.otf" -exec cp {} web/assets/fonts/NotoSansSC-Regular.otf \;
find "$TEMP_DIR" -name "NotoSerifCJKsc-Medium.otf" -exec cp {} web/assets/fonts/NotoSansSC-Medium.otf \;
find "$TEMP_DIR" -name "NotoSerifCJKsc-Bold.otf" -exec cp {} web/assets/fonts/NotoSansSC-Bold.otf \;

# 如果没有找到 Medium 字重，使用 Regular 代替
if [ ! -f "web/assets/fonts/NotoSansSC-Medium.otf" ]; then
  log_warn "未找到 Medium 字重，使用 Regular 代替..."
  find "$TEMP_DIR" -name "NotoSerifCJKsc-Regular.otf" -exec cp {} web/assets/fonts/NotoSansSC-Medium.otf \;
fi

# 清理临时目录
log_info "${EMOJI_CLEAN} 清理临时目录..."
rm -rf "$TEMP_DIR"

# 检查文件是否下载成功
log_info "${EMOJI_FILE} 检查文件是否下载成功..."
if [ -f "web/assets/fonts/NotoSansSC-Regular.otf" ]; then
  log_success "字体文件下载成功！"
else
  log_error "字体文件下载失败，请检查网络连接或手动下载。"
  exit 1
fi

# 检查文件类型
log_info "${EMOJI_FILE} 检查文件类型..."
ls -la web/assets/fonts/

# 检查是否有 woff2_compress 工具，如果没有则安装
if ! command -v woff2_compress &> /dev/null; then
  log_warn "${EMOJI_TOOLS} 未找到 woff2_compress 工具，尝试安装 woff2..."
  if command -v brew &> /dev/null; then
    log_info "${EMOJI_TOOLS} 正在安装 woff2..."
    brew install woff2
  else
    log_error "未找到 Homebrew，无法安装 woff2。请手动安装 Homebrew 或 woff2。"
    log_info "提示: 安装 Homebrew: https://brew.sh/"
    log_info "提示: 安装 woff2: brew install woff2"
    exit 1
  fi
fi

# 使用 woff2_compress 转换字体
log_info "${EMOJI_TOOLS} 使用 woff2_compress 转换字体..."
woff2_compress "web/assets/fonts/NotoSansSC-Regular.otf"
woff2_compress "web/assets/fonts/NotoSansSC-Medium.otf"
woff2_compress "web/assets/fonts/NotoSansSC-Bold.otf"

# 删除 .otf 文件，只保留 .woff2 文件，保证资源文件最小化
log_info "${EMOJI_CLEAN} 删除旧的 .otf 文件..."
rm -f web/assets/fonts/NotoSansSC-Regular.otf
rm -f web/assets/fonts/NotoSansSC-Medium.otf
rm -f web/assets/fonts/NotoSansSC-Bold.otf

# 创建本地字体 CSS 文件
log_info "${EMOJI_FILE} 创建本地字体 CSS 文件..."

if [ -f "web/assets/fonts/NotoSansSC-Regular.woff2" ]; then
  # 创建 WOFF2 版本的 CSS
  cat > web/assets/fonts/noto-sans-sc-local.css << EOL
/* 本地 Noto Sans SC 字体 - WOFF2 格式 */
@font-face {
  font-family: 'Noto Sans SC';
  font-style: normal;
  font-weight: 400;
  font-display: swap;
  src: url('NotoSansSC-Regular.woff2') format('woff2');
  unicode-range: U+0000-00FF, U+0131, U+0152-0153, U+02BB-02BC, U+02C6, U+02DA, U+02DC, U+2000-206F, U+2074, U+20AC, U+2122, U+2191, U+2193, U+2212, U+2215, U+FEFF, U+FFFD, U+4E00-9FFF, U+3400-4DBF;
}

@font-face {
  font-family: 'Noto Sans SC';
  font-style: normal;
  font-weight: 500;
  font-display: swap;
  src: url('NotoSansSC-Medium.woff2') format('woff2');
  unicode-range: U+0000-00FF, U+0131, U+0152-0153, U+02BB-02BC, U+02C6, U+02DA, U+02DC, U+2000-206F, U+2074, U+20AC, U+2122, U+2191, U+2193, U+2212, U+2215, U+FEFF, U+FFFD, U+4E00-9FFF, U+3400-4DBF;
}

@font-face {
  font-family: 'Noto Sans SC';
  font-style: normal;
  font-weight: 700;
  font-display: swap;
  src: url('NotoSansSC-Bold.woff2') format('woff2');
  unicode-range: U+0000-00FF, U+0131, U+0152-0153, U+02BB-02BC, U+02C6, U+02DA, U+02DC, U+2000-206F, U+2074, U+20AC, U+2122, U+2191, U+2193, U+2212, U+2215, U+FEFF, U+FFFD, U+4E00-9FFF, U+3400-4DBF;
}
EOL
else
  # 创建 OTF 版本的 CSS
  cat > web/assets/fonts/noto-sans-sc-local.css << EOL
/* 本地 Noto Sans SC 字体 - OTF 格式 */
@font-face {
  font-family: 'Noto Sans SC';
  font-style: normal;
  font-weight: 400;
  font-display: swap;
  src: url('NotoSansSC-Regular.otf') format('opentype');
  unicode-range: U+0000-00FF, U+0131, U+0152-0153, U+02BB-02BC, U+02C6, U+02DA, U+02DC, U+2000-206F, U+2074, U+20AC, U+2122, U+2191, U+2193, U+2212, U+2215, U+FEFF, U+FFFD, U+4E00-9FFF, U+3400-4DBF;
}

@font-face {
  font-family: 'Noto Sans SC';
  font-style: normal;
  font-weight: 500;
  font-display: swap;
  src: url('NotoSansSC-Medium.otf') format('opentype');
  unicode-range: U+0000-00FF, U+0131, U+0152-0153, U+02BB-02BC, U+02C6, U+02DA, U+02DC, U+2000-206F, U+2074, U+20AC, U+2122, U+2191, U+2193, U+2212, U+2215, U+FEFF, U+FFFD, U+4E00-9FFF, U+3400-4DBF;
}

@font-face {
  font-family: 'Noto Sans SC';
  font-style: normal;
  font-weight: 700;
  font-display: swap;
  src: url('NotoSansSC-Bold.otf') format('opentype');
  unicode-range: U+0000-00FF, U+0131, U+0152-0153, U+02BB-02BC, U+02C6, U+02DA, U+02DC, U+2000-206F, U+2074, U+20AC, U+2122, U+2191, U+2193, U+2212, U+2215, U+FEFF, U+FFFD, U+4E00-9FFF, U+3400-4DBF;
}
EOL
fi

log_success "${EMOJI_END} 字体下载完成！"
log_info "现在您可以运行 build_optimized_web.sh 来构建优化的 Web 应用。"