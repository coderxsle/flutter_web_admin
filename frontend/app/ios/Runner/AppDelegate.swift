import UIKit
import Flutter
import UserNotifications
import flutter_downloader

@main
@objc class AppDelegate: FlutterAppDelegate {
    // 应用启动
    override func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
            GeneratedPluginRegistrant.register(with: self)
            UNUserNotificationCenter.current().delegate = self
            FlutterDownloaderPlugin.setPluginRegistrantCallback(registerPlugins)
            self.hookOldOpenUrl(tragetCls: Self.self)
            return super.application(application, didFinishLaunchingWithOptions: launchOptions)
        }
    
    // 前台收到推送
    override func userNotificationCenter(_ center: UNUserNotificationCenter, willPresent notification: UNNotification, withCompletionHandler completionHandler: @escaping (UNNotificationPresentationOptions) -> Void) {
        handlePushNotification(notification: notification, isBackground: false)
        completionHandler([.sound, .badge, .alert])
    }
    
    // 后台/锁屏收到推送
    override func userNotificationCenter(_ center: UNUserNotificationCenter, didReceive response: UNNotificationResponse, withCompletionHandler completionHandler: @escaping () -> Void) {
        handlePushNotification(notification: response.notification, isBackground: true)
        completionHandler()
    }
    
    
    // 统一处理通知声音的方法
    func handlePushNotification(notification: UNNotification, isBackground: Bool = false) {
        let userInfo = notification.request.content.userInfo
        
        // 1. 打印日志
        print("=== 收到\(isBackground ? "后台/锁屏" : "前台")推送通知 ===")
        printNotificationMessage(userInfo: userInfo)
        
        // 2. 处理友盟推送
        if notification.request.trigger is UNPushNotificationTrigger {
            #if canImport(UMPush)
            // App在前台时，收到通知后，是否显示Alert弹框
            UMessage.setAutoAlert(false)
            UMessage.didReceiveRemoteNotification(userInfo)
            #endif
        }else {
            if (isBackground) {
                // 后台时的本地推送接收
                print("后台时的本地推送接收")
            }else {
                // 前台时的本地推送接收
                print("前台时的本地推送接收")
            }
        }
        
        // 3. 处理友盟回调
        #if canImport(UmengPushSdkPlugin)
        if isBackground {
            UmengPushSdkPlugin.didOpenUMessage(userInfo)
        } else {
            UmengPushSdkPlugin.didReceiveUMessage(userInfo)
        }
        #endif
    }

    // 打印通知内容的方法
    func printNotificationMessage(userInfo: [AnyHashable: Any]) {
        // 1. 格式化打印 JSON
        if let jsonData = try? JSONSerialization.data(withJSONObject: userInfo, options: .prettyPrinted),
           let jsonString = String(data: jsonData, encoding: .utf8) {
            print("JSON格式: \n\(jsonString)")
        }
        
        // 2. 解析关键字段
        if let aps = userInfo["aps"] as? [String: Any] {
            print("\n=== 推送详情 ===")
            if let alert = aps["alert"] as? [String: Any] {
                print("标题: \(alert["title"] ?? "")")
                print("副标题: \(alert["subtitle"] ?? "")")
                print("内容: \(alert["body"] ?? "")")
            }
            print("角标: \(aps["badge"] ?? "")")
            print("声音: \(aps["sound"] ?? "")")
        }
    }


    // 替换openURL方法
    // 使用g_openURL方法替换openURL方法
    // 解决iOS17.0以上版本，微信SDK使用弃用的openURL方法打开App或者链接失败的问题
    func hookOldOpenUrl(tragetCls: AnyClass){
        let cls = UIApplication.self
        let originalSelector = #selector(UIApplication.openURL(_:))
        let swizzledSelector = #selector(g_openURL)
        let originalMethod = class_getInstanceMethod(cls, originalSelector)
        let swizzledMethod = class_getInstanceMethod(tragetCls, swizzledSelector)
        let didAddMethod: Bool = class_addMethod(cls, originalSelector, method_getImplementation(swizzledMethod!), method_getTypeEncoding(swizzledMethod!))
        if didAddMethod {
            class_replaceMethod(cls, swizzledSelector, method_getImplementation(originalMethod!), method_getTypeEncoding(originalMethod!))
        } else {
            method_exchangeImplementations(originalMethod!, swizzledMethod!)
        }
    }

    @objc func g_openURL(url: URL)->Bool {
        UIApplication.shared.open(url)
        return true
    }
    
    
}



private func registerPlugins(registry: FlutterPluginRegistry) {
    if (!registry.hasPlugin("FlutterDownloaderPlugin")) {
       FlutterDownloaderPlugin.register(with: registry.registrar(forPlugin: "FlutterDownloaderPlugin")!)
    }
}



//<key>UIBackgroundModes</key>
//<array>
//    <string>fetch</string>
//    <string>remote-notification</string>
//    <string>bluetooth-central</string>
//    <string>location</string>
//</array>
//<key>NSLocationWhenInUseUsageDescription</key>
//<string>为了为您提供基于位置的周边服务（例如附近商店、交通信息等），我们需要访问您的位置信息。</string>
//<key>NSBluetoothPeripheralUsageDescription</key>
//<string>为了让应用支持健康数据采集、设备控制和实时监控，我们需要访问蓝牙外设，如智能手表、运动追踪器等。</string>
//<key>NSLocationAlwaysUsageDescription</key>
//<string>为了提供完整的智能设备体验，我们需要在后台持续访问您的位置并通过蓝牙连接设备，例如智能手环、位置跟踪器等。</string>
//<key>NSBluetoothAlwaysUsageDescription</key>
//<string>此应用需要蓝牙权限，以便查找、连接附近的蓝牙设备并进行数据传输。例如，智能设备配对、实时数据同步和监控功能等都依赖蓝牙。</string>


