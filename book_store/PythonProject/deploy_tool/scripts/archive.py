#!/usr/bin/env python3
# -*- coding: utf-8 -*-

import os
import sys
import time
import datetime
import subprocess
import re
import shutil
import platform
from pathlib import Path

# 脚本版本和名称
SCRIPT_VERSION = "1.0.0"
SCRIPT_NAME = os.path.basename(__file__)

# 获取目录路径
SCRIPT_DIR = os.path.dirname(os.path.abspath(__file__))
PROJECT_DIR = SCRIPT_DIR  # 脚本就在项目根目录

# 创建必要的目录
os.makedirs(f"{PROJECT_DIR}/archive/android", exist_ok=True)
os.makedirs(f"{PROJECT_DIR}/archive/ios/AdHoc", exist_ok=True)
os.makedirs(f"{PROJECT_DIR}/archive/ios/AppStore", exist_ok=True)
os.makedirs(f"{PROJECT_DIR}/build/build_log", exist_ok=True)

# 定义日志文件路径
BUILD_LOG_DIR = f"{PROJECT_DIR}/build/build_log"
BUILD_LOG_FILE = f"{BUILD_LOG_DIR}/build_{datetime.datetime.now().strftime('%Y%m%d_%H%M%S')}.log"

# 定义颜色变量
RED = '\033[0;31m'
GREEN = '\033[0;32m'
GOLD = '\033[38;5;220m'
BRIGHT_BLUE = '\033[38;5;39m'
NC = '\033[0m'

# API Key from Pgyer
API_KEY = "5bce8816cc52da76dc4e7ae5d7d30ff1"
# 更新日志文件的绝对路径
LOG_FILE = "archive_update_log.md"

# 初始化上传路径数组
upload_paths = []

# ==============================工具函数=====================================================

def ensure_directories():
    """检查并创建必要的目录"""
    directories = [
        "archive/android",
        "archive/ios/AdHoc",
        "archive/ios/AppStore",
        "build/build_log",
        "build/ios/ipa"
    ]

    for dir_path in directories:
        if not os.path.exists(dir_path):
            log_info(f"创建目录: {dir_path}")
            os.makedirs(dir_path, exist_ok=True)
            if not os.path.exists(dir_path):
                log_error(f"无法创建目录: {dir_path}")
                return False
    
    print(f"{GOLD}所有必要的目录已准备就绪{NC}")
    return True

def log_info(message):
    """日志信息函数"""
    print(f"{GREEN}[INFO]{NC} {message}")
    with open(BUILD_LOG_FILE, "a", encoding="utf-8") as f:
        f.write(f"[{datetime.datetime.now().strftime('%Y-%m-%d %H:%M:%S')}] [INFO] {message}\n")

def log_file(message):
    """只写入日志文件的日志函数"""
    with open(BUILD_LOG_FILE, "a", encoding="utf-8") as f:
        f.write(f"[{datetime.datetime.now().strftime('%Y-%m-%d %H:%M:%S')}] {message}\n")

def log_warn(message):
    """警告日志函数"""
    print(f"{GOLD}[WARN]{NC} {message}")
    with open(BUILD_LOG_FILE, "a", encoding="utf-8") as f:
        f.write(f"[{datetime.datetime.now().strftime('%Y-%m-%d %H:%M:%S')}] [WARN] {message}\n")

def log_error(message):
    """错误日志函数"""
    print(f"{RED}[ERROR]{NC} {message}")
    with open(BUILD_LOG_FILE, "a", encoding="utf-8") as f:
        f.write(f"[{datetime.datetime.now().strftime('%Y-%m-%d %H:%M:%S')}] [ERROR] {message}\n")

def log_debug(message):
    """调试日志函数"""
    debug = os.environ.get("DEBUG", "false").lower() == "true"
    if debug:
        print(f"{BRIGHT_BLUE}[DEBUG]{NC} {message}")
        with open(BUILD_LOG_FILE, "a", encoding="utf-8") as f:
            f.write(f"[{datetime.datetime.now().strftime('%Y-%m-%d %H:%M:%S')}] [DEBUG] {message}\n")

def print_message(message):
    """定义一个函数来替代 echo -e"""
    print(f"{message}")
    with open(BUILD_LOG_FILE, "a", encoding="utf-8") as f:
        f.write(f"[{datetime.datetime.now().strftime('%Y-%m-%d %H:%M:%S')}] {message}\n")

def cleanup():
    """清理函数"""
    log_debug("执行清理操作...")
    # 压缩当天的日志文件
    if os.path.exists(BUILD_LOG_FILE):
        try:
            subprocess.run(["gzip", "-9", BUILD_LOG_FILE], check=True)
            log_info(f"\n日志文件已压缩: {BUILD_LOG_FILE}.gz")
        except subprocess.CalledProcessError:
            log_error(f"压缩日志文件失败: {BUILD_LOG_FILE}")

