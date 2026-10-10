import 'dart:io';

import 'package:auto_shop_server/app/modules/launching/app_launching.dart';
import 'package:auto_shop_server/utils/error_log_utils.dart';
import 'package:flutter/foundation.dart';
import 'package:http_manager/http_manager.dart';

import 'app_manager.dart';
import 'common_widget/my_dialog.dart';
import 'strings.dart';

// ignore_for_file: non_constant_identifier_names
class ResultCode {
  static String loading         = "loading"; // 请求中
  static String success         = "20000"; // 请求成功
  static String empty_data      = "20002"; // 请求成功,数据为空
  static String no_more_data    = "20003"; // 请求成功,无更多数据
  static String resubmit        = "20008"; // 重复提交
  static String error           = "error"; //
  static String failure         = "400";
  static String abnormal        = "abnormal";
  static String token_null      = "10005";
  static String uuid_null       = "10302";
}

extension ResponseAnalyzedExtention on ResponseAnalyzed {
  bool get success            => code == '20000';
  bool get failure            => code != '20000';

  bool get empty              => code == '20002';
  bool get emptyToken         => code == '10005' || code == '10102' || code == '10302';
  bool get noMoreData         => code == '20003';

  // 检查解析结果，进行统一处理不同状态下的结果码
  static checkeAnalyzing(ResponseAnalyzed result) async {
    var code = int.parse(result.code ?? "0");
    if (code == 20002 || code == 20003 || code == 27106 || (code == 29999 && result.message == "无更多数据")) {
      result.message = "";
    } else if (code == 20401) {
      AppManager.signOut();
    } else if (code > 20000 && code < 30000) {
      debugPrint('code: $code, message: ${result.message!}');
      result.isExposedToUser = true;
      showMessage(result.message!);
      debugPrint("result.message! = ${result.message!}");
    } else if (code >= 10000 && code <= 19999) {
      if (result.emptyToken) {
        AppManager.userToken = "";
        // _request = result.request;
        // AppLaunching.requestUserToken().then((result){
        //   if (result.success) {
        //     Logger.jsonFormat(_request!.headers);
        //     _request!.headers['UserToken'] = AppManager.userToken;
        //     httpManager.retryRequestWithFetch(_request!).then((result2) {
        //       final controller = Get.find<LoginAccountController>();
        //       controller.getShopListAndHomeData();
        //     });
        //   } else {
        //     debugPrint("getUserToken 获取失败 ${result.message}");
        //   }
        // });
        AppLaunching.requestUserToken();
        showMessage(result.message!);
      } else {
        if (result.request!.path.contains(errorLog)) {
          return;
        }

        if (Platform.isIOS) {
          showFailureMessage("$code ${result.message}");
        }

        if (Platform.isAndroid) {
          showMessage(ErrorLogUtils.getErrorContent(result)); //特殊：给报错直接展示
        }
        // 上传错误日志
        ErrorLogUtils.addLog(result);
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













































// 哎呀，这个不行
// typedef Complete = void Function(dynamic data);
// typedef FromJson<T> = T Function(Map<String, Object?> json);
//
// extension GetxControllerExtensions on GetxController {
//   dynamic analyzing<T>(FromJson<T> fromJson, ResponseAnalyzed result) {
//     return _analyzing(fromJson, result);
//   }
// }
// extension FutureResponseAnalyzedExtension on Future<ResponseAnalyzed> {
//   dynamic analyzing<T>(FromJson<T> fromJson, {ResponseAnalyzed? result}) async {
//     result = result ?? await this;
//     return _analyzing(fromJson, result);
//   }
// }
//
// // 解析服务器返回的数据
// dynamic _analyzing<T>(FromJson<T> fromJson, ResponseAnalyzed result, {var listModel, PageModel? page}) {
//   if (result.success && result.data != null) {
//     // todo: 服务器返回的是一个字典对象
//     if (result.data is Map && (result.data as Map).isNotEmpty) {
//       final data = result.data as Map;
//       if (data.containsKey("pagination")) {
//         // todo: 解析分页的字典对象
//         return analyzingPageData(fromJson, result, listModel, page);
//       }else {
//         // todo: 解析字典对象
//         return analyzingDictionary(fromJson, result);
//       }
//     }
//     // todo: 服务器返回的是一个数组对象
//     if (result.data is List && (result.data as List).isNotEmpty) {
//       return analyzingArray(fromJson, result) ?? [];
//     }
//     // todo: 服务器返回的数据为空
//     if (result.data == null || result.data.isEmpty) {
//       logger.e("result.data = ${result.data} result.data is empty ");
//     }
//   }else {
//     return null;
//   }
// }
//
// // 解析服务器返回的字典对象
// dynamic analyzingDictionary<T>(FromJson<T> fromJson, ResponseAnalyzed result) {
//   if (result.success && result.data != null) {
//     if (result.data is Map && (result.data as Map).isNotEmpty) {
//       return fromJson(result.data);
//     }
//   }
//   return null;
// }
//
// // 解析服务器返回的数组对象
// // 返回的是一个 List<T>
// dynamic analyzingArray<T>(FromJson<T> fromJson, ResponseAnalyzed result) {
//   if (result.success && result.data != null) {
//     if (result.data is List && (result.data as List).isNotEmpty) {
//       return (result.data as List).map((i) => fromJson(i)).toList();
//     }
//   }
//   return [];
// }
//
// analyzingPageData<T>(FromJson<T> fromJson, ResponseAnalyzed result, var listModel, PageModel? page) {
//   if (result.success && result.data != null) {
//     if (result.data is Map && (result.data as Map).isNotEmpty) {
//       if (result.data.containsKey("pagination")) {
//         page = PageModel.fromJson(result.data);
//         if (page.dataList != null && page.dataList is List && (page.dataList as List).isNotEmpty) {
//           final list = (page.dataList as List).map((i) => fromJson(i)).toList();
//           if (page.pagination != null && page.pagination! <= 1) {
//             listModel.clear();
//           }
//           listModel.addAll(list);
//         }
//         // 服务器有时候不按标准执行，在不是上拉加载的时候返回了 20003
//         if (page.dataList.isEmpty || (page.pagination! <= 0 && result.noMoreData)) {
//           (listModel as List).clear();
//         }
//       }
//     }
//   }
//   return listModel;
// }
//
