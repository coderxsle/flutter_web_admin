import 'package:auto_shop_server/app/utils/result_code.dart';
import 'package:auto_shop_server/common/index.dart';
import 'package:get/get.dart';

import '../http/message_request.dart';
import '../model/my_message_model.dart';

/// 消息列表
class MessageController extends BaseController {
  final models = <MyMessageModel>[].obs;

  @override
  void onInit() {
    super.onInit();
    requestDataList();
  }

  @override
  Future<void> onRefresh() async {
    await requestDataList(lastID: "0");
    super.onRefresh();
  }

  @override
  Future<void> onLoad() async {
    await requestDataList(lastID: models.last.notificationId!);
    super.onLoad();
  }

  requestDataList({String lastID = ""}) async {
    if (lastID.isEmpty || lastID == "0") {
      models.clear();
    }
    ResponseAnalyzed result = await requestMessageListData(notificationId: lastID);
    List<MyMessageModel> response = [];
    if (result.success) {
      if (!ObjectUtil.isEmpty(result.data)) {
        modelListAnalyzing(result, response, MyMessageModel.fromJson);
        models.addAll(response);
        recode.value = result.code!;
      } else {
        recode.value = result.code!;
      }
    } else {
      recode.value = result.code!;
      reCode10001(result);
    }
  }
}
