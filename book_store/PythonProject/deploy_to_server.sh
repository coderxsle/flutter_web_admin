#!/bin/bash

# 进入项目根目录
cd /Users/coderxslee/workspace/book_store/book_store/book_store_server

# 给所有脚本添加执行权限
chmod +x deploy_to_server.sh
chmod +x deploy/scripts/*.sh


# 设置脚本所在目录
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
# 导入必要的工具脚本
source "${SCRIPT_DIR}/deploy/scripts/log_utils.sh"


# 检查参数
if [ "$#" -lt 2 ]; then
    log_error "使用方法: $0 <环境> <版本>"
    log_info "示例: $0 prod 1.0.0"
    exit 1
fi

ENV=$1
VERSION=$2

# 显示菜单
show_menu() {
    log_info "请选择要执行的步骤:"
    echo "1) 构建镜像"
    echo "2) 打包镜像"
    echo "3) 部署镜像"
    echo "4) 执行所有步骤"
    echo "q) 退出"
    
    read -p "请输入选项 [1-4/q]: " choice
    echo
    
    case "$choice" in
        1)
            log_info "开始构建..."
            if ! bash "${SCRIPT_DIR}/deploy/scripts/build.sh" "$ENV" "$VERSION"; then
                log_error "构建失败"
                exit 1
            fi
            ;;
        2)
            log_info "开始打包..."
            if ! bash "${SCRIPT_DIR}/deploy/scripts/package.sh" "$ENV" "$VERSION"; then
                log_error "打包失败"
                exit 1
            fi
            ;;
        3)
            log_info "开始部署..."
            if ! bash "${SCRIPT_DIR}/deploy/scripts/deploy.sh" "$ENV" "$VERSION"; then
                log_error "部署失败"
                exit 1
            fi
            ;;
        4)
            log_info "执行所有步骤..."
            
            log_info "1. 开始构建..."
            if ! bash "${SCRIPT_DIR}/deploy/scripts/build.sh" "$ENV" "$VERSION"; then
                log_error "构建失败"
                exit 1
            fi
            
            log_info "2. 开始打包..."
            if ! bash "${SCRIPT_DIR}/deploy/scripts/package.sh" "$ENV" "$VERSION"; then
                log_error "打包失败"
                exit 1
            fi
            
            log_info "3. 开始部署..."
            if ! bash "${SCRIPT_DIR}/deploy/scripts/deploy.sh" "$ENV" "$VERSION"; then
                log_error "部署失败"
                exit 1
            fi
            ;;
        q|Q)
            log_info "退出脚本"
            exit 0
            ;;
        *)
            log_error "无效的选项: $choice"
            exit 1
            ;;
    esac
}

# 显示菜单并等待用户选择
while true; do
    show_menu
    
    # 询问是否继续
    read -p "是否继续? [y/N]: " continue_choice
    [[ "$continue_choice" != "y" && "$continue_choice" != "Y" ]] && break
done

log_info "部署完成!" 