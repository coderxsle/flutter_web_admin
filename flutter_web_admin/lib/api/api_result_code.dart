import 'package:flutter/foundation.dart';
import 'package:flutter_web_admin/my_dialog.dart';
import 'package:http_manager/http_manager.dart';

class ResultCode {
  static String loading         = "loading";  // 请求中
  static String success         = "200";      // 请求成功
  static String emptyData       = "20002";    // 请求成功,数据为空
  static String noMoreData      = "20003";    // 请求成功,无更多数据
  static String resubmit        = "20008";    // 重复提交
  static String error           = "error";    //
  static String failure         = "400";
  static String abnormal        = "abnormal";
  static String tokenNull       = "10005";
  static String uuidNull        = "10302";
}

extension ResponseAnalyzedExtention on ResponseAnalyzed {
  bool get success            => code == '200';
  bool get failure            => code != '200';

  bool get empty              => code == '20002';
  bool get emptyToken         => code == '10005' || code == '10102' || code == '10302';
  bool get noMoreData         => code == '20003';

  // 检查解析结果，进行统一处理不同状态下的结果码
  static checkeAnalyzing(ResponseAnalyzed result) async {
    var code = int.parse(result.code ?? "0");
    if (code == 20002 || code == 20003 || code == 27106 || (code == 29999 && result.message == "无更多数据")) {
      result.message = "";
    } else if (code == 20401) {
      // AppManager.signOut();
    } else if (code > 20000 && code < 30000) {
      debugPrint('code: $code, message: ${result.message!}');
      result.isExposedToUser = true;
      showMessage(result.message!);
      debugPrint("result.message! = ${result.message!}");
    } else if (code >= 10000 && code <= 19999) {
      if (result.emptyToken) {
        // _request = result.request;
        // AppLaunching.requestUserToken().then((result){
        //   if (result.success) {
        //     Logger.jsonFormat(_request!.headers);
        //     _request!.headers['UserToken'] = AppManager.userToken;
        //     HttpManager.retryRequestWithFetch(_request!).then((result2) {
        //       final controller = Get.find<LoginAccountController>();
        //       controller.getShopListAndHomeData();
        //     });
        //   } else {
        //     debugPrint("getUserToken 获取失败 ${result.message}");
        //   }
        // });
        // AppLaunching.requestUserToken();
        showMessage(result.message!);
      } else {
        // if (result.request!.path.contains(errorLog)) {
        //   return;
        // }
        // 上传错误日志
        // ErrorLogUtils.addLog(result);
      }
    } else if (code == 1000) {
      result = ResponseAnalyzed(code: "error", data: "", message: result.message);
      showMessage(result.message!);
    } else {
      result = ResponseAnalyzed(code: "error", data: "result.code", message: "result.code=null");
    }
    return result;
  }
}
