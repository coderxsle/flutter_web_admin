#!/bin/bash

# 日志相关的工具函数

# 日志级别
LOG_LEVEL_DEBUG=0
LOG_LEVEL_INFO=1
LOG_LEVEL_WARN=2
LOG_LEVEL_ERROR=3

# 默认日志级别
CURRENT_LOG_LEVEL=${LOG_LEVEL_INFO}

# 设置日志级别
set_log_level() {
    case "$1" in
        "DEBUG") CURRENT_LOG_LEVEL=${LOG_LEVEL_DEBUG} ;;
        "INFO")  CURRENT_LOG_LEVEL=${LOG_LEVEL_INFO} ;;
        "WARN")  CURRENT_LOG_LEVEL=${LOG_LEVEL_WARN} ;;
        "ERROR") CURRENT_LOG_LEVEL=${LOG_LEVEL_ERROR} ;;
        *)       CURRENT_LOG_LEVEL=${LOG_LEVEL_INFO} ;;
    esac
}

# 日志函数（使用 printf 代替 echo，无依赖，保留颜色）
log_debug() {
    [ ${CURRENT_LOG_LEVEL} -le ${LOG_LEVEL_DEBUG} ] && printf "\033[36m[DEBUG] %s\033[0m\n" "$1"
}

log_info() {
    [ ${CURRENT_LOG_LEVEL} -le ${LOG_LEVEL_INFO} ] && printf "\033[32m[INFO] %s\033[0m\n" "$1"
}

log_warn() {
    [ ${CURRENT_LOG_LEVEL} -le ${LOG_LEVEL_WARN} ] && printf "\033[33m[WARN] %s\033[0m\n" "$1"
}

log_error() {
    [ ${CURRENT_LOG_LEVEL} -le ${LOG_LEVEL_ERROR} ] && printf "\033[31m[ERROR] %s\033[0m\n" "$1"
}