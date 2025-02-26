#!/bin/bash
readonly SCRIPT_VERSION="1.0.0"
readonly SCRIPT_NAME=$(basename "$0")

# 获取目录路径
readonly SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
readonly PROJECT_DIR="${SCRIPT_DIR}"  # 脚本就在项目根目录

# 创建必要的目录
mkdir -p "${PROJECT_DIR}/archive/android"
mkdir -p "${PROJECT_DIR}/archive/ios/AdHoc"
mkdir -p "${PROJECT_DIR}/archive/ios/AppStore"
mkdir -p "${PROJECT_DIR}/build/build_log"

# 定义日志文件路径
readonly BUILD_LOG_DIR="${PROJECT_DIR}/build/build_log"
readonly BUILD_LOG_FILE="${BUILD_LOG_DIR}/build_$(date +%Y%m%d_%H%M%S).log"

# 定义颜色变量
readonly RED='\033[0;31m'
readonly GREEN='\033[0;32m'
readonly GOLD='\033[38;5;220m'
readonly BRIGHT_BLUE='\033[38;5;39m'
readonly NC='\033[0m'

# ==============================初始化=====================================================
#
# 设置错误处理
trap 'handle_error ${LINENO} $?' ERR
trap cleanup EXIT

# 进入工作目录
cd "${PROJECT_DIR}" || { echo "无法进入工作目录: ${PROJECT_DIR}"; exit 1; }

# 设置iTerm2窗口标题
echo -ne "\033]0;李雪松App打包脚本\007"

# API Key from Pgyer
readonly API_KEY="5bce8816cc52da76dc4e7ae5d7d30ff1"
# 更新日志文件的绝对路径
readonly LOG_FILE="archive_update_log.md"

# 初始化上传路径数组
upload_paths=()

clear

# ==============================工具函数=====================================================
#                               
# 检查并创建必要的目录
ensure_directories() {
    local directories=(
        "archive/android"
        "archive/ios/AdHoc"
        "archive/ios/AppStore"
        "build/build_log"
        "build/ios/ipa"
    )

    for dir in "${directories[@]}"; do
        if [[ ! -d "$dir" ]]; then
            log_info "创建目录: $dir"
            mkdir -p "$dir"
            if [[ ! -d "$dir" ]]; then
                log_error "无法创建目录: $dir"
                return 1
            fi
        fi
    done
    
    print "${GOLD}所有必要的目录已准备就绪${NC}"
    return 0
}

# 日志函数
log_info() { 
    local message="$*"
    echo -e "${GREEN}[INFO]${NC} $message"
    echo "[$(date '+%Y-%m-%d %H:%M:%S')] [INFO] $message" >> "$BUILD_LOG_FILE"
}

# 只写入日志文件的日志函数
log_file() {
    local message="$*"
    echo "[$(date '+%Y-%m-%d %H:%M:%S')] $message" >> "$BUILD_LOG_FILE"
}

log_warn() { 
    local message="$*"
    echo -e "${GOLD}[WARN]${NC} $message"
    echo "[$(date '+%Y-%m-%d %H:%M:%S')] [WARN] $message" >> "$BUILD_LOG_FILE"
}

log_error() { 
    local message="$*"
    echo -e "${RED}[ERROR]${NC} $message"
    echo "[$(date '+%Y-%m-%d %H:%M:%S')] [ERROR] $message" >> "$BUILD_LOG_FILE"
}

log_debug() { 
    if [[ "${DEBUG:-false}" == "true" ]]; then
        local message="$*"
        echo -e "${BRIGHT_BLUE}[DEBUG]${NC} $message"
        echo "[$(date '+%Y-%m-%d %H:%M:%S')] [DEBUG] $message" >> "$BUILD_LOG_FILE"
    fi
}

# 定义一个函数来替代 echo -e
print() { 
    local message="$*"
    printf "%b\n" "$message"
    echo "[$(date '+%Y-%m-%d %H:%M:%S')] $message" >> "$BUILD_LOG_FILE"
}

# 清理函数
cleanup() {
    log_debug "执行清理操作..."
    # 压缩当天的日志文件
    if [[ -f "$BUILD_LOG_FILE" ]]; then
        gzip -9 "$BUILD_LOG_FILE"
        log_info "\n日志文件已压缩: ${BUILD_LOG_FILE}.gz"
    fi
}

# 错误处理函数
handle_error() {
    local line_number=$1
    local error_code=$2
    log_error "脚本在第 ${line_number} 行发生错误，错误代码: ${error_code}"
    cleanup
    print "\n${RED}程序执行出现错误，请检查以上日志信息。${NC}"
    print "${GREEN}按回车键退出程序...${NC}"
    read -r
}

