"""
动画进度条演示
"""
from alive_progress import alive_bar, config_handler
import time

def show_progress_bars():
    """展示不同风格的进度条"""
    # 经典风格
    with alive_bar(100, title='Classic Style') as bar:
        for i in range(100):
            time.sleep(0.02)
            bar()
    
    # 音符风格
    config_handler.set_global(bar='notes', spinner='notes2')
    with alive_bar(100, title='Musical Style') as bar:
        for i in range(100):
            time.sleep(0.02)
            bar()
    
    # 气泡风格
    config_handler.set_global(bar='bubbles', spinner='dots')
    with alive_bar(100, title='Bubbles Style') as bar:
        for i in range(100):
            time.sleep(0.02)
            bar()
            
    # 万圣节风格
    config_handler.set_global(bar='halloween', spinner='stars')
    with alive_bar(100, title='Halloween Style') as bar:
        for i in range(100):
            time.sleep(0.02)
            bar()

def main():
    """主函数"""
    print("进度条演示开始...\n")
    show_progress_bars()
    print("\n演示完成!")

if __name__ == "__main__":
    main() 