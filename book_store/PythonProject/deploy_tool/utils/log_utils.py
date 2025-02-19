#!/usr/bin/env python3
# -*- coding: utf-8 -*-

from rich.console import Console

console = Console()

def log_info(message: str) -> None:
    """输出信息日志"""
    console.print(f"[cyan][INFO] {message}[/cyan]")

def log_error(message: str) -> None:
    """输出错误日志"""
    console.print(f"[red][ERROR] {message}[/red]")

def log_warn(message: str) -> None:
    """输出警告日志"""
    console.print(f"[yellow][WARN] {message}[/yellow]") 