# -*- mode: python ; coding: utf-8 -*-

block_cipher = None

a = Analysis(
    ['run.py'],  # 主入口脚本
    pathex=['.'],  # 添加当前目录到路径
    binaries=[],
    datas=[
        ('deploy_tool', 'deploy_tool'),  # 包含整个 deploy_tool 目录
        ('config.yaml', '.'),  # 包含配置文件
        ('.env.*', '.'),  # 包含所有环境配置文件
    ],
    hiddenimports=[
        'deploy_tool.scripts.build',
        'deploy_tool.scripts.deploy',
        'deploy_tool.scripts.package',
        'deploy_tool.scripts.main',
        'deploy_tool.utils.ssh_client',
        'deploy_tool.utils.env_utils',
        'deploy_tool.utils.system_utils',
        'deploy_tool.utils.log_utils',
        'deploy_tool.utils.progress',
        'fabric',
        'paramiko',
        'yaml',
        'rich',
        'typer',
    ],
    hookspath=[],
    hooksconfig={},
    runtime_hooks=[],
    excludes=[],
    win_no_prefer_redirects=False,
    win_private_assemblies=False,
    cipher=block_cipher,
    noarchive=False,
)

pyz = PYZ(
    a.pure, 
    a.zipped_data,
    cipher=block_cipher
)

exe = EXE(
    pyz,
    a.scripts,
    a.binaries,
    a.zipfiles,
    a.datas,
    [],
    name='deploy_tool',  # 生成的可执行文件名
    debug=False,
    bootloader_ignore_signals=False,
    strip=False,
    upx=True,
    upx_exclude=[],
    runtime_tmpdir=None,
    console=True,
    disable_windowed_traceback=False,
    argv_emulation=False,
    target_arch=None,
    codesign_identity=None,
    entitlements_file=None,
)
