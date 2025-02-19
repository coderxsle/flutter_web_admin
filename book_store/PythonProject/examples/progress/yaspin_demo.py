"""
终端旋转器演示
"""
from yaspin import yaspin
from yaspin.spinners import Spinners
import time

def show_spinners():
    """展示不同的旋转器效果"""
    # 简单旋转器
    with yaspin(text="Loading...") as sp:
        time.sleep(2)
        sp.ok("✅")
    
    # 自定义颜色和文本
    with yaspin(Spinners.moon, text="Processing", color="yellow") as sp:
        time.sleep(2)
        sp.ok("🌙")
    
    # 变化文本
    with yaspin(Spinners.earth) as sp:
        for i in range(5):
            sp.text = f"Orbiting... {i}"
            time.sleep(0.4)
        sp.ok("🌍")

def main():
    show_spinners()

if __name__ == '__main__':
    main() 