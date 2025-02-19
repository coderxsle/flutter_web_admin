# 进度条演示

这个目录包含了几个不同进度条库的演示示例。

## 安装依赖

```
pip install -r requirements.txt
```

## Rich
最全面的终端美化库，支持表格、面板、语法高亮等。pip 使用的就是这个。

```
python examples/progress/rich_progress_demo.py
```

## Tqdm
最简单易用的进度条，支持迭代器包装，性能好，开销小。

```
python examples/progress/progress_demo.py
```

## Halo
专注于加载动画，有很多预设的动画效果，适合不确定进度的操作。

```
python examples/progress/spinners_demo.py
```

## Alive-Progress
动画效果丰富，支持自定义动画，有音乐播放器风格。

```
python examples/progress/alive_progress_demo.py
```

## Yaspin
轻量级旋转器，简单易用，适合命令行工具。

```
python examples/progress/yaspin_demo.py
```

## 注意事项

1. 确保已安装所有依赖
2. 某些动画效果在不同终端下可能显示不同
3. 建议在支持 Unicode 的终端中运行 