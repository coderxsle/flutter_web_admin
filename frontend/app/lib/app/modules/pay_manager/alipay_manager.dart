
import 'package:tobias/tobias.dart';
import 'package:url_launcher/url_launcher_string.dart';

class AlipayManager {
  static final AlipayManager _singleton = AlipayManager._internal();
  static AlipayManager get instance {
    return _singleton;
  }
  AlipayManager._internal();


  // 支付宝环境检查
  static cacheAlipay() async {
    var result = await Tobias().isAliPayInstalled;
    if (result == false) {
      // showMessage("请安装支付宝App");
    }
  }

  // 支付宝支付
  static Future<String> alipay(String orderInfo) async {
    Tobias tobias = Tobias();
    final result = await tobias.pay(orderInfo);
    final status = result['resultStatus'];
    return status;
    /// 支付状态，参考支付宝的文档https://docs.open.alipay.com/204/105695/
    /// 返回码，标识支付状态，含义如下：
    /// 9000——订单支付成功         下面的result有值
    /// 8000——正在处理中
    /// 4000——订单支付失败
    /// 5000——重复请求
    /// 6001——用户中途取消
    /// 6002——网络连接出错
  }

  // 支付宝小程序
  static openMiniProgram(var url) async {
    //检测是否安装支付宝
    var result = await Tobias().isAliPayInstalled;
    if (!result) {
      // showMessage("请先安装支付宝");
      return;
    }else {
      if (await canLaunchUrlString(url)) {
        launchUrlString(url);
      }
    }
  }

}