def handle_error(line_number, error_code):
    """错误处理函数"""
    log_error(f"脚本在第 {line_number} 行发生错误，错误代码: {error_code}")
    cleanup()
    print_message(f"\n{RED}程序执行出现错误，请检查以上日志信息。{NC}")
    print_message(f"{GREEN}按回车键退出程序...{NC}")
    input()

# ==============================日志初始化函数=====================================================
def init_log():
    """初始化日志"""
    # 创建日志目录
    if not os.path.exists(BUILD_LOG_DIR):
        os.makedirs(BUILD_LOG_DIR, exist_ok=True)
        log_info(f"创建日志目录: {BUILD_LOG_DIR}")

    # 初始化日志文件
    with open(BUILD_LOG_FILE, "w", encoding="utf-8") as f:
        f.write("=== 构建日志开始 ===\n")
        f.write(f"时间: {datetime.datetime.now().strftime('%Y-%m-%d %H:%M:%S')}\n")
        f.write(f"脚本版本: {SCRIPT_VERSION}\n")
        f.write(f"工作目录: {PROJECT_DIR}\n")
        f.write("===========================\n")
    
    # 记录系统环境信息
    with open(BUILD_LOG_FILE, "a", encoding="utf-8") as f:
        f.write("系统信息:\n")
        f.write(f"OS: {platform.system()}\n")
        f.write(f"OS Version: {platform.version()}\n")
        
        # 获取Flutter版本
        try:
            flutter_version = subprocess.check_output(["flutter", "--version"], text=True)
            f.write(f"Flutter Version: {flutter_version.split('\n')[0]}\n")
        except:
            f.write("Flutter Version: 未检测到\n")
        
        # 获取Xcode版本（仅在macOS上）
        if platform.system() == "Darwin":
            try:
                xcode_version = subprocess.check_output(["xcodebuild", "-version"], text=True)
                f.write(f"Xcode Version: {xcode_version.split('\n')[0]}\n")
            except:
                f.write("Xcode Version: 未检测到\n")
        
        f.write("===========================\n")

    # 清屏
    os.system('cls' if platform.system() == 'Windows' else 'clear')

def check_environment():
    """检查必要的环境和工具"""
    log_info("检查环境配置...")
    
    log_info("日志文件初始化完成: /build/build_log")

    # 检查 Flutter
    if not shutil.which("flutter"):
        log_error("Flutter 未安装，请先安装 Flutter")
    
    # 检查 Xcode（仅在 macOS 上）
    if platform.system() == "Darwin":
        if not shutil.which("xcodebuild"):
            log_error("Xcode 未安装，请先安装 Xcode")
    
    # 检查 Java（用于 Android 构建）
    if not shutil.which("java"):
        log_warn("Java 未安装，Android 构建可能会失败")

def show_help():
    """显示帮助信息"""
    help_text = f"""
使用方法: {SCRIPT_NAME} [选项]

选项:
    -h, --help      显示此帮助信息
    -v, --version   显示版本信息
    -q, --quiet     静默模式
    -d, --debug     调试模式
    
示例:
    {SCRIPT_NAME} --help
    {SCRIPT_NAME} --debug
"""
    print(help_text)
    sys.exit(0)

# ==============================用户交互函数==================================================
def show_welcome():
    """用户选择打包选项"""
    print_message(f"{BRIGHT_BLUE}欢迎使用 App 打包脚本{NC}")
    print_message(f"{BRIGHT_BLUE}作者：{GOLD}李雪松{NC} {BRIGHT_BLUE}微信：{GREEN}CoderXSLee{NC}")

def select_platform():
    """选择要打包的平台"""
    global upload_android_to_pgyer, upload_to_pgyer, upload_to_app_store_connect
    
    print_message(f"{GREEN}请选择要打包的平台:{NC}")
    print_message("     1. Android")
    print_message("     2. HarmonyOS")
    print_message("     3. iOS Ad Hoc")
    print_message("     4. iOS App Store")
    print_message("     5. 全部")
    print_message(f"{GREEN}支持多选，请用空格分开。{GREEN}例如：{NC}1 3")
    
    while True:
        choices = input(f"{GREEN}请输入你的选择: {NC}")
        if re.match(r'^[1-5]([ ][1-5])*$', choices):
            break
        else:
            log_error("输入格式不正确，请重新输入")
    
    # 如果选择了选项1（Android），询问是否上传到 Pgyer
    if "1" in choices.split():
        print_message(f"{GREEN}是否将 Android 版本上传到 Pgyer？{NC}")
        print_message("     1. 上传")
        print_message("     2. 不上传")
        
        while True:
            upload_android_to_pgyer = input(f"{GREEN}请输入你的选择: {NC}")
            if re.match(r'^[12]$', upload_android_to_pgyer):
                break
            else:
                log_error("请输入有效的选项（1 或 2）")
    
    # 检查用户是否选择了 Ad Hoc (选项3)，询问是否上传到 Pgyer
    if "3" in choices.split():
        print_message(f"{GREEN}是否将 iOS Ad Hoc 版本上传到 Pgyer ？{NC}")
        print_message("     1. 上传")
        print_message("     2. 不上传")
        
        while True:
            upload_to_pgyer = input(f"{GREEN}请输入你的选择: {NC}")
            if re.match(r'^[12]$', upload_to_pgyer):
                break
            else:
                log_error("请输入有效的选项（1 或 2）")
    
    # 检查用户是否选择了 App Store (选项4)，询问是否上传到 App Store Connect
    if "4" in choices.split():
        print_message(f"{GREEN}是否将 iOS App Store 版本上传到 App Store Connect ？{NC}")
        print_message("     1. 上传")
        print_message("     2. 不上传")
        
        while True:
            upload_to_app_store_connect = input(f"{GREEN}请输入你的选择: {NC}")
            if re.match(r'^[12]$', upload_to_app_store_connect):
                break
            else:
                log_error("请输入有效的选项（1 或 2）")
    
    return choices

