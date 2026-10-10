import 'dart:convert';
import 'dart:typed_data';

// import 'dart:typed_data';
import 'package:auto_shop_server/common/index.dart';
import 'package:auto_shop_server/app/utils/sring_utils.dart';
import 'package:auto_shop_server/utils/error_log_utils.dart';
import 'package:http/http.dart' as http;
import 'package:image_gallery_saver_plus/image_gallery_saver_plus.dart';
import 'package:path_provider/path_provider.dart';

///@description 整理常用的文件操作方法
///@updateTime 2024/10/12 18:02
class FileUtilsMy {
  FileUtilsMy._();

  /// 获取应用专属文件夹路径
  /// 文档目录: /data/user/0/com.example.myapp/app_flutter
  ///  应用程序的目录，用于存储只有它可以访问的文件。只有当应用程序被删除时，系统才会清除目录。
  static Future<String?> getAppDocumentsDirectory() async {
    try {
      Directory appDocDir = await getApplicationDocumentsDirectory();
      return appDocDir.path;
    } catch (err) {
      logger.d("getAppDocumentsDirectory报错=>$err");
      return null;
    }
  }

  //@description 创建文件夹
  // static Future<Directory> createFolder(String folderName) async {
  //   String path = join((await getAppDocumentsDirectory()), folderName);
  //   return Directory(path).create(recursive: true);
  // }

  ///@description保存在外部
  static Future<String> getDownLoadDirPath() async {
    try {
      String dirDownLoadPath;
      dirDownLoadPath = "${(await getApplicationDocumentsDirectory()).absolute.path}/$dirDownLoad";
      return dirDownLoadPath;
    } on Exception catch (e) {
      if (!ObjectUtil.isEmpty(e)) {
        logger.w("getSavedDir catch Exception =>${e.toString()}");
        ErrorLogUtils.addLogSingle(fun: "getDownLoadDirPath", error: "$e");
      }
      return "";
    }
  }

  //获取下载完毕拷贝的文件夹
  static Future<String> getCompleteDirPath() async {
    try {
      String dirCompletePath;
      dirCompletePath = "${(await getApplicationDocumentsDirectory()).absolute.path}/$dirComplete";
      return dirCompletePath;
    } on Exception catch (e) {
      if (!ObjectUtil.isEmpty(e)) {
        logger.w("getCompleteDirPath catch Exception =>${e.toString()}");
        ErrorLogUtils.addLogSingle(fun: "getCompleteDirPath", error: "$e");
      }
      return "";
    }
  }

  /// 列出文件夹内容
  static Future<List<FileSystemEntity>> listFolder(String folderPath) async {
    Directory directory = Directory(folderPath);
    return directory.list().toList();
  }

  ///初始化文件路径，默认选中应用程序的目录
  static Future<File?> getAppFile(String fileName) async {
    //获取存储路径
    final filePath = await getAppDocumentsDirectory();
    if (filePath == null) {
      return null;
    }
    //或者file对象（操作文件记得导入import 'dart:io'）
    return File("$filePath/$fileName");
  }

  ///获取存在文件中的数据，默认读到应用程序的目录
  ///使用async、await，返回是一个Future对象
  static Future<String?> readStringDir(String fileName) async {
    try {
      final file = await getAppFile(fileName);
      return await file?.readAsString();
    } catch (err) {
      logger.d("readStringDir-报错=>$err");
      return null;
    }
  }

  /// 写入json文件，默认写到应用程序的目录
  static Future<File?> writeJsonFileDir(Object obj, String fileName) async {
    if (ObjectUtil.isEmpty(obj)) {
      return null;
    }

    try {
      final file = await getAppFile(fileName);
      return await file?.writeAsString(json.encode(obj));
    } catch (err) {
      logger.d("writeJsonFileDir-报错=>$err");
      return null;
    }
  }

  ///利用文件存储字符串，默认写到应用程序的目录
  static Future<File?> writeStringDir(String string, String filePath) async {
    if (ObjectUtil.isEmptyString(string)) {
      return null;
    }
    try {
      final file = await getAppFile(filePath);
      return await file?.writeAsString(string);
    } catch (err) {
      logger.d("writeStringDir-报错=>$err");
      return null;
    }
  }

