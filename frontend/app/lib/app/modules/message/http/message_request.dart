import 'package:http_manager/http_manager.dart';

/// 我的 - 我的消息
 Future<ResponseAnalyzed> requestMessageListData({String notificationId = ""}) async {
  String url =  "/auth/v1/notification/getAppNotificationPage";
  Map<String, dynamic> data = {"notificationId" : notificationId};
  // ResponseAnalyzed result = await ResponseAnalyzed.analyzingAndCheckup(response);
  // if (result.data is List && result.data!.isNotEmpty) {
  //   List list = (result.data as List).map((i) => MyMessageModel.fromJson(i)).toList();
  //   result = ResponseAnalyzed(code: result.code, data: list, message: result.message);
  // }
  return await httpManager.postAnalyzing(url, params: data);
}