def handle_version():
    """处理版本号"""
    global base_version, new_version
    
    # 读取当前版本号
    with open("pubspec.yaml", "r") as f:
        pubspec_content = f.read()
    
    version_match = re.search(r'^version:\s*(.*)', pubspec_content, re.MULTILINE)
    current_version = version_match.group(1).strip() if version_match else "1.0.0+1"
    
    # 检查版本号格式
    if not re.match(r'^[0-9]+\.[0-9]+\.[0-9]+\+[0-9]+$', current_version):
        print_message(f"{RED}警告: 当前版本号格式不标准，正在自动修正...{NC}")
        
        # 提取版本号部分（处理可能的异常格式）
        if "+" in current_version:
            base_version, build_number = current_version.split("+", 1)
        else:
            base_version = current_version
            build_number = datetime.datetime.now().strftime('%m%d%H%M') + "01"
        
        # 确保版本号格式为 x.x.x
        if not re.match(r'^[0-9]+\.[0-9]+\.[0-9]+$', base_version):
            # 拆分现有版本号
            version_parts = base_version.split(".")
            
            # 补全缺失的版本号部分
            major = version_parts[0] if len(version_parts) > 0 else "1"
            minor = version_parts[1] if len(version_parts) > 1 else "0"
            patch = version_parts[2] if len(version_parts) > 2 else "0"
            
            # 重新组装标准格式的版本号
            base_version = f"{major}.{minor}.{patch}"
        
        # 确保构建号为12位数字
        if len(build_number) < 12:
            # 补零直到12位
            build_number = build_number.ljust(12, "0")
        elif len(build_number) > 12:
            # 如果超过12位，截取前12位
            build_number = build_number[:12]
        
        # 更新版本号
        current_version = f"{base_version}+{build_number}"
        pubspec_content = re.sub(r'^version:.*', f'version: {current_version}', pubspec_content, flags=re.MULTILINE)
        
        with open("pubspec.yaml", "w") as f:
            f.write(pubspec_content)
            
        print_message(f"{GREEN}版本号已自动修正为: {current_version}{NC}")
    
    # 提取版本号部分和构建号部分
    base_version, build_number = current_version.split("+", 1)
    
    # 拆解版本号（主版本号、次版本号、补丁版本号）
    version_parts = base_version.split(".")
    major = version_parts[0]  # 取 1.5.x 中的 1
    minor = version_parts[1]  # 取 1.5.x 中的 5
    patch = version_parts[2]  # 取 1.5.x 中的 x
    
    # 提示当前软件版本号和选择版本号的递增方式
    print_message(f"当前的软件版本为：{GREEN}{base_version}{NC} 请选择版本号的递增方式：")
    print_message(f"     {BRIGHT_BLUE}1. 递增补丁版本 {BRIGHT_BLUE}(从当前 {base_version} -> 修改为 {major}.{minor}.{int(patch) + 1}){NC}")
    print_message(f"     {BRIGHT_BLUE}2. 递增次版本 {BRIGHT_BLUE}(从当前 {base_version} -> 修改为 {major}.{int(minor) + 1}.0){NC}")
    print_message(f"     {BRIGHT_BLUE}3. 递增主版本 {BRIGHT_BLUE}(从当前 {base_version} -> 修改为 {int(major) + 1}.0.0){NC}")
    print_message(f"     {BRIGHT_BLUE}4. 不修改{NC}")
    print_message(f"     {BRIGHT_BLUE}5. 手动输入{NC}")
    
    # 获取用户输入选择
    while True:
        version_choice = input(f"{GREEN}请输入您的选择 (1~5): {NC}")
        if version_choice == "1":
            new_patch = int(patch) + 1
            base_version = f"{major}.{minor}.{new_patch}"
            break
        elif version_choice == "2":
            new_minor = int(minor) + 1
            base_version = f"{major}.{new_minor}.0"
            break
        elif version_choice == "3":
            new_major = int(major) + 1
            base_version = f"{new_major}.0.0"
            break
        elif version_choice == "4":
            break
        elif version_choice == "5":
            while True:
                custom_version = input(f"{GREEN}请输入自定义的软件版本号 (格式: 1.x.x): {NC}")
                if re.match(r'^[0-9]+\.[0-9]+\.[0-9]+$', custom_version):
                    base_version = custom_version
                    version_parts = base_version.split(".")
                    major = version_parts[0]
                    minor = version_parts[1]
                    patch = version_parts[2]
                    break
                else:
                    log_error("版本号格式不正确，请重新输入")
            break
        else:
            log_error("无效的选择，请输入 1-5 之间的数字")
            continue
    
    print_message(f"软件版本号已修改为：{GREEN}{base_version}{NC}")
    
    # 生成新的构建号
    # 计算当前时间作为构建版本号的前10位（格式：YYMMDDHHMM）
    timestamp = datetime.datetime.now().strftime('%m%d%H%M')
    
    # 提取构建版本号的最后两位
    last_two_digits = build_number[-2:]  # 提取最后两位
    
    # 递增最后两位数字并确保格式为两位数
    incremented_digits = int(last_two_digits) + 1
    incremented_digits = f"{incremented_digits:02d}"  # 确保补足两位数
    
    # 构建新的构建版本号：当前时间 + 递增后的最后两位
    new_build_number = f"{timestamp}{incremented_digits}"
    
    # 分析和比较当前与递增后的构建版本号，区分变化的部分
    diff_build_number = ""
    for i in range(len(build_number)):
        old_char = build_number[i] if i < len(build_number) else ""
        new_char = new_build_number[i] if i < len(new_build_number) else ""
        if old_char != new_char:
            diff_build_number += f"{GREEN}{new_char}{NC}"
        else:
            diff_build_number += old_char
    
    # 显示提示信息，差异化显示
    print_message(f"当前的构建版本号：{build_number}")
    print_message(f"递增后构建版本号：{diff_build_number}")
    increment_build = input(f"{GREEN}是否需要递增构建版本号？(1=yes/*=n): {NC}")
    
    # 判断用户输入
    if increment_build == "1":
        new_version = new_build_number  # 使用递增后的版本号
    else:
        new_version = f"{timestamp}{last_two_digits}"  # 如果用户不递增，则只保留最后两位不变，前面的时间使用当前时间
    
    # 使用正则表达式替换 pubspec.yaml 中的 version 字段
    with open("pubspec.yaml", "r") as f:
        pubspec_content = f.read()
    
    pubspec_content = re.sub(r'^version:.*', f'version: {base_version}+{new_version}', pubspec_content, flags=re.MULTILINE)
    
    with open("pubspec.yaml", "w") as f:
        f.write(pubspec_content)
    
    # 修改 Info.plist 中 CFBundleVersion 的值
    PLIST_PATH = "./ios/Runner/Info.plist"
    
    try:
        # 在Python中，我们使用subprocess调用PlistBuddy
        subprocess.run(["/usr/libexec/PlistBuddy", "-c", f"Set :CFBundleVersion {new_version}", PLIST_PATH], check=True)
        # 显示最终版本号
        print_message(f"本次打包的版本号为：{GREEN}{base_version}+{new_version}{NC}")
    except subprocess.CalledProcessError:
        print_message(f"{RED}CFBundleVersion 更新失败！{NC}")

