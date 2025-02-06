#!/bin/bash

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

if [[ "${BASH_SOURCE[0]}" == "${0}" ]]; then
    source "${SCRIPT_DIR}/log-utils.sh"
    source "${SCRIPT_DIR}/env-utils.sh"
    
    show_usage() {
        echo "使用方法: $0 <环境>"
        echo "示例: $0 prod"
        exit 1
    }
    
    [ "$#" -lt 1 ] && show_usage
    
    ENV=$1
    
    # 加载环境变量
    load_env "$ENV" || exit 1
    
    # 执行备份
    backup_database "$ENV"
fi

# 备份数据库
backup_database() {
    local env=$1
    local timestamp=$(date '+%Y%m%d_%H%M%S')
    local backup_file="${BACKUP_DIR}/${env}/db_${timestamp}.sql"
    
    log_info "备份数据库..."
    if docker exec ${env}-postgres-1 pg_dump -U ${POSTGRES_USER} ${POSTGRES_DB} > "${backup_file}"; then
        if [ "${DB_BACKUP_COMPRESS}" = true ]; then
            gzip "${backup_file}"
            log_info "数据库备份已压缩: ${backup_file}.gz"
        else
            log_info "数据库备份成功: ${backup_file}"
        fi
        return 0
    else
        log_error "数据库备份失败"
        return 1
    fi
}