# ==============================日志初始化函数=====================================================
init_log() {
    # 创建日志目录
    if [[ ! -d "$BUILD_LOG_DIR" ]]; then
        mkdir -p "$BUILD_LOG_DIR"
        log_info "创建日志目录: $BUILD_LOG_DIR"
    fi

    # 初始化日志文件
    echo "=== 构建日志开始 ===" > "$BUILD_LOG_FILE"
    echo "时间: $(date '+%Y-%m-%d %H:%M:%S')" >> "$BUILD_LOG_FILE"
    echo "脚本版本: $SCRIPT_VERSION" >> "$BUILD_LOG_FILE"
    echo "工作目录: $PROJECT_DIR" >> "$BUILD_LOG_FILE"
    echo "===========================" >> "$BUILD_LOG_FILE"
    
    # 记录系统环境信息
    {
        echo "系统信息:"
        echo "OS: $(uname -s)"
        echo "OS Version: $(sw_vers -productVersion)"
        echo "Flutter Version: $(flutter --version)"
        echo "Xcode Version: $(xcodebuild -version)"
        echo "===========================" 
    } >> "$BUILD_LOG_FILE"

    clear
}

# 检查必要的环境和工具
check_environment() {
    log_info "检查环境配置..."
    
    log_info "日志文件初始化完成: /build/build_log"

    # 检查 Flutter
    if ! command -v flutter &> /dev/null; then
        log_error "Flutter 未安装，请先安装 Flutter"
    fi
    
    # 检查 Xcode（仅在 macOS 上）
    if [[ "$(uname)" == "Darwin" ]]; then
        if ! command -v xcodebuild &> /dev/null; then
            log_error "Xcode 未安装，请先安装 Xcode"
        fi
    fi
    
    # 检查 Java（用于 Android 构建）
    if ! command -v java &> /dev/null; then
        log_warn "Java 未安装，Android 构建可能会失败"
    fi
    
}

# 显示帮助信息
show_help() {
    cat << EOF
使用方法: ${SCRIPT_NAME} [选项]

选项:
    -h, --help      显示此帮助信息
    -v, --version   显示版本信息
    -q, --quiet     静默模式
    -d, --debug     调试模式
    
示例:
    ${SCRIPT_NAME} --help
    ${SCRIPT_NAME} --debug
EOF
    exit 0
}

# ==============================用户交互函数==================================================
show_welcome() {
    # 用户选择打包选项
    print "${BRIGHT_BLUE}欢迎使用 App 打包脚本${NC}"
    print "${BRIGHT_BLUE}作者：${GOLD}李雪松${NC} ${BRIGHT_BLUE}微信：${GREEN}CoderXSLee${NC}"
}

# 
select_platform() {

    print "${GREEN}请选择要打包的平台:${NC}"
    print "     1. Android"
    print "     2. HarmonyOS"
    print "     3. iOS Ad Hoc"
    print "     4. iOS App Store"
    print "     5. 全部"
    print "${GREEN}支持多选，请用空格分开。${GREEN}例如：${NC}1 3"
    while true; do
        printf "${GREEN}请输入你的选择: ${NC}"
        read choices
        if [[ $choices =~ ^[1-5]([ ][1-5])*$ ]]; then
            break
        else
            log_error "输入格式不正确，请重新输入"
        fi
    done

    # 如果选择了选项1（Android），询问是否上传到 Pgyer
    if [[ "$choices" == *"1"* ]]; then
        print "${GREEN}是否将 Android 版本上传到 Pgyer？${NC}"
        print "     1. 上传"
        print "     2. 不上传"
        while true; do
            printf "${GREEN}请输入你的选择: ${NC}"
            read upload_android_to_pgyer
            if [[ $upload_android_to_pgyer =~ ^[12]$ ]]; then
                break
            else
                log_error "请输入有效的选项（1 或 2）"
            fi
        done
    fi

    # 检查用户是否选择了 Ad Hoc (选项3)，询问是否上传到 Pgyer
    if [[ "$choices" == *"3"* ]]; then
        print "${GREEN}是否将 iOS Ad Hoc 版本上传到 Pgyer ？${NC}"
        print "     1. 上传"
        print "     2. 不上传"
        #printf "${GREEN}请输入你的选择: ${NC}"
        #read upload_to_pgyer
        while true; do
            printf "${GREEN}请输入你的选择: ${NC}"
            read upload_to_pgyer
            if [[ $upload_to_pgyer =~ ^[12]$ ]]; then
                break
            else
                log_error "请输入有效的选项（1 或 2）"
            fi
        done
    fi

    # 检查用户是否选择了 App Store (选项4)，询问是否上传到 App Store Connect
    if [[ "$choices" == *"4"* ]]; then
        print "${GREEN}是否将 iOS App Store 版本上传到 App Store Connect ？${NC}"
        print "     1. 上传"
        print "     2. 不上传"
        while true; do
            printf "${GREEN}请输入你的选择: ${NC}"
            read upload_to_app_store_connect
            if [[ $upload_to_app_store_connect =~ ^[12]$ ]]; then
                break
            else
                log_error "请输入有效的选项（1 或 2）"
            fi
        done
    fi
}