# =========================================================================================
#                                 构建函数 
# =========================================================================================

def show_build_animation(process, message):
    """显示构建动画"""
    frames = [
        "▱▱▱▱▱▱▱▱▱▱",
        "▰▱▱▱▱▱▱▱▱▱",
        "▰▰▱▱▱▱▱▱▱▱",
        "▰▰▰▱▱▱▱▱▱▱",
        "▰▰▰▰▱▱▱▱▱▱",
        "▰▰▰▰▰▱▱▱▱▱",
        "▰▰▰▰▰▰▱▱▱▱",
        "▰▰▰▰▰▰▰▱▱▱",
        "▰▰▰▰▰▰▰▰▱▱",
        "▰▰▰▰▰▰▰▰▰▱",
        "▰▰▰▰▰▰▰▰▰▰"
    ]
    i = 0
    
    # 记录开始时间
    start_time = time.time()
    
    # 打印固定的消息
    print(f"{GREEN}{message} {frames[0]} ", end="", flush=True)
    
    while process.poll() is None:
        print(f"\r{GREEN}{message} {frames[i]} ", end="", flush=True)
        i = (i + 1) % len(frames)
        time.sleep(0.05)
    
    # 计算用时
    end_time = time.time()
    duration = int(end_time - start_time)
    
    # 最后显示完成状态并换行
    print(f"\r{GREEN}{message} {frames[-1]} {NC}")
    print(f"构建完成！{GREEN}用时 {duration} 秒{NC}")

