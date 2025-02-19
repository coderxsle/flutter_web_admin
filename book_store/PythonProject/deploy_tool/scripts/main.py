#!/usr/bin/env python3
# -*- coding: utf-8 -*-

"""
部署工具主程序
提供交互式命令行界面，用于执行构建、打包和部署操作。
"""

import typer
from rich.prompt import Prompt
from rich.panel import Panel
from rich import print as rprint

from . import (
    BuildService,
    PackageService,
    DeployService,
    ValidateService,
)
from ..utils import log_info, log_error

app = typer.Typer()

class DeploymentManager:
    def __init__(self):
        self.build_service = BuildService()
        self.package_service = PackageService()
        self.deploy_service = DeployService()
        self.validate_service = ValidateService()

    def show_menu(self) -> int:
        menu_items = [
            "1. 构建镜像",
            "2. 打包镜像",
            "3. 部署镜像",
            "4. 执行所有步骤",
            "5. 退出"
        ]
        
        rprint(Panel.fit(
            "\n".join(menu_items),
            title="部署工具",
            border_style="blue"
        ))
        
        choice = Prompt.ask("请输入选项", choices=["1", "2", "3", "4", "5"])
        return int(choice)

    async def execute_step(self, step: int):
        try:
            if not await self.validate_service.validate_environment():
                return False

            if step in [1, 4]:
                await self.build_service.build_image()
            
            if step in [2, 4]:
                await self.package_service.package_image()
            
            if step in [3, 4]:
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
        else:
            log_error("操作失败！")

if __name__ == "__main__":
    app() 