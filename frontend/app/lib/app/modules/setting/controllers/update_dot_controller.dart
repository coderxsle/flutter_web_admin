
import 'package:auto_shop_server/app/utils/result_code.dart';
import 'package:auto_shop_server/common/common_tools.dart';
import 'package:get/get.dart';
import 'package:http_manager/http_manager.dart';
import 'package:package_info_plus/package_info_plus.dart';

import '../../../utils/sring_utils.dart';
import '../../../utils/strings.dart';
import '../../launching/loacal_storage.dart';

//更新检测新版本的控制器-控制android端-检测新版本右侧的小红点
class UpdateDotController extends GetxController {
  //是否有新版本
  RxBool isHasUpdateInfo = false.obs;

  @override
  void onInit() {
    super.onInit();

    getConfig();
  }

  ///@description 系统配置接口
  Future<void> getConfig() async {
    var url = '/pub/v1/config/getConfig';
    final param = {"": ""};
    var response = await httpManager.postAnalyzing(url, params: param);
    if (response.success) {
      //Logger.logMy("$logCatTag systemConfigEntity：${response.toString()}");
      if (response.data is List<dynamic>) {
        for (var index = 0; index < response.data.length; ++index) {
          var element = response.data[index];
          if (element['key'] == app_update_android_download_url) {
            String downUrl = element["value"];
            //logger.d("$logCatTag downUrl：${downUrl.toString()}");
            localStorageWrite(app_update_android_download_url, downUrl);
            //String versionCurr = CommonTools.getServiceVersionCode(downUrl);
            //logger.d("$logCatTag versionCurr：${versionCurr.toString()}");
            hasUpdateInfo();
            break;
          }
        }
      }
    }
  }

  ///@description 检测是否有新版本
  void hasUpdateInfo() async {
    if (box.hasData(app_update_android_download_url)) {
      String? downLoadUrlCurr = localStorageRead<String>(app_update_android_download_url);
      // Logger.logMy("$logCatTag downLoadUrl：${downLoadUrlCurr.toString()}");
      if (downLoadUrlCurr is String) {
        if (!StringUtils.isNullOrEmpty(downLoadUrlCurr)) {
          //Future<PackageInfo> packageInfo = PackageInfo.fromPlatform();
          PackageInfo packageInfo = await PackageInfo.fromPlatform();
          String serviceVersion = CommonTools.getServiceVersionCode(downLoadUrlCurr);
          // Logger.logMy("$logCatTag serviceVersion：${serviceVersion.toString()}");
          if (!StringUtils.isNullOrEmpty(serviceVersion)) {
            if (int.parse(packageInfo.buildNumber) < int.parse(serviceVersion)) {
              //logger.d("发现-新版本");
              isHasUpdateInfo.value = true;
              update();
            } else {
              //logger.d("未发现-新版本");
              isHasUpdateInfo.value = false;
              update();
            }
          }
        }
      }
    }
  }
}
