import 'package:http_manager/http_manager.dart';

class HomeRequest {

  // 获取该用用户的所有店铺
  static Future<ResponseAnalyzed> getShopList() async {
    const url = "/auth/v1/actor/shopInfo/getShopInfoByCustomer";
    return await httpManager.postAnalyzing(url);
  }

  // 获取首页功能模块数据（根据用户角色）
  static Future<ResponseAnalyzed> getHomeData() async {
    const url = "/auth/v1/home/getAppHomeForManager";
    return await httpManager.postAnalyzing(url);
  }

  /// 扫码供电（喷涂预约）
  static Future<ResponseAnalyzed> updateForScanQrCode(var param) async {
    const url = "/auth/v1/spray/reservationsite/updateForScanQrCode";
    return await httpManager.postAnalyzing(url, params: param);
  }

}