  ///清除缓存数据
  static Future<bool> clearFileDataDir(String fileName) async {
    try {
      final file = await getAppFile(fileName);
      file?.writeAsStringSync("");
      return true;
    } catch (err) {
      logger.d("clearFileDataDir-报错=>$err");
      return false;
    }
  }

  ///删除缓存文件
  static Future<bool> deleteFileDataDir(String fileName) async {
    try {
      final file = await getAppFile(fileName);
      file?.delete();
      return true;
    } catch (err) {
      logger.d("deleteFileDataDir-报错=>$err");
      return false;
    }
  }

  /// 临时目录: /data/user/0/com.example.myapp/cache
  ///@description 一个临时目录(缓存)，系统可以随时清除。
  static Future<String?> getTempDir() async {
    try {
      Directory tempDir = await getTemporaryDirectory();
      return tempDir.path;
    } catch (err) {
      logger.d("getTempDir-报错=>$err");
      return null;
    }
  }

  ///创建file文件:传递自定义存储路径
  static readFile(filePath) {
    return File('$filePath');
  }

  /// 写入json文件，自定义路径
  static Future writeJsonCustomFile(Object obj, String filePath) async {
    if (ObjectUtil.isEmpty(obj)) {
      return null;
    }
    try {
      final file = readFile(filePath);
      return await file.writeAsString(json.encode(obj));
    } catch (err) {
      logger.d("writeJsonCustomFile-报错=>$err");
      return null;
    }
  }

  ///利用文件存储字符串，自定义路径
  static Future<File?> writeStringFile(String string, String filePath) async {
    if (ObjectUtil.isEmptyString(string)) {
      return null;
    }
    try {
      final file = readFile(filePath);
      return await file.writeAsString(string);
    } catch (err) {
      logger.d("writeStringFile-报错=>$err");
      return null;
    }
  }

  ///获取自定义路径文件存中的数据
  ///使用async、await，返回是一个Future对象  需要自定义路径
  static Future<String?> readStringCustomFile(String filePath) async {
    try {
      final file = readFile(filePath);
      return await file.readAsString();
    } catch (err) {
      logger.d("readStringCustomFile-报错=>$err");
      return null;
    }
  }

  ///清除缓存数据 需要自定义路径
  static Future<bool> clearFileData(String filePath) async {
    try {
      final file = readFile(filePath);
      file.writeAsStringSync("");
      return true;
    } catch (err) {
      logger.d("clearFileData-报错=>$err");
      return false;
    }
  }

  ///删除缓存文件  需要自定义路径
  static Future<bool> deleteFileData(String filePath) async {
    try {
      final file = readFile(filePath);
      file.delete();
      return true;
    } catch (err) {
      logger.d("deleteFileData-报错=>$err");
      return false;
    }
  }

  ///@description 读取json文件
  static Future<String?> readJsonFile(filePath) async {
    try {
      final file = readFile(filePath);
      return await file.readAsString();
    } catch (err) {
      logger.d("readJsonFile-报错=>$err");
      return null;
    }
  }

  ///@description 写入json文件
  static Future writeJsonFile(obj, filePath) async {
    try {
      final file = readFile(filePath);
      return await file.writeAsString(json.encode(obj));
    } catch (err) {
      logger.d("readJsonFile-报错=>$err");
      return null;
    }
  }

  ///@description 文件拷贝
  ///@updateTime 2024/10/12 20:01
  static void copyFile(String sourcePath, String destinationPath) {
    try {
      File sourceFile = File(sourcePath);
      if (!ObjectUtil.isEmpty(sourceFile)) {
        logger.d("sourceFile->${sourceFile.absolute.path}");
      }
      //
      File destinationFile = File(destinationPath);
      if (!ObjectUtil.isEmpty(destinationFile)) {
        logger.d("destinationPath->${destinationFile.absolute.path}");
      }
      sourceFile.copySync(destinationFile.path);
    } on Exception catch (e) {
      if (!ObjectUtil.isEmpty(e)) {
        logger.w("copyFile 报错 =>${e.toString()}");
        ErrorLogUtils.addLogSingle(fun: "copyFile", error: "copyFile报错$e");
      }
    }
  }

