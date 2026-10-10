
## Android 环境
在 android/gradle.properties 中需要配置自己的 Java 环境
例如：org.gradle.java.home=/Library/Java/JavaVirtualMachines/liberica-jdk-17-full.jdk/Contents/Home

```
android.useAndroidX=true
android.enableJetifier=true

applicationName=com.example.yourapp.MyApplication

systemProp.gradle.http.protocols=TLSv1.2,TLSv1.3
systemProp.gradle.https.protocols=TLSv1.2,TLSv1.3

org.gradle.java.home={your java home}.jdk/Contents/Home
org.gradle.jvmargs=-Xmx4G -XX:MaxMetaspaceSize=2G -XX:+HeapDumpOnOutOfMemoryError

namespace 'dev.henryleunghk.flutter_native_text_input'
namespace 'com.zero.app_installer'
namespace 'io.flutter.plugins.packageinfo'
namespace 'com.umeng.message.flutter'
namespace 'com.umeng.umeng_common_sdk'

```



# Dart

### 你可以使用 dart fix --dry-run 来查看 dart fix 将会进行的修复而不实际应用这些修复。这可以帮助你确认将要进行的更改。

```shell
dart fix --dry-run
```

### 你可以使用 dart fix --apply 命令来自动修复 Dart 代码中的所有诊断问题。具体命令如下：

```shell
dart fix --apply
```


## floor代码生成器：一般的只生成一次即可
```bash
dart run build_runner build
````

## floor代码生成器观察模式：不常用
```bash
dart run build_runner watch
````


# Flutter 环境

```shell
### 查看当前使用的版本
flutter --version
```

# Flutter Version Manager

### 查看当前已安装的版本

```shell
fvm list
```

```shell
### 查看官方已发布的版本
fvm release
```

### 安装指定版本
```shell
fvm install 3.24.0
```

### 设置全局版本

```shell
fvm global 3.24.0
```

### 删除指定版本

```shell
fvm remove 3.24.0-0.2.pre
```

### 查看当前已安装的版本

```shell
fvm list 
```

### 查看当前使用的版本
```shell
flutter --version
```


## 安装
```bash
flutter pub get
flutter create .
#尝试清理缓存20240731
flutter pub cache repair

flutter pub upgrade --major-versions
```


## 使用 dart 宏 main run 配置
```bash
--enable-experiment=macros
```


## 运行
```bash
# Web
flutter run -d chrome

# Windows
flutter run -d windows

# iOS
flutter run iOS --release

# Android
flutter run -d android

```
## 运行并且查看详细日志-主要看报错日志
```bash
flutter run -d -v
```
### 构建debug，终端会输出构建的详细日志信息
```bash
flutter build apk --debug -v
```
### 构建release，终端会输出构建的详细日志信息
```bash
flutter build apk --release -v
```
### 指定设备：小米手机，终端会输出构建的详细日志信息
```bash
flutter run -d a4d368e60406 -v
```


## 打包
```bash
# Web
flutter build web

# Windows
flutter build windows

# iOS
flutter build ios

# Android
flutter build apk
#跳过压缩打包时间快
flutter build apk --release --no-shrink --enable-experiment=macros
#忽略报错打包
flutter build apk --release --enable-experiment=macros
flutter build apk --debug -v
#打包成功展示
#√ Built build\app\outputs\flutter-apk\app-release.apk (120.6MB)
#floor代码生成器：一般的只生成一次即可已过时
flutter packages pub run build_runner build
#floor代码生成器观察模式：不常用
flutter packages pub run build_runner watch
#floor代码生成器：
dart run build_runner build
```


#### 欢迎使用 App 打包脚本

作者：李雪松
微信：CoderXSLee
如需帮助，请联系作者

请选择要打包的平台:
1. Android
2. iOS Ad Hoc
3. iOS App Store
4. 全部
支持多选，请用空格分开。例如：1 3
请输入你的选择: 2

    是否上传到 Pgyer？
    1. 上传
    2. 不上传
请输入你的选择: 2
   
```
当前的软件版本为：1.6.0+240913103602
将版本自动更新为：1.6.1+240913103803
您是否需要自定义软件版本号？(y/n): n
版本号成功更新为：1.6.1+240913103803
正在打包 iOS 平台 Ad Hoc 测试分发版 e车联_Ad_v1.6.0+240913103602.ipa 文件...
Resolving dependencies...
Xcode archive done.                                         61.9s
✓ Built build/ios/archive/Runner.xcarchive (377.1MB)
[✓] App Settings Validation
• Version Number: 1.6.1
• Build Number: 240913103803
• Display Name: e车联
• Deployment Target: 12.0
• Bundle Identifier: com.auto.steward
正在将 auto_shop_server.ipa 文件移动到目录：archive/ios/AdHoc/
已成功将 ipa 文件已移动到 archive/ios/AdHoc/e车联_Ad_v1.6.0+240913103602.ipa
iOS 平台 Ad Hoc 版 e车联.ipa 打包完成！
正在读取更新日志...
更新内容
[1.5.3] - 2024-09-11
新增
- 电子签动态费用项
  修复
- 修复了一些二手车已知的问题

  Press [Enter] key to close this window...

版本号
通常用来标识软件的主、次版本和补丁级别，分为以下两部分
软件版本号：1.5.3
构建版本号：+230913095133
```

