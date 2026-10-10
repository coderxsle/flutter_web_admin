import 'package:auto_shop_server/app/utils/common_widget/logger.dart';
import 'package:auto_shop_server/utils/error_log_utils.dart';
import 'package:common_utils/common_utils.dart';

class StringUtils {
  static List<String> stringToStringList(String text) {
    List<String> list = [];
    for (int i = 0; i < text.length; i++) {
      list.add(text.substring(i, i + 1));
    }
    return list;
  }

  static String stringListToString(List<String> list) {
    var text = '';
    for (int i = 0; i < list.length; i++) {
      text += list[i];
    }
    return text;
  }

  static String nullStringToEmpty(String input) {
    return input ?? "";
  }

  static bool isNullOrEmpty(String? str) {
    return str?.isEmpty ?? true;
  }

  static bool notNullNorEmpty(String str) {
    return !isNullOrEmpty(str);
  }

  //长路径分割为短名称
  static String splitPathName(String path) {
    String shortName = "";
    if (path.isNotEmpty) {
      shortName = path.substring(path.lastIndexOf('/') + 1);
    }
    return shortName;
  }

  //安装包名形如：2024-10-14 11:44:03应用名40.apk，需要截取后面的构建号
  static String? splitApkNameWithDateTime(String apkFullName) {
    try {
      String shortApkName = "";
      if (apkFullName.isNotEmpty) {
        shortApkName = apkFullName.substring(apkFullName.lastIndexOf('e') + 1);
      }
      return shortApkName;
    } on Exception catch (e) {
      if (!ObjectUtil.isEmpty(e)) {
        logger.d(" splitApkNameWithDateTime 报错 =>${e.toString()}");
        ErrorLogUtils.addLogSingle(fun: "splitApkNameWithDateTime", error: "splitApkNameWithDateTime$e");
      }
    }
    return "";
  }

  //根军更完整的服务器路径分割图片后缀
  static String getUrlSuffixName(String path) {
    String urlSuffix = "";
    List<String> fileName = [];
    if (path.isNotEmpty) {
      fileName = path.split("resource/");
      if (fileName.length > 1) {
        urlSuffix = fileName[1];
        //Logger.log("$logCatTag文件：$urlSuffix");
      }
    }
    return urlSuffix;
  }
}