def build_android():
    """Android平台构建"""
    # 确保目录存在
    if not ensure_directories():
        return False

    log_file("[INFO] 开始构建 Android 平台应用...")

    # 记录构建开始时间
    build_start_time = datetime.datetime.now().strftime('%Y-%m-%d %H:%M:%S')
    log_file(f"[INFO] Android 构建开始时间: {build_start_time}")

    # 执行构建命令
    process = subprocess.Popen(["flutter", "build", "apk", "--release"], 
                               stdout=subprocess.DEVNULL, 
                               stderr=subprocess.DEVNULL)
    
    # 显示构建动画
    show_build_animation(process, "正在构建 Android 应用")

    # 记录构建结束时间
    build_end_time = datetime.datetime.now().strftime('%Y-%m-%d %H:%M:%S')
    log_file(f"[INFO] Android 构建结束时间: {build_end_time}")

    # 检查构建结果
    if os.path.exists("build/app/outputs/flutter-apk/app-release.apk"):
        log_file(f"[INFO] 正在将 apk 文件移动到目录：archive/android/")
        shutil.move("build/app/outputs/flutter-apk/app-release.apk", Android_File_Path)
        log_file(f"[INFO] 已成功将 apk 文件移动到 {Android_File_Path}")
        
        # 记录文件大小
        file_size = os.path.getsize(Android_File_Path)
        human_size = convert_size(file_size)
        log_file(f"[INFO] apk 文件大小: {human_size}")
        print_message(f"{BRIGHT_BLUE}Android 平台 {APP_NAME}.apk 打包完成！文件大小: {human_size} {NC} ")

        # 在文件管理器中打开
        if platform.system() == "Darwin":  # macOS
            subprocess.run(["open", "-R", Android_File_Path])
        elif platform.system() == "Windows":  # Windows
            subprocess.run(["explorer", "/select,", Android_File_Path.replace("/", "\\")])
        
        upload_paths.append(Android_File_Path)
        return True
    else:
        print_message(f"{RED}apk 文件生成失败。{NC}\n")
        log_error("Android 平台构建失败")
        return False

def build_ios_adhoc():
    """iOS平台Ad Hoc测试分发版构建"""
    # 确保目录存在
    if not ensure_directories():
        return False

    # 记录构建开始时间
    build_start_time = datetime.datetime.now().strftime('%Y-%m-%d %H:%M:%S')
    log_file(f"[INFO] iOS Ad Hoc 构建开始时间: {build_start_time}")

    # 执行构建命令
    process = subprocess.Popen(["flutter", "build", "ipa", "--release", "--export-method", "ad-hoc"], 
                               stdout=subprocess.DEVNULL, 
                               stderr=subprocess.DEVNULL)
    
    # 显示构建动画
    show_build_animation(process, "正在构建 iOS Ad Hoc 版本")

    # 记录构建结束时间
    build_end_time = datetime.datetime.now().strftime('%Y-%m-%d %H:%M:%S')
    log_file(f"[INFO] iOS Ad Hoc 构建结束时间: {build_end_time}")

    # 查找 build/ios/ipa 目录下的 .ipa 文件
    ipa_files = list(Path("build/ios/ipa").glob("*.ipa"))
    
    # 检查是否找到 ipa 文件
    if ipa_files and os.path.exists(ipa_files[0]):
        ipa_file = str(ipa_files[0])
        log_file(f"[INFO] 找到 ipa 文件: {ipa_file}")
        log_file(f"[INFO] 正在将 ipa 文件移动到目录：archive/ios/AdHoc/")
        shutil.move(ipa_file, iOS_Ad_Hoc_File_Path)
        
        if os.path.exists(iOS_Ad_Hoc_File_Path):
            log_file(f"[INFO] 已成功将 ipa 文件移动到 {iOS_Ad_Hoc_File_Path}")
            
            # 检查文件是否真实存在
            if not os.path.exists(iOS_Ad_Hoc_File_Path):
                log_error(f"ipa 文件移动后未找到: {iOS_Ad_Hoc_File_Path}")
                return False
            
            # 记录文件大小
            file_size = os.path.getsize(iOS_Ad_Hoc_File_Path)
            human_size = convert_size(file_size)
            log_file(f"[INFO] ipa 文件大小: {human_size}")
            print_message(f"{BRIGHT_BLUE}iOS 平台 Ad Hoc 版 {APP_NAME}.ipa 文件大小: {human_size} {NC}")

            # 在文件管理器中打开
            if platform.system() == "Darwin":  # macOS
                subprocess.run(["open", "-R", iOS_Ad_Hoc_File_Path])
            
            upload_paths.append(iOS_Ad_Hoc_File_Path)
            return True
        else:
            log_error("移动 ipa 文件失败")
            return False
    else:
        print_message(f"{RED}ipa 文件生成失败。{NC}\n")
        log_error("iOS Ad Hoc 版本构建失败")
        return False

