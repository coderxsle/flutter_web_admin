# -*- mode: python ; coding: utf-8 -*-


a = Analysis(
    ['/Users/coderxslee/workspace/book_store/book_store/PythonProject/deploy_tool/run.py'],
    pathex=['/Users/coderxslee/workspace/book_store/book_store/PythonProject'],
    binaries=[],
    datas=[('/Users/coderxslee/workspace/book_store/book_store/PythonProject/deploy_tool/config', 'config')],
    hiddenimports=['deploy_tool', 'deploy_tool.scripts', 'deploy_tool.scripts.main', 'deploy_tool.utils'],
    hookspath=[],
    hooksconfig={},
    runtime_hooks=[],
    excludes=[],
    noarchive=False,
    optimize=0,
)
pyz = PYZ(a.pure)

exe = EXE(
    pyz,
    a.scripts,
    a.binaries,
    a.datas,
    [],
    name='deploy_tool',
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