  // import 'dart:io';
  // import 'package:path_provider/path_provider.dart';
  ///@description 第二种拷贝文件的方式：范例：copyFile('example.txt', 'example_copy.txt');
  ///@updateTime 2024/10/15 9:04
  static Future<void> copyFile2(String fromPath, String toPath) async {
    // 获取应用文件存储目录
    final directory = await getApplicationDocumentsDirectory();
    final fromFile = File('$directory.path/$fromPath');
    final toFile = File('$directory.path/$toPath');

    // 复制文件
    await toFile.writeAsBytes(await fromFile.readAsBytes());
  }

  ///@description 保存图片到相册--//timeLast 2025/3/25 发现这块代码出现苹果端和安卓端保存图片报错。
  /*static Future<void> saveImageToAlbum(String urlOrFilePath, {bool? showMsg = false}) async {
    saveImageNormal() async {
      // 请求权限
      final PermissionState permissionState = await PhotoManager.requestPermissionExtend();
      AssetEntity? result;
      if (permissionState.isAuth) {
        try {
          Uint8List imageData;
          // 判断是网络图片还是本地图片
          if (urlOrFilePath.startsWith(httpStartWithPrefix)) {
            // 下载网络图片
            final http.Response response = await http.get(Uri.parse(urlOrFilePath));
            imageData = response.bodyBytes;
            // 保存图片到相册
            result = await PhotoManager.editor.saveImage(imageData, filename: '');
          } else {
            //LoggerTool.logMy("保存图片到本地--saveImageWithPath--$urlOrFilePath");
            // 读取本地图片
            result = await PhotoManager.editor.saveImageWithPath(urlOrFilePath);
          }

          if (showMsg ?? false) {
            showMessage("图片保存成功");
            logger.i("saveImageToAlbum--图片保存成功");
          }
          // ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('图片保存成功')));
        } catch (e) {
          if (showMsg ?? false) {
            showMessage("图片保存失败");
          }
          ErrorLogUtils.addLogSingle(fun: "saveImageToAlbum", error: "图片保存失败第一个catch$e");
          // ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('图片保存失败：$e')));
        }
      } else {
        showMessage("请授予存储权限");
        ErrorLogUtils.addLogSingle(fun: "saveImageToAlbum", error: "图片保存未授予权限");
        // ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('请授予存储权限')));
      }
    }

    //区分android或者苹果设备
    //-------------------------------
    if (Platform.isIOS) {
      saveImageNormal();
    }
    //-------------------------------
    if (Platform.isAndroid) {
      List<Permission> permissions;
      if (AppManager.osSdkIntForAndroid < ANDROID_OS_SDK_33) {
        permissions = [Permission.storage];
      } else {
        permissions = [Permission.manageExternalStorage];
      }

      BaseController baseController = BaseController();
      bool hasPermissionNotAllow = await baseController.checkPermissionAndroidList(permissions);
      if (hasPermissionNotAllow) {
        showMessageBottomLikeAndroid("存储权限未打开", isLong: false);
        CommonTools.showDialogPermissionAndroidList(
            permissions: permissions,
            messageToUser: permission_content_camera_storage,
            doGranted: () {
              saveImageNormal();
            });
      } else {
        LoggerTool.logMy("存储权限----已放开");
        saveImageNormal();
      }
    }
    //-------------------------------
  }*/