def build_ios_appstore():
    """iOS平台App Store版构建"""
    # 确保目录存在
    if not ensure_directories():
        return False
    
    # 记录构建开始时间
    build_start_time = datetime.datetime.now().strftime('%Y-%m-%d %H:%M:%S')
    log_file(f"[INFO] iOS App Store 构建开始时间: {build_start_time}")

    # 执行构建命令
    process = subprocess.Popen(["flutter", "build", "ipa", "--release", "--export-method", "app-store"], 
                               stdout=subprocess.DEVNULL, 
                               stderr=subprocess.DEVNULL)
    
    # 显示构建动画
    show_build_animation(process, "正在构建 iOS App Store 版本")

    # 记录构建结束时间
    build_end_time = datetime.datetime.now().strftime('%Y-%m-%d %H:%M:%S')
    log_file(f"[INFO] iOS App Store 构建结束时间: {build_end_time}")

    # 查找 build/ios/ipa 目录下的 .ipa 文件
    ipa_files = list(Path("build/ios/ipa").glob("*.ipa"))
    
    # 检查是否找到 ipa 文件
    if ipa_files and os.path.exists(ipa_files[0]):
        ipa_file = str(ipa_files[0])
        log_file(f"[INFO] 找到 ipa 文件: {ipa_file}")
        log_file(f"[INFO] 正在将 ipa 文件移动到目录：archive/ios/AppStore/")
        shutil.move(ipa_file, iOS_App_Store_File_Path)
        
        if os.path.exists(iOS_App_Store_File_Path):
            log_file(f"[INFO] 已成功将 ipa 文件移动到 {iOS_App_Store_File_Path}")
            print_message(f"{BRIGHT_BLUE}iOS 平台 App Store 版 {APP_NAME}.ipa 打包完成！{NC}")
            
            # 检查文件是否真实存在
            if not os.path.exists(iOS_App_Store_File_Path):
                log_error(f"ipa 文件移动后未找到: {iOS_App_Store_File_Path}")
                return False
            
            # 记录文件大小
            file_size = os.path.getsize(iOS_App_Store_File_Path)
            human_size = convert_size(file_size)
            log_file(f"[INFO] ipa 文件大小: {human_size}")
            print_message(f"IPA 文件大小: {human_size}")
            
            # 在文件管理器中打开
            if platform.system() == "Darwin":  # macOS
                subprocess.run(["open", "-R", iOS_App_Store_File_Path])
            
            upload_paths.append(iOS_App_Store_File_Path)
            
            # 上传到 App Store Connect
            if upload_to_app_store_connect == "1":
                print_message("[INFO] 开始上传到 App Store Connect...")
                # 执行上传命令
                try:
                    subprocess.run(["cd", "ios", "&&", "fastlane", "upload", f"path:../{iOS_App_Store_File_Path}"], 
                                  stdout=subprocess.DEVNULL, 
                                  stderr=subprocess.DEVNULL,
                                  check=True,
                                  shell=True)
                    log_file("[INFO] 成功上传到 App Store Connect")
                except subprocess.CalledProcessError:
                    log_error("上传到 App Store Connect 失败")
            
            return True
        else:
            log_error("移动 ipa 文件失败")
            return False
    else:
        print_message(f"{RED}ipa 文件生成失败。{NC}\n")
        log_error("iOS App Store 版本构建失败")
        return False

def convert_size(size_bytes):
    """转换文件大小为人类可读格式"""
    if size_bytes < 1024:
        return f"{size_bytes} B"
    elif size_bytes < 1024 * 1024:
        return f"{size_bytes / 1024:.2f} KB"
    elif size_bytes < 1024 * 1024 * 1024:
        return f"{size_bytes / (1024 * 1024):.2f} MB"
    else:
        return f"{size_bytes / (1024 * 1024 * 1024):.2f} GB"

