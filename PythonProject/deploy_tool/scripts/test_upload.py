#!/usr/bin/env python3
# -*- coding: utf-8 -*-

"""
测试同时上传多个文件并显示进度条
"""

import os
import sys
import tempfile
from pathlib import Path

from deploy_tool.utils.ssh_client import SSHClient
from deploy_tool.utils.env_utils import EnvUtils
from deploy_tool.utils import (
    log_info,
    log_error,
)

def create_test_file(name, size_mb):
    """创建测试文件"""
    path = os.path.join(tempfile.gettempdir(), name)
    with open(path, 'wb') as f:
        f.write(os.urandom(size_mb * 1024 * 1024))
    return path

def test_multiple_upload():
    """测试同时上传多个文件"""
    # 加载环境变量
    try:
        # 从环境变量获取项目根目录、部署路径和服务器信息
        project_root = EnvUtils.get('PROJECT_ROOT')
        deploy_path = EnvUtils.get('DEPLOY_PATH')
        project_root_path = Path(project_root)
        
        # 创建SSH客户端
        ssh_client = SSHClient()
        
        log_info("上传配置文件、环境变量、以及测试文件到云端服务器...")
        
        # 准备文件列表
        files_to_upload = []
        
        # 添加配置文件
        for config_file in ["docker-compose.yaml", "nginx.conf"]:
            local_path = f"{project_root_path.parent}/docker/{config_file}"
            remote_path = f"{deploy_path}/"
            if os.path.exists(local_path):
                files_to_upload.append((local_path, remote_path))
                log_info(f"添加文件: {local_path}")
        
        # 添加环境变量文件
        for env in ["production", "staging", "development"]:
            env_file_path = f"{project_root}/env/.env.{env}"
            if os.path.exists(env_file_path):
                files_to_upload.append((env_file_path, f"{deploy_path}/"))
                log_info(f"添加文件: {env_file_path}")
        
        # 创建并添加一些测试文件
        test_files = []
        test_files.append(create_test_file("test_file_10mb.bin", 10))
        test_files.append(create_test_file("test_file_20mb.bin", 20))
        test_files.append(create_test_file("test_file_5mb.bin", 5))
        test_files.append(create_test_file("test_file_15mb.bin", 15))
        
        for test_file in test_files:
            files_to_upload.append((test_file, f"{deploy_path}/"))
            log_info(f"添加测试文件: {test_file}")
        
        # 使用 put_multiple 同时上传所有文件
        if not files_to_upload:
            log_error("没有找到要上传的文件")
            return False
        
        log_info(f"开始上传 {len(files_to_upload)} 个文件...")
        
        # 使用 put_multiple 同时上传所有文件
        result = ssh_client.put_multiple(files_to_upload)
        
        # 删除测试文件
        for test_file in test_files:
            try:
                os.remove(test_file)
                log_info(f"删除测试文件: {test_file}")
            except Exception as e:
                log_error(f"删除测试文件失败: {e}")
        
        if result:
            log_info("所有文件上传成功")
        else:
            log_error("文件上传失败")
        
        return result
        
    except Exception as e:
        log_error(f"上传测试过程中出现错误: {e}")
        return False

if __name__ == "__main__":
    # 执行测试
    test_multiple_upload() 