handle_version() {
    # 读取当前版本号
    current_version=$(grep '^version: ' pubspec.yaml | awk '{print $2}')
    
    # 检查版本号格式
    if [[ ! $current_version =~ ^[0-9]+\.[0-9]+\.[0-9]+\+[0-9]+$ ]]; then
        print "${RED}警告: 当前版本号格式不标准，正在自动修正...${NC}"
        
        # 提取版本号部分（处理可能的异常格式）
        if [[ $current_version == *"+"* ]]; then
            base_version=$(echo $current_version | cut -d '+' -f 1)
            build_number=$(echo $current_version | cut -d '+' -f 2)
        else
            base_version=$current_version
            build_number=$(date +'%m%d%H%M')01
        fi
        
        # 确保版本号格式为 x.x.x
        if [[ ! $base_version =~ ^[0-9]+\.[0-9]+\.[0-9]+$ ]]; then
            # 拆分现有版本号
            IFS='.' read -ra VERSION_PARTS <<< "$base_version"
            
            # 补全缺失的版本号部分
            major=${VERSION_PARTS[0]:-1}
            minor=${VERSION_PARTS[1]:-0}
            patch=${VERSION_PARTS[2]:-0}
            
            # 重新组装标准格式的版本号
            base_version="${major}.${minor}.${patch}"
        fi
        
        # 确保构建号为12位数字
        if [[ ${#build_number} -lt 12 ]]; then
            # 补零直到12位
            while [[ ${#build_number} -lt 12 ]]; do
                build_number="${build_number}0"
            done
        elif [[ ${#build_number} -gt 12 ]]; then
            # 如果超过12位，截取前12位
            build_number=${build_number:0:12}
        fi
        
        # 更新版本号
        current_version="${base_version}+${build_number}"
        sed -i '' "s/^version: .*/version: ${current_version}/" pubspec.yaml
        print "${GREEN}版本号已自动修正为: ${current_version}${NC}"
    fi
    
    # 提取版本号部分和构建号部分
    base_version=$(echo $current_version | cut -d '+' -f 1) # 取出版本号的前半部分 1.5.x
    build_number=$(echo $current_version | cut -d '+' -f 2) # 取出 build number 部分

    # 拆解版本号（主版本号、次版本号、补丁版本号）
    major=$(echo $base_version | cut -d '.' -f 1) # 取 1.5.x 中的 1
    minor=$(echo $base_version | cut -d '.' -f 2) # 取 1.5.x 中的 5
    patch=$(echo $base_version | cut -d '.' -f 3) # 取 1.5.x 中的 x

    # 提示当前软件版本号和选择版本号的递增方式
    print "当前的软件版本为：${GREEN}${base_version}${NC} 请选择版本号的递增方式："
    print "     ${BRIGHT_BLUE}1. 递增补丁版本 ${BRIGHT_BLUE}(从当前 ${base_version} -> 修改为 ${major}.${minor}.$((patch + 1)))${NC}"
    print "     ${BRIGHT_BLUE}2. 递增次版本 ${BRIGHT_BLUE}(从当前 ${base_version} -> 修改为 ${major}.$((minor + 1)).0)${NC}"
    print "     ${BRIGHT_BLUE}3. 递增主版本 ${BRIGHT_BLUE}(从当前 ${base_version} -> 修改为 $((major + 1)).0.0)${NC}"
    print "     ${BRIGHT_BLUE}4. 不修改${NC}"
    print "     ${BRIGHT_BLUE}5. 手动输入${NC}"

    # 获取用户输入选择
    while true; do
        printf "${GREEN}请输入您的选择 (1~5): ${NC}"
        read version_choice
        case $version_choice in
          1)
                new_patch=$((patch + 1))
                base_version="${major}.${minor}.${new_patch}"
                break
            ;;
          2)
                new_minor=$((minor + 1))
                base_version="${major}.${new_minor}.0"
                break
            ;;
          3)
                new_major=$((major + 1))
                base_version="${new_major}.0.0"
                break
            ;;
          4)
                break
            ;;
          5)
                while true; do
                    printf "${GREEN}请输入自定义的软件版本号 (格式: 1.x.x): ${NC}"
                    read custom_version
                    if [[ $custom_version =~ ^[0-9]+\.[0-9]+\.[0-9]+$ ]]; then
                        base_version=$custom_version
                        major=$(echo $base_version | cut -d '.' -f 1)
                        minor=$(echo $base_version | cut -d '.' -f 2)
                        patch=$(echo $base_version | cut -d '.' -f 3)
                        break
                    else
                        log_error "版本号格式不正确，请重新输入"
                    fi
                done
                break
            ;;
          *)
            log_error "无效的选择，请输入 1-5 之间的数字"
            continue
            ;;
        esac
    done

    print "软件版本号已修改为：${GREEN}${base_version}${NC}"

    # 生成新的构建号
    # 计算当前时间作为构建版本号的前10位（格式：YYMMDDHHMM）
    timestamp=$(date +'%m%d%H%M')

    # 提取构建版本号的最后两位
    last_two_digits=${build_number: -2}      # 提取最后两位

    # 递增最后两位数字并确保格式为两位数
    incremented_digits=$((10#$last_two_digits + 1))
    incremented_digits=$(printf "%02d" $incremented_digits) # 确保补足两位数

    # 构建新的构建版本号：当前时间 + 递增后的最后两位
    new_build_number="${timestamp}${incremented_digits}"

    # 分析和比较当前与递增后的构建版本号，区分变化的部分
    diff_build_number=""
    for ((i=0; i<${#build_number}; i++)); do
        old_char=${build_number:i:1}
        new_char=${new_build_number:i:1}
        if [ "$old_char" != "$new_char" ]; then
            diff_build_number="${diff_build_number}${GREEN}${new_char}${NC}"
        else
            diff_build_number="${diff_build_number}${old_char}"
        fi
    done

    # 显示提示信息，差异化显示
    print "当前的构建版本号：${build_number}"
    print "递增后构建版本号：${diff_build_number}"
    printf "${GREEN}是否需要递增构建版本号？(1=yes/*=n): ${NC}"
    read increment_build

    # 判断用户输入
    if [[ $increment_build =~ ^[1]$ ]]; then
        new_version="${new_build_number}" # 使用递增后的版本号
    else
        new_version="${timestamp}${last_two_digits}" # 如果用户输入 n，则只保留最后两位不变，前面的时间使用当前时间
    fi

    # 使用 sed 替换 pubspec.yaml 中的 version 字段
    sed -i '' "s/^version: .*/version: ${base_version}+${new_version}/" pubspec.yaml

    # 修改 Info.plist 中 CFBundleVersion 的值
    PLIST_PATH="./ios/Runner/Info.plist"

    # 使用 PlistBuddy 更新 CFBundleVersion
    /usr/libexec/PlistBuddy -c "Set :CFBundleVersion $new_version" "$PLIST_PATH"

    if [ $? -eq 0 ]; then
        # 显示最终版本号
        print "本次打包的版本号为：${GREEN}${base_version}+${new_version}${NC}"
    else
        print "${RED}CFBundleVersion 更新失败！${NC}"
    fi

}

# =========================================================================================
#                                 构建函数 
# =========================================================================================

# 删除原有的进度条函数，替换为新的动画函数
show_build_animation() {
    local pid=$1
    local message=$2
    local frames=(
        "▱▱▱▱▱▱▱▱▱▱"
        "▰▱▱▱▱▱▱▱▱▱"
        "▰▰▱▱▱▱▱▱▱▱"
        "▰▰▰▱▱▱▱▱▱▱"
        "▰▰▰▰▱▱▱▱▱▱"
        "▰▰▰▰▰▱▱▱▱▱"
        "▰▰▰▰▰▰▱▱▱▱"
        "▰▰▰▰▰▰▰▱▱▱"
        "▰▰▰▰▰▰▰▰▱▱"
        "▰▰▰▰▰▰▰▰▰▱"
        "▰▰▰▰▰▰▰▰▰▰")
    local i=0
    
    # 记录开始时间
    local start_time=$(date +%s)
    
    # 打印固定的消息
    printf "${GREEN}%s %s " "${message}" "${frames[0]}"
    
    # 保存当前位置
    local pos=$((${#message} + 2))
    
    while [ "$(ps a | awk '{print $1}' | grep $pid)" ]; do
        printf "\r${GREEN}%s %s " "${message}" "${frames[$i]}"
        i=$(( (i + 1) % ${#frames[@]} ))
        sleep 0.05
    done
    
    # 计算用时
    local end_time=$(date +%s)
    local duration=$((end_time - start_time))
    
    # 最后显示完成状态并换行
    printf "\r${GREEN}%s %s ${NC}\n" "${message}" "${frames[${#frames[@]}-1]}"
    print "构建完成！${GREEN}用时 ${duration} 秒${NC}"
} 

# Android 平台
# 
build_android() {
    # 确保目录存在
    ensure_directories || return 1

    log_file "[INFO] 开始构建 Android 平台应用..."

    # 记录构建开始时间
    local build_start_time=$(date '+%Y-%m-%d %H:%M:%S')
    log_file "[INFO] Android 构建开始时间: $build_start_time"

    # 执行构建命令并在后台运行
    flutter build apk --release > /dev/null 2>&1 &
    build_pid=$!
    
    # 显示构建动画
    show_build_animation $build_pid "正在构建 Android 应用"

    # 记录构建结束时间
    local build_end_time=$(date '+%Y-%m-%d %H:%M:%S')
    log_file "[INFO] Android 构建结束时间: $build_end_time"

    # 检查构建结果
    if [ -f build/app/outputs/flutter-apk/app-release.apk ]; then
        log_file "[INFO] 正在将 apk 文件移动到目录：archive/android/"
        mv build/app/outputs/flutter-apk/app-release.apk "${Android_File_Path}"
        log_file "[INFO] 已成功将 apk 文件移动到 ${Android_File_Path}"
        
        # 记录文件大小
        local file_size=$(ls -lh "${Android_File_Path}" | awk '{print $5}')
        log_file "[INFO] apk 文件大小: $file_size"
        print "${BRIGHT_BLUE}Android 平台 ${APP_NAME}.apk 打包完成！文件大小: $file_size ${NC} "

        open -R "${Android_File_Path}"
        upload_paths+=("${Android_File_Path}")
    else
        print "${RED}apk 文件生成失败。${NC}\n"
        log_error "Android 平台构建失败"
        return 1
    fi
}


# ============================================================================================
#                               iOS 平台 Ad Hoc 测试分发版
# ============================================================================================
build_ios_adhoc() {
    # 确保目录存在
    ensure_directories || return 1

    # 记录构建开始时间
    local build_start_time=$(date '+%Y-%m-%d %H:%M:%S')
    log_file "[INFO] iOS Ad Hoc 构建开始时间: $build_start_time"

    # 执行构建命令并在后台运行
    flutter build ipa --release --export-method ad-hoc > /dev/null 2>&1 &
    build_pid=$!
    
    # 显示构建动画
    show_build_animation $build_pid "正在构建 iOS Ad Hoc 版本"

    # 记录构建结束时间
    local build_end_time=$(date '+%Y-%m-%d %H:%M:%S')
    log_file "[INFO] iOS Ad Hoc 构建结束时间: $build_end_time"

    # 查找 build/ios/ipa 目录下的 .ipa 文件
    local ipa_file=$(find "build/ios/ipa" -name "*.ipa" -type f)
    
    # 检查是否找到 ipa 文件
    if [ -n "$ipa_file" ] && [ -f "$ipa_file" ]; then
        log_file "[INFO] 找到 ipa 文件: $ipa_file"
        log_file "[INFO] 正在将 ipa 文件移动到目录：archive/ios/AdHoc/"
        mv "$ipa_file" "${iOS_Ad_Hoc_File_Path}"
        
        if [ $? -eq 0 ]; then
            log_file "[INFO] 已成功将 ipa 文件移动到 ${iOS_Ad_Hoc_File_Path}"
            
            # 检查文件是否真实存在
            if [ ! -f "${iOS_Ad_Hoc_File_Path}" ]; then
                log_error "ipa 文件移动后未找到: ${iOS_Ad_Hoc_File_Path}"
                return 1
            fi
            
            # 记录文件大小
            local file_size=$(ls -lh "${iOS_Ad_Hoc_File_Path}" | awk '{print $5}')
            log_file "[INFO] ipa 文件大小: $file_size"
            print "${BRIGHT_BLUE}iOS 平台 Ad Hoc 版 ${APP_NAME}.ipa 文件大小: $file_size ${NC}"

            open -R "${iOS_Ad_Hoc_File_Path}"
            upload_paths+=("${iOS_Ad_Hoc_File_Path}")
        else
            log_error "移动 ipa 文件失败"
            return 1
        fi
    else
        print "${RED}ipa 文件生成失败。${NC}\n"
        log_error "iOS Ad Hoc 版本构建失败"
        return 1
    fi
}

# ============================================================================================
#                               iOS 平台 App Store 版
# ============================================================================================
build_ios_appstore() {
    # 确保目录存在
    ensure_directories || return 1
    
    # 记录构建开始时间
    local build_start_time=$(date '+%Y-%m-%d %H:%M:%S')
    log_file "[INFO] iOS App Store 构建开始时间: $build_start_time"

    # 执行构建命令并在后台运行
    flutter build ipa --release --export-method app-store > /dev/null 2>&1 &
    build_pid=$!
    
    # 显示构建动画
    show_build_animation $build_pid "正在构建 iOS App Store 版本"

    # 记录构建结束时间
    local build_end_time=$(date '+%Y-%m-%d %H:%M:%S')
    log_file "[INFO] iOS App Store 构建结束时间: $build_end_time"

    # 查找 build/ios/ipa 目录下的 .ipa 文件
    local ipa_file=$(find "build/ios/ipa" -name "*.ipa" -type f)
    
    # 检查是否找到 ipa 文件
    if [ -n "$ipa_file" ] && [ -f "$ipa_file" ]; then
        log_file "[INFO] 找到 ipa 文件: $ipa_file"
        log_file "[INFO] 正在将 ipa 文件移动到目录：archive/ios/AppStore/"
        mv "$ipa_file" "${iOS_App_Store_File_Path}"
        
        if [ $? -eq 0 ]; then
            log_file "[INFO] 已成功将 ipa 文件移动到 ${iOS_App_Store_File_Path}"
            print "${BRIGHT_BLUE}iOS 平台 App Store 版 ${APP_NAME}.ipa 打包完成！${NC}"
            
            # 检查文件是否真实存在
            if [ ! -f "${iOS_App_Store_File_Path}" ]; then
                log_error "ipa 文件移动后未找到: ${iOS_App_Store_File_Path}"
                return 1
            fi
            
            # 记录文件大小
            local file_size=$(ls -lh "${iOS_App_Store_File_Path}" | awk '{print $5}')
            log_file "[INFO] ipa 文件大小: $file_size"
            print "IPA 文件大小: $file_size"
            
            open -R "${iOS_App_Store_File_Path}"
            upload_paths+=("${iOS_App_Store_File_Path}")
        else
            log_error "移动 ipa 文件失败"
            return 1
        fi
    else
        print "${RED}ipa 文件生成失败。${NC}\n"
        log_error "iOS App Store 版本构建失败"
        return 1
    fi

    # 上传到 App Store Connect
    if [[ "$upload_to_app_store_connect" == "1" ]]; then
        print "[INFO] 开始上传到 App Store Connect..."
        # 保持原有的输出重定向，同时记录到日志文件
        (cd ios && fastlane upload path:"../${iOS_App_Store_File_Path}") > /dev/null 2>&1
        if [ $? -eq 0 ]; then
            log_file "[INFO] 成功上传到 App Store Connect"
        else
            log_error "上传到 App Store Connect 失败"
        fi
    fi
}



# ============================================================================================
#                               读取更新日志
# ============================================================================================
upload_info_log() {
  # 检查更新日志文件是否存在
  if [[ ! -f "$LOG_FILE" ]]; then
    log_info "未找到更新日志文件，正在创建新的更新日志..."
    
    # 获取当前日期
    current_date=$(date '+%Y-%m-%d')
    
    # 创建基本的更新日志内容
    cat > "$LOG_FILE" << EOL
# 更新日志

## ${base_version} (${current_date})

### 新功能
- 初始版本发布

### 修复
- 首次发布，暂无修复项

### 优化
- 首次发布，暂无优化项
EOL
    
    log_info "已创建新的更新日志文件：${LOG_FILE}"
  fi

  # 读取更新日志内容
  UPDATE_LOG=$(awk '
  BEGIN {
    RS=""; 
    FS="\n"; 
    count=0; 
    found_today=0;
    # 获取当前日期
    "date +%Y-%m-%d" | getline today;
    close("date +%Y-%m-%d");
  }
  {
    for (i=1; i<=NF; i++) {
      if ($i ~ /^## /) {
        # 提取日期，使用更简单的模式匹配
        if ($i ~ /\([0-9]{4}-[0-9]{2}-[0-9]{2}\)/) {
          split($i, date_parts, /[\(\)]/);
          if (date_parts[2] == today) {
            found_today = 1;
          }
        }
        count++;
        if (count == 2) {
          exit;
        }
      }
      if (count < 2 && found_today == 1) {
        # 过滤掉 # 号
        line = $i;
        gsub(/#/, "", line);
        if (line != "") {
          print line;
        }
      }
    }
  }
  ' "$LOG_FILE")

  # 如果内容为空，使用默认内容
  if [[ -z "$UPDATE_LOG" ]]; then
    UPDATE_LOG=""
    log_warn "未找到当天的更新日志，使用空更新说明"
  fi
}

# 添加进度条函数
show_progress() {
    local current=$1
    local total=$2
    local width=20
    local progress=$((current * width / total))
    local percentage=$((current * 100 / total))
    
    printf "\r["
    for ((i=0; i<width; i++)); do  
        if [ $i -lt $progress ]; then
            printf "▰"
        else
            printf "▱"
        fi
    done
    printf "] %3d%%" $percentage
}

# ============================================================================================
#                               上传到 Pgyer
# ============================================================================================

# grenerate_android_qrcode() {
#     local app_url="$1"
#     qrencode -v 1 -l h -m 2 -s 10 -o qr.png "$app_url" && \
#     magick qr.png \( -size 120x120 xc:none \
#         -fill white \
#         -draw 'rectangle 15,10 125,115' \
#         -fill '#A4C639' \
#         -draw 'path "M 51 22 L 57 25 L 63 35 L 57 32 L 51 22 M 89 22 L 83 25 L 77 35 L 83 32 L 89 22 M 44 48 L 96 48 A 26 26 0 0 0 44 48 M 44 55 C 44 53.3 45.3 52 47 52 L 93 52 C 94.7 52 96 53.3 96 55 L 96 90 C 96 91.7 94.7 93 93 93 L 47 93 C 45.3 93 44 91.7 44 90 L 44 55 M 58 93 L 54 93 L 54 105 C 54 108.4 56.6 111 60 111 L 60 111 C 63.4 111 66 108.4 66 105 L 66 93 M 78 93 L 74 93 L 74 105 C 74 108.4 76.6 111 80 111 L 80 111 C 83.4 111 86 108.4 86 105 L 86 93 M 26 55 C 26 53.3 27.3 52 29 52 L 32 52 C 35.4 52 38 54.6 38 58 L 38 77 C 38 80.4 35.4 83 32 83 L 32 83 C 28.6 83 26 80.4 26 77 L 26 55 M 102 55 C 102 53.3 103.3 52 105 52 L 108 52 C 111.4 52 114 54.6 114 58 L 114 77 C 114 80.4 111.4 83 108 83 L 108 83 C 104.6 83 102 80.4 102 77 L 102 55 Z"' \
#         -fill black \
#         -draw 'circle 60 35 62 37' \
#         -draw 'circle 80 35 82 37' \) \
#         -gravity center \
#         -compose over \
#         -define compose:args=50,50 \
#         -composite final_qr.png && \
#     open final_qr.png
# }

upload_complete() {
    local response="$1"
    local platform="$2"
    upload_status=$(echo "$response" | grep -o '"code":[0-9]*')
    if [[ $upload_status == *"0"* ]]; then
        print "${GREEN}${platform} 版本上传成功！${NC}"
        # 提取 buildShortcutUrl 并生成网页地址
        shortcut=$(echo "$response" | grep -o '"buildShortcutUrl":"[^"]*' | sed 's/"buildShortcutUrl":"//')
        app_url="https://www.pgyer.com/$shortcut"
        print "${GREEN}访问链接: ${BRIGHT_BLUE}$app_url ${NC}"
        print "${GOLD}正在生成下载二维码...${NC}"
        qrencode -v 1 -m 2 -s 2 -t UTF8 "$app_url"
        #grenerate_android_qrcode "$app_url"
        print "${GOLD}二维码已生成，请扫描下载！${NC}"
    else
        print "${RED}${platform} 版本上传失败！${NC}"
        print "${RED}响应信息：$response${NC}"
    fi
}

upload_to_pgyer() {
  # Android 版本上传到 Pgyer
  if [[ "$choices" == *"1"* ]] && [[ "$upload_android_to_pgyer" == "1" ]]; then
      print "${GREEN}正在将 ${GOLD} Android ${GREEN}上传到 Pgyer...${NC}"
      response=$(curl -F "file=@${Android_File_Path}" \
                      -F "_api_key=${API_KEY}" \
                      -F "buildUpdateDescription=${UPDATE_LOG}" \
                      https://www.pgyer.com/apiv2/app/upload)
      # 提取并显示上传结果
      upload_complete "$response" "Android"
  fi

  # Ad Hoc 版本上传到 Pgyer
  if [[ "$choices" == *"3"* ]] && [[ "$upload_to_pgyer" == "1" ]]; then
      print "${GREEN}正在将 ${GOLD}iOS Ad Hoc ${GREEN}上传到 Pgyer...${NC}"
      response=$(curl -F "file=@${iOS_Ad_Hoc_File_Path}" \
                      -F "_api_key=${API_KEY}" \
                      -F "buildUpdateDescription=${UPDATE_LOG}" \
                      https://www.pgyer.com/apiv2/app/upload)
      # 提取并显示上传结果
      upload_complete "$response" "iOS Ad Hoc"
  fi
}



# ============================== 主程序==================================================
main() {
  
  # 初始化日志
  init_log
  # 检查环境配置
  show_welcome
  check_environment
  
  # 解析命令行参数
  while [[ $# -gt 0 ]]; do
      case $1 in
          -h|--help) show_help ;;
          -v|--version) echo "版本 ${SCRIPT_VERSION}" && exit 0 ;;
          -q|--quiet) QUIET=true ;;
          -d|--debug) DEBUG=true ;;
          *) log_error "未知参数: $1" && show_help ;;
      esac
      shift
  done

  # 获取项目信息
  APP_NAME=$(grep '^app_name: ' pubspec.yaml | sed 's/app_name: //')
  PROJECT_NAME=$(grep '^name: ' pubspec.yaml | sed 's/name: //')
  PGYER_API_KEY=$(grep '^api_key: ' pubspec.yaml | sed 's/api_key: //')
    
  # 检查是否成功获取项目信息
  if [[ -z "${APP_NAME}" || -z "${PROJECT_NAME}" ]]; then
    log_error "无法从 pubspec.yaml 获取项目信息"
  fi

  # 检查是否成功获取 PGYer 信息 
  if [[ -z "${PGYER_API_KEY}" ]]; then
      log_error "无法从 pubspec.yaml 获取 pgyer_api_key 信息"
  fi

  # 初始化上传路径数组
  declare -a upload_paths=()
  
  select_platform
  handle_version

  # 设置文件名
  VERSION="${base_version}+${new_version}"
  File_Name="${APP_NAME}_${VERSION}"
  Ad_Hoc_File_Name="${APP_NAME}_Ad_v${VERSION}"
  App_Store_File_Name="${APP_NAME}_St_v${VERSION}"

  Android_File_Path="archive/android/${File_Name}.apk"
  iOS_Ad_Hoc_File_Path="archive/ios/AdHoc/${Ad_Hoc_File_Name}.ipa"
  iOS_App_Store_File_Path="archive/ios/AppStore/${App_Store_File_Name}.ipa"

  # 读取更新日志
  upload_info_log

  # 记录构建配置信息
  log_info "构建配置信息:"
  print "${BRIGHT_BLUE}APP名称: ${GREEN}$APP_NAME ${BRIGHT_BLUE}项目名称: ${GREEN}$PROJECT_NAME ${BRIGHT_BLUE}版本号: ${GREEN}$VERSION${NC}"
  log_file "[INFO] APP名称: $APP_NAME 项目名称: $PROJECT_NAME 版本号: $VERSION"

  # 执行构建
  # Android 平台
  if [[ "$choices" == *"1"* ]] || [[ "$choices" == *"5"* ]]; then
      build_android
  fi

  # HarmonyOS 平台
  if [[ "$choices" == *"2"* ]] || [[ "$choices" == *"5"* ]]; then
      log_file "[INFO] 开始构建 HarmonyOS 版本..."
      # build_harmonyos
  fi
  
  # iOS Ad Hoc 平台
  if [[ "$choices" == *"3"* ]] || [[ "$choices" == *"5"* ]]; then
      log_file "[INFO] 开始构建 iOS Ad Hoc 版本..."
      build_ios_adhoc
  fi
  
  # iOS App Store 平台
  if [[ "$choices" == *"4"* ]] || [[ "$choices" == *"5"* ]]; then
      log_file "[INFO] 开始构建 iOS App Store 版本..."
      build_ios_appstore
  fi

  # 上传到 Pgyer
  upload_to_pgyer

  # 记录构建完成信息
  log_file "[INFO] 构建过程完成"
  log_file "[INFO] 生成的文件:"
  for path in "${upload_paths[@]}"; do
    log_file "- $path"
  done
  
  # 程序执行完成的提示
  read -p "Press [Enter] key to close this window..."
  read -r
}


# 调用主函数
main "$@"

 