# ============================================================================================
#                               读取更新日志
# ============================================================================================
def upload_info_log():
    """读取更新日志"""
    global UPDATE_LOG
    
    # 检查更新日志文件是否存在
    if not os.path.exists(LOG_FILE):
        log_info("未找到更新日志文件，正在创建新的更新日志...")
        
        # 获取当前日期
        current_date = datetime.datetime.now().strftime('%Y-%m-%d')
        
        # 创建基本的更新日志内容
        with open(LOG_FILE, "w", encoding="utf-8") as f:
            f.write(f"""# 更新日志

## {base_version} ({current_date})

### 新功能
- 初始版本发布

### 修复
- 首次发布，暂无修复项

### 优化
- 首次发布，暂无优化项
""")
        
        log_info(f"已创建新的更新日志文件：{LOG_FILE}")
    
    # 读取更新日志内容
    today = datetime.datetime.now().strftime('%Y-%m-%d')
    found_today = False
    update_log_content = []
    
    # 使用简单的文本处理来实现类似awk的功能
    with open(LOG_FILE, "r", encoding="utf-8") as f:
        lines = f.readlines()
        count = 0
        for i, line in enumerate(lines):
            if line.startswith("## "):
                # 提取日期，使用更简单的模式匹配
                date_match = re.search(r'\((\d{4}-\d{2}-\d{2})\)', line)
                if date_match and date_match.group(1) == today:
                    found_today = True
                    count += 1
                elif count > 0:
                    count += 1
                    if count >= 2:  # 找到第二个标题，结束
                        break
            elif found_today and count == 1:
                # 过滤掉 # 号
                clean_line = re.sub(r'#', '', line).strip()
                if clean_line:
                    update_log_content.append(clean_line)
    
    UPDATE_LOG = "\n".join(update_log_content)
    
    # 如果内容为空，使用默认内容
    if not UPDATE_LOG:
        UPDATE_LOG = ""
        log_warn("未找到当天的更新日志，使用空更新说明")

# 添加进度条函数
def show_progress(current, total):
    """显示进度条"""
    width = 20
    progress = int(current * width / total)
    percentage = int(current * 100 / total)
    
    sys.stdout.write("\r[")
    for i in range(width):  
        if i < progress:
            sys.stdout.write("▰")
        else:
            sys.stdout.write("▱")
    sys.stdout.write(f"] {percentage:3d}%")
    sys.stdout.flush()

# ============================================================================================
#                               上传到 Pgyer
# ============================================================================================

def upload_complete(response, platform):
    """处理上传完成后的响应"""
    try:
        # 解析JSON响应
        import json
        response_data = json.loads(response)
        
        if response_data.get("code") == 0:
            print_message(f"{GREEN}{platform} 版本上传成功！{NC}")
            # 提取 buildShortcutUrl 并生成网页地址
            shortcut = response_data.get("data", {}).get("buildShortcutUrl", "")
            app_url = f"https://www.pgyer.com/{shortcut}"
            print_message(f"{GREEN}访问链接: {BRIGHT_BLUE}{app_url} {NC}")
            print_message(f"{GOLD}正在生成下载二维码...{NC}")
            
            # 使用qrencode生成二维码（如果可用）
            try:
                subprocess.run(["qrencode", "-v", "1", "-m", "2", "-s", "2", "-t", "UTF8", app_url])
                print_message(f"{GOLD}二维码已生成，请扫描下载！{NC}")
            except FileNotFoundError:
                print_message(f"{GOLD}qrencode工具未安装，无法生成二维码。请手动访问链接: {app_url}{NC}")
        else:
            print_message(f"{RED}{platform} 版本上传失败！{NC}")
            print_message(f"{RED}响应信息：{response}{NC}")
    except Exception as e:
        log_error(f"解析上传响应时出错: {str(e)}")
        print_message(f"{RED}处理响应时出错: {str(e)}{NC}")

def upload_to_pgyer():
    """上传到Pgyer平台"""
    # Android 版本上传到 Pgyer
    if "1" in choices.split() and upload_android_to_pgyer == "1":
        print_message(f"{GREEN}正在将 {GOLD} Android {GREEN}上传到 Pgyer...{NC}")
        try:
            import requests
            
            # 准备上传文件和数据
            files = {'file': open(Android_File_Path, 'rb')}
            data = {
                '_api_key': API_KEY,
                'buildUpdateDescription': UPDATE_LOG
            }
            
            # 发送POST请求
            response = requests.post('https://www.pgyer.com/apiv2/app/upload', 
                                    files=files, 
                                    data=data)
            
            # 处理响应
            upload_complete(response.text, "Android")
        except Exception as e:
            log_error(f"上传Android版本到Pgyer时出错: {str(e)}")
            print_message(f"{RED}上传失败: {str(e)}{NC}")

    # Ad Hoc 版本上传到 Pgyer
    if "3" in choices.split() and upload_to_pgyer == "1":
        print_message(f"{GREEN}正在将 {GOLD}iOS Ad Hoc {GREEN}上传到 Pgyer...{NC}")
        try:
            import requests
            
            # 准备上传文件和数据
            files = {'file': open(iOS_Ad_Hoc_File_Path, 'rb')}
            data = {
                '_api_key': API_KEY,
                'buildUpdateDescription': UPDATE_LOG
            }
            
            # 发送POST请求
            response = requests.post('https://www.pgyer.com/apiv2/app/upload', 
                                    files=files, 
                                    data=data)
            
            # 处理响应
            upload_complete(response.text, "iOS Ad Hoc")
        except Exception as e:
            log_error(f"上传iOS Ad Hoc版本到Pgyer时出错: {str(e)}")
            print_message(f"{RED}上传失败: {str(e)}{NC}")

