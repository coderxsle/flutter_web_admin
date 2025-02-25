import time
import random
from rich.progress import (
    Progress as RichProgress,
    TextColumn,
    BarColumn,
    TaskProgressColumn,
    TimeRemainingColumn,
    SpinnerColumn,
    DownloadColumn,
    TransferSpeedColumn,
    FileSizeColumn,
)
from rich.console import Console
from rich.panel import Panel

class Progress:
    """进度条类"""
    
    def __init__(self):
        self.console = Console()

    def status(self, message: str):
        """显示状态消息"""
        return self.console.status(message)

    def show(self, description: str = "Processing..."):
        """显示进度"""
        progress = RichProgress(
            SpinnerColumn(),
            TextColumn("[progress.description]{task.description}"),
            BarColumn(),
            TaskProgressColumn(),
            TimeRemainingColumn(),
        )
        
        # 添加任务
        task = progress.add_task(description, total=None)
        return task

    def show_multiple(self, files: list):
        """显示多个文件的进度"""
        with RichProgress(
            TextColumn("[bold blue]{task.description}"),
            BarColumn(complete_style="green"),
            TaskProgressColumn(),
            TimeRemainingColumn(),
        ) as progress:
            tasks = {
                name: progress.add_task(f"[cyan]Processing {name}...", total=size)
                for name, size in files
            }
            
            return tasks

    def show_single(total_size: float = None, description: str = "Processing..."):
        """显示单个文件的进度"""
        with RichProgress(
            SpinnerColumn(),
            TextColumn(f"[bold blue]{description}"),
            BarColumn(complete_style="green"),
            TaskProgressColumn(),
            TimeRemainingColumn(),
        ) as progress:
            if total_size is None:
                # 对于未知大小的任务，只显示spinner和描述
                task = progress.add_task(description, total=None)
                time.sleep(2)  # 显示2秒的加载动画
                return
                
            task = progress.add_task(
                description,
                total=total_size,
                start=True
            )
            
            processed = 0
            chunk_size = 1024 * 8  # 8KB chunks
            
            while processed < total_size:
                chunk = min(chunk_size * (1 + processed // (total_size // 10)), 
                           total_size - processed)
                
                progress.update(task, advance=chunk)
                processed += chunk
                time.sleep(0.01)