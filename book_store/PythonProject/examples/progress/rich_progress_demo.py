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

console = Console()

def show_download_progress():
    """模拟下载进度"""
    with Progress(
        SpinnerColumn(),
        TextColumn("[bold blue]{task.description}"),
        BarColumn(complete_style="green"),
        FileSizeColumn(),
        TransferSpeedColumn(),
        TaskProgressColumn(),
        TimeRemainingColumn(),
    ) as progress:
        total_size = 1024 * 1024 * 22.4  # 22.4 MB
        download_task = progress.add_task(
            "[cyan]Downloading...", 
            total=total_size,
            start=True
        )
        install_task = progress.add_task("[magenta]Installing...", total=100)
        
        chunk_size = 1024 * 8  # 8KB chunks
        downloaded = 0
        while downloaded < total_size:
            chunk = min(chunk_size * (1 + downloaded // (total_size // 10)), 
                       total_size - downloaded)
            
            progress.update(download_task, advance=chunk)
            progress.update(install_task, advance=0.3)
            downloaded += chunk
            time.sleep(0.01)


def show_multiple_downloads():
    """显示多个文件下载进度"""
    with Progress(
        TextColumn("[bold blue]{task.description}"),
        BarColumn(complete_style="green"),
        FileSizeColumn(),
        TransferSpeedColumn(),
        TaskProgressColumn(),
        TimeRemainingColumn(),
    ) as progress:
        # 模拟多个文件下载
        files = [
            ("package-1.zip", 1024 * 1024 * 50),     # 50 MB
            ("package-2.tar.gz", 1024 * 1024 * 85),  # 85 MB
            ("package-3.whl", 1024 * 1024 * 32),     # 32 MB
        ]
        
        tasks = {
            name: progress.add_task(f"[cyan]Downloading {name}...", total=size)
            for name, size in files
        }
        
        downloaded = {name: 0 for name in tasks}
        
        while not progress.finished:
            for name, task_id in tasks.items():
                # 获取文件的总大小
                total_size = next(size for n, size in files if n == name)
                
                # 确保不超过文件大小
                if downloaded[name] < total_size:
                    # 为每个文件模拟不同的下载速度
                    speed = random.uniform(0.2, 1.0)  # 0.2-1.0 MB 的随机速度
                    chunk = min(1024 * 1024 * speed, total_size - downloaded[name])
                    
                    progress.update(task_id, advance=chunk)
                    downloaded[name] += chunk
                    
                time.sleep(0.02 * random.uniform(0.5, 1.5))  # 随机延迟

def main():
    """主函数"""
    console.print(Panel.fit("Rich Progress Bar Demo", style="bold magenta"))
    
    console.print("\n1. 单文件下载进度:")
    show_download_progress()
    
    console.print("\n2. 多文件下载进度:")
    show_multiple_downloads()
    
    console.print("\n[green]演示完成![/green]")

if __name__ == "__main__":
    main() 