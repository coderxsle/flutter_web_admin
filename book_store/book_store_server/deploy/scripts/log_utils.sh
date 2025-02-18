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

# 日志函数
log_debug() {
    [ ${CURRENT_LOG_LEVEL} -le ${LOG_LEVEL_DEBUG} ] && echo -e "\033[36m[DEBUG] $1\033[0m"
}

log_info() {
    [ ${CURRENT_LOG_LEVEL} -le ${LOG_LEVEL_INFO} ] && echo -e "\033[32m[INFO] $1\033[0m"
}

log_warn() {
    [ ${CURRENT_LOG_LEVEL} -le ${LOG_LEVEL_WARN} ] && echo -e "\033[33m[WARN] $1\033[0m"
}

log_error() {
    [ ${CURRENT_LOG_LEVEL} -le ${LOG_LEVEL_ERROR} ] && echo -e "\033[31m[ERROR] $1\033[0m"
} 