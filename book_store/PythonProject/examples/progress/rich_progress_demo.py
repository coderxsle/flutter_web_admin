"""
Rich 进度条演示模块
"""
import time
import random
from rich.progress import (
    Progress,
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
    def __init__(self):
        self.console = Console()

    def show_progress(self, total_size: float, description: str = "Processing..."):
        """显示单个文件的进度"""
        with Progress(
            SpinnerColumn(),
            TextColumn(f"[bold blue]{description}"),
            BarColumn(complete_style="green"),
            FileSizeColumn(),
            TransferSpeedColumn(),
            TaskProgressColumn(),
            TimeRemainingColumn(),
        ) as progress:
            task = progress.add_task(
                "[cyan]Processing...", 
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

    def show_multiple_progress(self, files: list):
        """显示多个文件的进度"""
        with Progress(
            TextColumn("[bold blue]{task.description}"),
            BarColumn(complete_style="green"),
            FileSizeColumn(),
            TransferSpeedColumn(),
            TaskProgressColumn(),
            TimeRemainingColumn(),
        ) as progress:
            tasks = {
                name: progress.add_task(f"[cyan]Processing {name}...", total=size)
                for name, size in files
            }
            
            processed = {name: 0 for name in tasks}
            
            while not progress.finished:
                for name, task_id in tasks.items():
                    total_size = next(size for n, size in files if n == name)
                    
                    if processed[name] < total_size:
                        speed = random.uniform(0.2, 1.0)  # 0.2-1.0 MB 的随机速度
                        chunk = min(1024 * 1024 * speed, total_size - processed[name])
                        
                        progress.update(task_id, advance=chunk)
                        processed[name] += chunk
                        
                    time.sleep(0.02 * random.uniform(0.5, 1.5))  # 随机延迟

def main():
    """主函数"""
    console = Console()
    progress_bar = Progress()
    
    console.print(Panel.fit("Rich Progress Bar Demo", style="bold magenta"))
    
    console.print("\n1. 单文件进度:")
    total_size = 1024 * 1024 * 22.4  # 22.4 MB
    progress_bar.show_progress(total_size, "Processing single file")
    
    console.print("\n2. 多文件进度:")
    files = [
        ("package-1.zip", 1024 * 1024 * 50),     # 50 MB
        ("package-2.tar.gz", 1024 * 1024 * 85),  # 85 MB
        ("package-3.whl", 1024 * 1024 * 32),     # 32 MB
    ]
    progress_bar.show_multiple_progress(files)
    
    console.print("\n[green]演示完成![/green]")

if __name__ == "__main__":
    main() 