# ============================== 主程序==================================================
def main():
    """主函数"""
    global APP_NAME, PROJECT_NAME, PGYER_API_KEY, choices
    global Android_File_Path, iOS_Ad_Hoc_File_Path, iOS_App_Store_File_Path, VERSION
    
    # 初始化日志
    init_log()
    # 检查环境配置
    show_welcome()
    check_environment()
    
    # 解析命令行参数
    args = sys.argv[1:]
    i = 0
    while i < len(args):
        arg = args[i]
        if arg in ["-h", "--help"]:
            show_help()
        elif arg in ["-v", "--version"]:
            print(f"版本 {SCRIPT_VERSION}")
            sys.exit(0)
        elif arg in ["-q", "--quiet"]:
            os.environ["QUIET"] = "true"
        elif arg in ["-d", "--debug"]:
            os.environ["DEBUG"] = "true"
        else:
            log_error(f"未知参数: {arg}")
            show_help()
        i += 1

    # 获取项目信息
    try:
        with open("pubspec.yaml", "r") as f:
            pubspec_content = f.read()
            
        app_name_match = re.search(r'^app_name:\s*(.*)', pubspec_content, re.MULTILINE)
        project_name_match = re.search(r'^name:\s*(.*)', pubspec_content, re.MULTILINE)
        pgyer_api_key_match = re.search(r'^api_key:\s*(.*)', pubspec_content, re.MULTILINE)
        
        APP_NAME = app_name_match.group(1).strip() if app_name_match else "App"
        PROJECT_NAME = project_name_match.group(1).strip() if project_name_match else "Project"
        PGYER_API_KEY = pgyer_api_key_match.group(1).strip() if pgyer_api_key_match else API_KEY
    except Exception as e:
        log_error(f"读取项目信息时出错: {str(e)}")
        APP_NAME = "App"
        PROJECT_NAME = "Project"
        PGYER_API_KEY = API_KEY
    
    # 检查是否成功获取项目信息
    if not APP_NAME or not PROJECT_NAME:
        log_error("无法从 pubspec.yaml 获取项目信息")
    
    # 检查是否成功获取 PGYer 信息 
    if not PGYER_API_KEY:
        log_error("无法从 pubspec.yaml 获取 pgyer_api_key 信息")
    
    # 选择平台
    choices = select_platform()
    handle_version()

    # 设置文件名
    VERSION = f"{base_version}+{new_version}"
    File_Name = f"{APP_NAME}_{VERSION}"
    Ad_Hoc_File_Name = f"{APP_NAME}_Ad_v{VERSION}"
    App_Store_File_Name = f"{APP_NAME}_St_v{VERSION}"

    Android_File_Path = f"archive/android/{File_Name}.apk"
    iOS_Ad_Hoc_File_Path = f"archive/ios/AdHoc/{Ad_Hoc_File_Name}.ipa"
    iOS_App_Store_File_Path = f"archive/ios/AppStore/{App_Store_File_Name}.ipa"

    # 读取更新日志
    upload_info_log()

    # 记录构建配置信息
    log_info("构建配置信息:")
    print_message(f"{BRIGHT_BLUE}APP名称: {GREEN}{APP_NAME} {BRIGHT_BLUE}项目名称: {GREEN}{PROJECT_NAME} {BRIGHT_BLUE}版本号: {GREEN}{VERSION}{NC}")
    log_file(f"[INFO] APP名称: {APP_NAME} 项目名称: {PROJECT_NAME} 版本号: {VERSION}")

    # 执行构建
    # Android 平台
    if "1" in choices.split() or "5" in choices.split():
        build_android()

    # HarmonyOS 平台
    if "2" in choices.split() or "5" in choices.split():
        log_file("[INFO] 开始构建 HarmonyOS 版本...")
        # 这里可以实现HarmonyOS的构建功能
        # build_harmonyos() 
    
    # iOS Ad Hoc 平台
    if "3" in choices.split() or "5" in choices.split():
        log_file("[INFO] 开始构建 iOS Ad Hoc 版本...")
        build_ios_adhoc()
    
    # iOS App Store 平台
    if "4" in choices.split() or "5" in choices.split():
        log_file("[INFO] 开始构建 iOS App Store 版本...")
        build_ios_appstore()

    # 上传到 Pgyer
    upload_to_pgyer()

    # 记录构建完成信息
    log_file("[INFO] 构建过程完成")
    log_file("[INFO] 生成的文件:")
    for path in upload_paths:
        log_file(f"- {path}")
    
    # 程序执行完成的提示
    input("按[Enter]键关闭窗口...")

if __name__ == "__main__":
    try:
        main()
    except Exception as e:
        log_error(f"执行过程中出现异常: {str(e)}")
        import traceback
        traceback.print_exc()
        input("程序出错，按[Enter]键退出...")