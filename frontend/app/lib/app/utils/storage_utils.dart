import 'dart:io';

import 'package:auto_shop_server/app/utils/common_widget/logger.dart';
import 'package:common_utils/common_utils.dart';
import 'package:path_provider/path_provider.dart';
// import 'package:yc_flutter_utils/object/object_utils.dart';

/// 存储文件管理类
class StorageUtils {
  /// getTemporaryDirectory
  /// 指向设备上临时目录的路径，该目录没有备份，适合存储下载文件的缓存。
  /// 此目录中的文件可以随时清除。这不会返回一个新的临时目录。
  /// 相反，调用者负责在这个目录中创建(和清理)文件或目录。这个目录的作用域是调用应用程序。
  /// 在iOS上，它使用“NSCachesDirectory”API。
  /// 在Android上，它在上下文中使用“getCacheDir”API。
  static Future<Directory> _initTempDir() {
    //获取一个临时目录(缓存)，系统可以随时清除。
    return getTemporaryDirectory();
  }

  /// getApplicationSupportDirectory
  /// 应用程序可以放置应用程序支持文件的目录的路径。
  /// 对不希望向用户公开的文件使用此选项。您的应用程序不应将此目录用于用户数据文件。
  /// 在iOS上，它使用“NSApplicationSupportDirectory”API。如果此目录不存在，则自动创建。
  /// 在Android上，此函数抛出一个[UnsupportedError]。
  static Future<Directory> _initSupportDir() {
    //应用程序支持文件的目录的路径
    return getApplicationSupportDirectory();
  }

  /// getApplicationDocumentsDirectory
  /// 获取应用程序的目录，用于存储只有它可以访问的文件。只有当应用程序被删除时，系统才会清除目录。
  /// 在iOS上，它使用“NSDocumentDirectory”API。如果数据不是用户生成的，请考虑使用[GetApplicationSupportDirectory]。
  /// 在Android上，这在上下文中使用了“getDataDirectory”API。如果数据对用户可见，请考虑改用getExternalStorageDirectory。
  static Future<Directory> _initAppDocDir() async {
    //获取应用程序的目录，用于存储只有它可以访问的文件。只有当应用程序被删除时，系统才会清除目录。
    return getApplicationDocumentsDirectory();
  }

  /// getExternalStorageDirectory
  /// 应用程序可以访问顶层存储的目录的路径。在发出这个函数调用之前，应该确定当前操作系统，因为这个功能只在Android上可用。
  /// 在iOS上，这个函数抛出一个[UnsupportedError]，因为它不可能访问应用程序的沙箱之外。
  /// 在Android上，它使用“getExternalStorageDirectory”API。
  static Future<Future<Directory?>> _initStorageDir() async {
    //应用程序可以访问顶层存储的目录的路径。
    return getExternalStorageDirectory();
  }

  /// 同步创建文件
  static Directory? createDir(String? path) {
    try {
      if (ObjectUtil.isEmpty(path)) {
        return null;
      }
      Directory dir = Directory(path!);
      if (!dir.existsSync()) {
        dir.createSync(recursive: true);
        logger.d("createDir-同步创建文件夹->${dir.path}");
      }
      return dir;
    } on Exception catch (e) {
      if (!ObjectUtil.isEmpty(e)) {
        logger.d(" catch Exception =>${e.toString()}");
      }
    }

    return null;
  }

  /// 异步创建文件
  static Future<Directory?> createDirSync(String path) async {
    if (ObjectUtil.isEmpty(path)) {
      return null;
    }
    Directory dir = Directory(path);
    bool exist = await dir.exists();
    if (!exist) {
      dir = await dir.create(recursive: true);
    }
    return dir;
  }

  /// 获取设备上临时目录的路径，该目录没有备份，适合存储下载文件的缓存。
  /// fileName 文件名
  /// dirName 文件夹名
  /// String path = StorageUtil.getTempPath(fileName: 'demo.png', dirName: 'image');
  static Future<String?> getTempPath({
    required String fileName,
    required String dirName,
  }) async {
    Directory tempDir = await _initTempDir();
    StringBuffer sb = StringBuffer(tempDir.path);
    if (!ObjectUtil.isEmpty(dirName)) {
      sb.write("/$dirName");
      createDir(sb.toString());
    }
    if (!ObjectUtil.isEmpty(fileName)) sb.write("/$fileName");
    return sb.toString();
  }

  /// 获取应用程序的目录，用于存储只有它可以访问的文件。只有当应用程序被删除时，系统才会清除目录。
  /// fileName 文件名
  /// dirName 文件夹名
  /// String path = StorageUtil.getAppDocPath(fileName: 'demo.mp4', dirName: 'video');
  static Future<String?> getAppDocPath({
    required String fileName,
    required String dirName,
  }) async {
    Directory appDocDir = await _initAppDocDir();
    StringBuffer sb = StringBuffer(appDocDir.path);
    if (!ObjectUtil.isEmpty(dirName)) {
      sb.write("/$dirName");
      createDir(sb.toString());
    }
    if (!ObjectUtil.isEmpty(fileName)) sb.write("/$fileName");
    return sb.toString();
  }

  ///
  /// fileName 文件名
  /// dirName 文件夹名
  static Future<String> getStoragePath({
    required String fileName,
    required String dirName,
  }) async {
    Directory storageDir = (await _initStorageDir()) as Directory;
    StringBuffer sb = StringBuffer(storageDir.path);
    if (!ObjectUtil.isEmpty(dirName)) {
      sb.write("/$dirName");
      createDir(sb.toString());
    }
    if (!ObjectUtil.isEmpty(fileName)) {
      sb.write("/$fileName");
    }
    return sb.toString();
  }

  /// 创建临时目录
  /// dirName 文件夹名
  /// String path = StorageUtil.createTempDir( dirName: 'image');
  static Future<Directory?> createTempDir({required String dirName}) async {
    Directory tempDir = await _initTempDir();
    StringBuffer sb = StringBuffer(tempDir.path);
    if (!ObjectUtil.isEmpty(dirName)) {
      sb.write("/$dirName");
    }
    return createDir(sb.toString());
  }

  /// 创建获取应用程序的目录
  /// fileName 文件名
  /// dirName 文件夹名
  /// String path = StorageUtil.getAppDocPath(fileName: 'demo.mp4', dirName: 'video');
  static Future<Directory?> createAppDocDir({required String dirName}) async {
    Directory appDocDir = await _initAppDocDir();
    StringBuffer sb = StringBuffer(appDocDir.path);
    if (!ObjectUtil.isEmpty(dirName)) {
      sb.write("/$dirName");
    }
    return createDir(sb.toString());
  }

  /// dirName 文件夹名
  /// category 分类，例如：video，image等等
  /// String path = StorageUtil.getStoragePath(fileName: 'yc.apk', dirName: 'apk');
  static Future<Directory?> createStorageDir({required String dirName}) async {
    Directory storageDir = (await _initStorageDir()) as Directory;
    StringBuffer sb = StringBuffer(storageDir.path);
    if (!ObjectUtil.isEmpty(dirName)) {
      sb.write("/$dirName");
    }
    return createDir(sb.toString());
  }
}
