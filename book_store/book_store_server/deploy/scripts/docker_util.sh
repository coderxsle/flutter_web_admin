wait_for_containers_to_stop() {
    local timeout=60  # 最多等待 60 秒
    local interval=5  # 每 5 秒检查一次
    local elapsed=0

    log_info "等待所有容器完全停止..."

    while [ $elapsed -lt $timeout ]; do
        if ssh_execute "docker ps --format '{{.Names}}'" | grep -q .; then
            log_info "容器仍在运行，等待 ${interval} 秒..."
            sleep $interval
            elapsed=$((elapsed + interval))
        else
            log_info "所有容器已停止"
            return 0
        fi
    done

    log_warn "等待超时，但仍有容器可能未完全停止"
    return 1
}

# **执行流程**
log_info "停止并删除旧容器..."
ssh_execute "cd ${DEPLOY_PATH} && docker compose down"

# **等待所有容器停止**
wait_for_containers_to_stop

# **启动新容器**
log_info "启动新容器........."
ssh_execute "cd ${DEPLOY_PATH} && docker compose up -d"