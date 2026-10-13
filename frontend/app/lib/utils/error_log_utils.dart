import 'package:yun_men_yi_pan/common/index.dart';
import 'package:dio/dio.dart';

class ErrorLogUtils {

  //两端通用上传日志方法
  static Future<ResponseAnalyzed?> addLog(ResponseAnalyzed result) async {
    return await CommonRequest.addLog(result.request?.path ?? "", _getParam(result));
  }

  ///@description 单独的上传错误日志的接口，不分设备，只上传错误信息，目前用在tryCatch。
  static void addLogSingle({required String fun, required String error, bool? isShowToUser = false}) async {
    if (isShowToUser ??= false) {
      showMessage(error);
    }
    Map<String, dynamic> map = {
      "requestTime": DateTime.now().toString(),
      "interfaceAddress": fun,
      "requestMethod": "",
      "phoneBrand": AppManager.brand,
      "phoneModel": AppManager.deviceModel + AppManager.deviceName,
      "phoneVersion": _getPhoneVersion(),
      "requestParam": "logSingle",
      "errorContent": error + _getLoginInfo()
    };
    await CommonRequest.addLog(fun, map);
  }

//--------------------------------------------------------------------------------
  ///@description 避免addLog日志死循环的终极办法:暂时没用，如果上传日志再出现死循环，就启用它
  void addLogByDio(ResponseAnalyzed result) async {
    try {
      var dio = Dio();
      await dio.post("${httpManager.baseUrl}/pub/v1/errorLog/addLog", data: _getParam(result));
    } on Exception catch (e) {
      if (!ObjectUtil.isEmpty(e)) {
        logger.w("addLogByDio catch Exception =>${e.toString()}");
      }
    }
  }
//--------------------------------------------------------------------------------

  ///@description 两端通用上传参数信息
  static String? _getRequestParam(ResponseAnalyzed result) {
    var requestParam = result.request?.data;
    String? requestParamResult;
    if (requestParam is String) {
      requestParamResult = JsonUtil.encodeObj(requestParam);
    }
    return requestParamResult;
  }

  ///@description 两端通用的参数
  static Map<String, dynamic> _getParam(ResponseAnalyzed result) {
    Map<String, dynamic> map = {
      "requestTime": DateTime.now().toString(),
      "interfaceAddress": result.request?.path,
      "requestMethod": result.request?.method.toString(),
      "phoneBrand": AppManager.brand,
      "phoneModel": AppManager.deviceModel + AppManager.deviceName,
      "requestParam": _getRequestParam(result),
      "phoneVersion": _getPhoneVersion(),
      "errorContent": getErrorContent(result)
    };
    return map;
  }

  ///@description 两端通用报错信息
  static String getErrorContent(ResponseAnalyzed result) {
    final errorMap = {
      'code': result.code,
      'msg': result.message,
      'data': JsonUtil.encodeObj(result.data) ?? dataIsNull,
    };
    String? errorContent = JsonUtil.encodeObj(errorMap)! + _getLoginInfo();
    // logger.d("errorContent-$errorContent");
    return errorContent+AppManager.brand;
  }

  ///@description 两端分开的手机型号信息
  static String? _getPhoneVersion() {
    String? pVersion = "";

    String? phoneVersionIOS = AppManager.buildNumber +
        "#" + //
        AppManager.version; //

    String? phoneVersionAndroid = AppManager.buildNumber +
        "#" + //
        AppManager.version + //
        "#" + //
        AppManager.osReleaseVersionForAndroid + //
        "#" + //
        AppManager.osSdkIntForAndroid.toString(); //

    if (Platform.isIOS) {
      pVersion = phoneVersionIOS;
    } else if (Platform.isAndroid) {
      pVersion = phoneVersionAndroid;
    }
    return pVersion;
  }

  ///@description 两端通用登录信息
  static String _getLoginInfo() {
    //----------------------------------------------------
    StringBuffer stringBuffer = StringBuffer();
    stringBuffer.write("#");
    stringBuffer.write("inputBox");
    stringBuffer.write(":");
    stringBuffer.write(AppManager.userAccount?.loginName);
    //----------------------------------------------------
    stringBuffer.write("#");
    stringBuffer.write("trueName");
    stringBuffer.write(":");
    stringBuffer.write(AppManager.userAccount?.trueName);
    //----------------------------------------------------
    stringBuffer.write("#");
    stringBuffer.write("loginName");
    stringBuffer.write(":");
    stringBuffer.write(AppManager.userAccount?.loginName);
    return stringBuffer.toString();
  }
}