# 1. 软件版本号
    例如：1.5.3 这是一个典型的语义化版本号（Semantic Versioning），通常用于描述代码的状态和兼容性。它由三段组成：

    • 1：主版本号 (major version)，当你进行不兼容的 API 变更时递增。
    • 5：次版本号 (minor version)，当你添加功能并且保持向后兼容时递增。
    • 4：补丁版本号 (patch version)，当你进行向后兼容的 bug 修复时递增。

    生成规则：

    每次打包时自动递增补丁版本号（4）。
    每次执行打包脚本时，脚本会从现有的 pubspec.yaml 文件中读取版本号。
    提取最后一个补丁号，将其自增 1，然后生成新的版本号。

    例如：

    • 当前版本号为 1.5.4，下次打包时会变为 1.5.5。
    • 再下次打包后，会变为 1.5.6，以此类推。

# 2. 构建号部分

    +230915082733 为构建版本号，是用于标识每个不同版本的具体构建。
    它的作用是确保每次生成的安装包都有一个独一无二的标识符，避免重复。
    在你所定义的规则中，构建号包括时间戳和构建计数器两部分，结构如下：

    • 时间戳部分：2309150827
    • 23：表示年份（2023年）。
    • 09：表示月份（9月）。
    • 15：表示日期（15号）。
    • 0827：表示时间（08:27分）。

    这个时间戳部分会根据系统当前时间动态生成。

    • 构建计数器部分：33
    • 这是一个递增的包计数器。每次打包时，它会自动增加 1，从而区分同一天内的多个构建。

    比如：

    • 如果今天你第一次打包，计数器为 33。
    • 同一天再次打包，计数器会变为 34，确保同一天的不同构建具有不同的唯一标识。

    生成规则：

    每次执行打包脚本时：

    1. 生成当前的时间戳（2309150827）。
    2. 从上一次的构建号中提取最后两位（如 33），并自增 1。
    3. 拼接时间戳和新的构建计数器，生成完整的构建号。

    完整的版本号生成规则：

    1. 每次打包时，脚本会读取 pubspec.yaml 文件中的版本号，递增补丁号。
    2. 自动生成当前的时间戳和递增的构建计数器。
    3. 生成一个完整的版本号，例如：
    • 1.5.4+230915082733（初始版本）。
    • 打包一次后为：1.5.5+230915082734（第二个版本）。
    • 随着时间的推移和构建次数的增加，版本号会自动递增，确保唯一性和连续性。

    这套规则可以帮助你确保每次打包的版本号是唯一的，并且能够通过构建号追踪具体的打包时间和次数。





### QQ
1363852560

### Wechat
CoderXSLee


```
无法打开“iproxy”，因为无法验证开发者。
这个要注意下，解决的是iproxy无法打开的问题
sudo xattr -r -d com.apple.quarantine ~/flutter/bin/cache/artifacts/usbmuxd/iproxy
sudo xattr -r -d com.apple.quarantine ~/flutter/bin/cache/artifacts/libimobiledevice/idevicesyslog

sudo xattr -r -d com.apple.quarantine /opt/homebrew/Caskroom/flutter/3.22.1/flutter/bin/cache/artifacts/usbmuxd/iproxy

sudo xattr -r -d com.apple.quarantine ~/flutter/bin/cache/artifacts/libimobiledevice/idevice_id
sudo xattr -r -d com.apple.quarantine ~/flutter/bin/cache/artifacts/libimobiledevice/idevicename
sudo xattr -r -d com.apple.quarantine ~/flutter/bin/cache/artifacts/libimobiledevice/idevicescreenshot
sudo xattr -r -d com.apple.quarantine ~/flutter/bin/cache/artifacts/libimobiledevice/ideviceinfo

解决iOS访问网页白屏的问题，因为默认已经不支持http了
<key>NSAppTransportSecurity</key>
<dict>
<key>NSAllowsArbitraryLoads</key>
<true/>
</dict>

get create page:xx on home
get create view:xx on home
get generate model on user with lib/app/modules/app_gauges/models/gauges_model.json --skipProvider
get generate model on lib/app_dossier/model with lib/app_dossier/model/dossier_details_model.json --skipProvider


get generate model on lib/app/modules/used_car_manager/models with lib/app/modules/used_car_manager/models/asas.json --skipProvider

```



# 需求文档模板

## 1. 基本信息
- 需求标题：
- 提出人：
- 提出日期：
- 期望完成日期：
- 优先级：[P0/P1/P2/P3] (P0最高，P3最低)

## 2. 需求背景
### 2.1 现状描述
- 描述当前存在的问题或现状
- 为什么需要这个功能

### 2.2 目标用户
- 这个功能服务于哪些用户群体
- 用户的痛点是什么

## 3. 功能描述
### 3.1 核心功能
- 用简单的语言描述这个功能是做什么的
- 列出主要功能点

### 3.2 功能详情
- 具体的功能流程
- 每个步骤的详细说明
- 可以配合流程图说明

### 3.3 业务规则
- 列出相关的业务规则和限制条件
- 特殊情况的处理方式

## 4. 界面设计
### 4.1 界面原型
- 可以是手绘草图
- 或简单的界面示意图
- 标注重要的界面元素

### 4.2 交互说明
- 描述用户操作流程
- 各种状态的切换说明
- 错误提示的处理方式

## 5. 技术要求
### 5.1 系统依赖
- 需要用到哪些系统或服务
- 是否需要新的API接口

### 5.2 性能要求
- 响应时间要求
- 并发处理能力
- 其他技术指标

## 6. 测试要点
- 列出需要重点测试的功能点
- 可能出现的异常情况
- 边界条件测试

## 7. 验收标准
- 列出具体的验收条件
- 功能测试通过的标准
- 性能指标达到的要求

## 8. 补充说明
- 其他需要说明的内容
- 潜在风险提示
- 相关文档链接
