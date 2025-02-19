"""
各种加载动画效果演示
"""
import time
from halo import Halo

def show_spinners():
    """展示不同的加载动画"""
    spinners = ['dots', 'dots12', 'line', 'arrow3', 'bouncingBar', 'christmas']
    
    for spinner in spinners:
        with Halo(text=f'Loading with {spinner}', spinner=spinner) as spinner:
            time.sleep(2)  # 模拟操作
            spinner.succeed('Done!')

def main():
    show_spinners()

if __name__ == '__main__':
    main() 