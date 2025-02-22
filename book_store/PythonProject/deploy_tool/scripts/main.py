#!/usr/bin/env python3
# -*- coding: utf-8 -*-

"""
部署工具主程序
提供交互式命令行界面，用于执行构建、打包和部署操作。
"""

import sys
import typer
from rich.prompt import Prompt
from rich.panel import Panel
from rich import print as rprint
from typing import Dict, Tuple

from . import (
    BuildService,
    LocalBuildService,
    PackageService,
    DeployService,
)
from ..utils import log_info, log_error, env_utils

app = typer.Typer()

class DeploymentManager:
    def __init__(self):
        self.remote_build_service = BuildService()
        self.local_build_service = LocalBuildService()
        self.package_service = PackageService()
        self.deploy_service = DeployService()
        self.env_mapping: Dict[str, str] = {
            "1": "production",
            "2": "test",
            "3": "development"
        }

    def show_menu(self) -> int:
        menu_items = [
            "1. 构建镜像",
            "2. 打包镜像",
            "3. 部署镜像",
            "4. 全部执行",
            "5. 退出"
        ]
        
        rprint(Panel.fit("\n".join(menu_items), title="部署工具", width=100, border_style="blue")) 
        
        choice = Prompt.ask("请输入选项", choices=["1", "2", "3", "4", "5"])
        return int(choice)

    def select_environment(self) -> str:
        """选择构建环境"""
        menu_items = ["1. 生产环境", "2. 测试环境", "3. 开发环境"]
        rprint(Panel.fit("\n".join(menu_items), title="请选择构建环境", border_style="blue"))
        choice = Prompt.ask("请输入选项", choices=["1", "2", "3"])
        return self.env_mapping[choice]

    def select_build_type(self) -> str:
        """选择部署方式"""
        menu_items = ["1. 远程部署", "2. 本地部署"]
        rprint(Panel.fit("\n".join(menu_items), title="请选择部署方式", border_style="blue"))
        choice = Prompt.ask("请输入选项", choices=["1", "2"])
        return choice

    async def execute_step(self, step: int):
        try:
            if step in [1]:
                # 选择环境
                env = self.select_environment()
                # 加载环境变量
                if not env_utils.load_env(env):
                    return False
                await BuildService.build()  
            
            if step in [2]:
                # 选择环境
                env = self.select_environment()
                # 打包镜像
                await self.package_service.package_image()

            if step in [3]:
                # 选择环境
                env = self.select_environment()
                # 选择部署方式
                build_type = self.select_build_type()
                if build_type == "1":
                    build_service = self.remote_build_service
                else:
                    build_service = self.local_build_service
                # 加载环境变量
                if not env_utils.load_env(env):
                    return False
                # 部署镜像
                await self.deploy_service.deploy()

            if step in [4]:
                # 选择环境
                env = self.select_environment()
                # 选择部署方式
                build_type = self.select_build_type()
                if build_type == "1":
                    build_service = self.remote_build_service
                else:
                    build_service = self.local_build_service
                # 加载环境变量
                if not env_utils.load_env(env):
                    return False
                # 构建镜像
                await build_service.build()
                # 打包镜像
                await self.package_service.package_image()
                # 部署镜像
                await self.deploy_service.deploy()
            return True
        except Exception as e:
            log_error(f"执行过程中出现错误: {str(e)}")
            return False

@app.command()
def main():
    manager = DeploymentManager()
    
    while True:
        choice = manager.show_menu()
        
        if choice == 5:
            log_info("感谢使用，再见！")
            break
        
        import asyncio
        success = asyncio.run(manager.execute_step(choice))
        
        if success:
            log_info("操作完成！")
            break
        else:
            log_error("操作失败！")
            break

if __name__ == "__main__":
    app() 