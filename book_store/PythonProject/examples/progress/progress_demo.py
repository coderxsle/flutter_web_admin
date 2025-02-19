"""
进度条演示模块
"""
import time
from tqdm import tqdm

def basic_progress():
    """基础进度条"""
    print("\n1. 基础进度条:")
    for _ in tqdm(range(100)):
        time.sleep(0.02)

def progress_with_description():
    """带描述的进度条"""
    print("\n2. 带描述的进度条:")
    with tqdm(total=100, desc="Processing") as pbar:
        for i in range(10):
            time.sleep(0.2)
            pbar.update(10)

def progress_with_units():
    """带单位的进度条"""
    print("\n3. 带单位的进度条 (模拟文件传输):")
    total = 1024 * 1024  # 1MB
    with tqdm(total=total, unit='B', unit_scale=True, desc="Downloading") as pbar:
        chunk_size = 1024  # 1KB
        for _ in range(total // chunk_size):
            time.sleep(0.001)
            pbar.update(chunk_size)

def progress_with_custom_format():
    """自定义格式的进度条"""
    print("\n4. 自定义格式的进度条:")
    with tqdm(total=100, 
             desc="Loading", 
             bar_format="{desc}: {percentage:3.0f}%|{bar}| {n_fmt}/{total_fmt} [{elapsed}<{remaining}]") as pbar:
        for i in range(10):
            time.sleep(0.3)
            pbar.update(10)

def main():
    """主函数"""
    print("进度条演示开始...")
    
    basic_progress()
    progress_with_description()
    progress_with_units()
    progress_with_custom_format()
    
    print("\n演示完成!")

if __name__ == "__main__":
    main() 