  ///@description 保存图片到相册--第二次改造
  static Future<void> saveImageToAlbumByImageGallerySaverPlus(String urlOrFilePath, {bool? showMsg = false}) async {
    //
    imageGallerySaverMy() async {
      // 请求权限
      try {
        String fileName = DateUtil.formatDate(DateTime.now(), format: timeFormatDateTooLong2) + StringUtils.splitPathName(urlOrFilePath ?? "");
        // 判断是网络图片还是本地图片
        if (urlOrFilePath.startsWith(httpStartWithPrefix)) {
          // 下载网络图片
          final http.Response responseCurr = await http.get(Uri.parse(urlOrFilePath));
          if (responseCurr.statusCode == 200) {
            await ImageGallerySaverPlus.saveImage(Uint8List.fromList(responseCurr.bodyBytes), quality: 100, name: fileName);
          }
        }

        if (showMsg ?? false) {
          showMessage("保存成功$fileName");
          logger.i("saveImageToAlbum--图片保存成功");
        }
        // ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('图片保存成功')));
      } catch (e) {
        if (showMsg ?? false) {
          showMessage("图片保存失败");
        }
        ErrorLogUtils.addLogSingle(fun: "saveImageToAlbum", error: "图片保存失败第一个catch$e");
        // ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('图片保存失败：$e')));
      }
    }

    //区分android或者苹果设备
    //-------------------------------
    if (Platform.isIOS) {
      imageGallerySaverMy();
    }
    //-------------------------------
    if (Platform.isAndroid) {
      List<Permission> permissions;
      if (AppManager.osSdkIntForAndroid < ANDROID_OS_SDK_33) {
        permissions = [Permission.storage];
      } else {
        permissions = [Permission.manageExternalStorage];
      }

      BaseController baseController = BaseController();
      bool hasPermissionNotAllow = await baseController.checkPermissionAndroidList(permissions);
      if (hasPermissionNotAllow) {
        showMessageBottomLikeAndroid("存储权限未打开", isLong: false);
        CommonTools.showDialogPermissionAndroidList(
            permissions: permissions,
            messageToUser: permission_content_camera_storage,
            doGranted: () {
              imageGallerySaverMy();
            });
      } else {
        LoggerTool.logMy("存储权限----已放开");
        imageGallerySaverMy();
      }
    }
    //-------------------------------
  }

  //保存图片到相册  不需要权限--没有用到
  /*static Future<void> saveImageToAlbum2(String urlOrFilePath) async {
    try {
      LoggerTool.logMy("保存图片到本地--saveImageWithPath--$urlOrFilePath");
      PhotoManager.setIgnorePermissionCheck(true);
      await PhotoManager.editor.saveImageWithPath(urlOrFilePath);
      //showMessage("图片保存成功");
      // ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('图片保存成功')));
    } catch (e) {
      //showMessage("图片保存失败");
      ErrorLogUtils.addLogSingle(fun: "saveImageToAlbum2", error: "图片保存失败$e");
    }
  }*/

// 删除文件夹
  // static Future<void> deleteFolder(String folderPath) async {
  //   Directory directory = Directory(folderPath);
  //   return directory.delete(recursive: true);
  // }

// static Future checkInstallPermission() async {
//   // Native channel
//   var result;
//   try {
//     result = await f2kChannel.invokeMethod("checkInstallPermission");
//     // L.v("result call checkInstallPermission result $result ");
//   } on Exception catch (e) {
//     print(e.toString());
//     // L.v("result call checkInstallPermission error$e");
//   }
//   return result;
// }

// Future<void> _prepareSaveDir() async {
//   _localPath = (await _getSavedDir())!;
//   final savedDir = Directory(_localPath);
//   if (!savedDir.existsSync()) {
//     await savedDir.create();
//   }
// }

//保存在外部
// Future<String?> _getSavedDir() async {
//   String? externalStorageDirPath;
//   externalStorageDirPath = (await getApplicationDocumentsDirectory()).absolute.path;
//   return externalStorageDirPath;
// }

//保存到 download
// Future<String?> _getSavedDir() async {
//   String? externalStorageDirPath;
//   externalStorageDirPath = (await getDownloadsDirectory())?.absolute.path;
//   return externalStorageDirPath;
// }
}

// Future<void> createAndListFolder() async {
//   // 创建文件夹
//   Directory directory = await FolderUtils.createFolder('my_folder');
//   print('Created folder: ${directory.path}');
//
//   // 列出文件夹内容
//   List<FileSystemEntity> entities = await FolderUtils.listFolder(directory.path);
//   print('Listed folder contents: $entities');
// }
//
// Future<void> deleteFolder() async {
//   // 获取文件夹路径
//   String folderPath = join((await FolderUtils.getAppDocumentsDirectory()), 'my_folder');
//
//   // 删除文件夹
//   await FolderUtils.deleteFolder(folderPath);
//   print('Folder deleted');
// }
