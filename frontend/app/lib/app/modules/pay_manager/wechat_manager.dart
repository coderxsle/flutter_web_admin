import 'dart:async';
import 'dart:typed_data';

import 'package:auto_shop_server/common/index.dart';
import 'package:auto_shop_server/app/utils/image_tools.dart';
import 'package:fluwx/fluwx.dart';
import 'package:http/http.dart' as http;

import 'wechat_src/wechat_kit_platform_interface.dart';

export 'package:fluwx/fluwx.dart';

const String kWechatAppID = 'wx51abe0a3849b13a1';
// const String kWechatUniversalLink = 'https://api.ygxpt.com/autosteward/'; // iOS 请配置
const String kWechatUniversalLink = 'https://echelianapi.ygxpt.com/autosteward/'; // iOS 请配置

const String kWechatAppSecret = '';
const String kWechatMiniAppID = '';

typedef Callback = void Function(dynamic);

class WechatManager {
  // 静态变量，用于保存单例实例
  static final WechatManager _singleton = WechatManager._internal();
  // 公开的静态方法，用于获取单例实例
  static WechatManager get instance {
    return _singleton;
  }

  static late Function(WeChatResponse) listener;

  // 私有构造函数，只能在类内部被调用
  WechatManager._internal();

  dispose() {}

  // 微信环境检查
  static cacheWechat() async {
    final install = await Fluwx().isWeChatInstalled;
    if (install == false) {
      showMessage("请安装微信");
    }
  }

  // 注册微信
  register() {
    Fluwx().registerApi(appId: kWechatAppID, universalLink: kWechatUniversalLink).then((value) {
      if (value == true) {
        logger.i("微信SDK注册成功！");
      } else {
        logger.i("微信SDK注册失败！");
      }
    });
  }

  // 微信回调 - 冷启
  static handleInitial() {
    WechatKitPlatform.instance.handleInitialWXReq();
  }

  // 微信支付
  static Future<dynamic> wechatPay(var param, {Callback? result}) async {
    if (await cacheWechat() == false) {
      showMessage("请先安装微信");
      return;
    }
    // 添加订阅消息
    Fluwx().addSubscriber(listener = (response) {
      if (response is WeChatPaymentResponse) {
        // 调用传递的回调函数并传递 response
        if (result != null) {
          result(response);
        }
      }
      // 取消订阅消息
      Fluwx().removeSubscriber(listener);
    });
    Fluwx().pay(
        which: Payment(
      appId: param['appid'],
      partnerId: param['partnerid'],
      prepayId: param['prepayid'],
      packageValue: param['pkg'],
      nonceStr: param['noncestr'],
      timestamp: int.tryParse(param['timestamp']) ?? 0,
      sign: param['sign'],
    ));
  }

  // static shareText(WeChatScene scene, String text) {
  //   Fluwx().share(WeChatShareTextModel(text, scene: scene));
  // }

  // 文字分享 scene 0:聊天界面 1:朋友圈 2:收藏
  static Future<dynamic> shareTextMy(WeChatScene scene, String text) async {
    if (await cacheWechat() == false) {
      showMessage("请先安装微信");
      return;
    }
    Fluwx().share(WeChatShareTextModel(text, scene: scene)).then((value) {
      if (!ObjectUtil.isEmpty(value)) {
        if (value == true) {
          if (scene == WeChatScene.session) {
            // showMessageBottomLikeAndroid("分享成功", isLong: false);
          } else if (scene == WeChatScene.favorite) {
            // showMessageBottomLikeAndroid("收藏成功", isLong: false);
          }
        } else {
          if (scene == WeChatScene.session) {
            // showMessageBottomLikeAndroid("分享失败", isLong: false);
          } else if (scene == WeChatScene.favorite) {
            // showMessageBottomLikeAndroid("收藏失败", isLong: false);
          }
        }
      }
    });
  }

  // 网页分享 scene 0:聊天界面 1:朋友圈 2:收藏
  static Future<dynamic> shareWebpageMy(
    WeChatScene scene, {
    required String url,
    required String thumbnail,
    required String desc,
  }) async {
    if (await cacheWechat() == false) {
      showMessage("请先安装微信");
      return;
    }
    //final wechatImage = WeChatImage.network(thumbnail);
    //final model = WeChatShareWebPageModel(url, thumbData: thumbnail);
    if (scene == WeChatScene.session || scene == WeChatScene.timeline) {
      try {
        Uint8List? data = await fetchImageAsUint8List(thumbnail);
        if (!ObjectUtil.isEmpty(data)) {
          Uint8List? result = await ImageTool.compressImage(data!, width: 200, quality: 80);
          if (!ObjectUtil.isEmpty(result)) {
            WeChatShareWebPageModel model = WeChatShareWebPageModel(url, title: desc, scene: scene, thumbData: result);
            Fluwx().share(model);
          } else {
            WeChatShareWebPageModel model = WeChatShareWebPageModel(url, title: desc, scene: scene);
            Fluwx().share(model);
          }
        } else {
          WeChatShareWebPageModel model = WeChatShareWebPageModel(url, title: desc, scene: scene);
          Fluwx().share(model);
        }
      } on Exception catch (e) {
        if (!ObjectUtil.isEmpty(e)) {
          logger.w(" catch Exception =>${e.toString()}");
        }
      }
    } else if (scene == WeChatScene.favorite) {
      //微信收藏
      WeChatShareWebPageModel model = WeChatShareWebPageModel(url, title: desc, scene: scene);
      Fluwx().share(model);
    }
  }

  // 图片分享 scene 0:聊天界面 1:朋友圈 2:收藏
  static Future<dynamic> shareImageMy(WeChatScene scene, String url) async {
    if (await cacheWechat() == false) {
      showMessage("请先安装微信");
      return;
    }
    Uint8List? imageData = await fetchImageAsUint8List(url);
    //原始代码
    //final weChatImageToShare = WeChatImageToShare(uint8List: await fetchImageAsUint8List(url));
    //先查看图片的大小，如果大小超过600KB，那么分享图片链接？
    try {
      double imageSize = imageData!.lengthInBytes / 1024;
      bool isLargeImage = imageSize > 600;
      if(isLargeImage){
        imageData = ImageTool.compressImageMy(imageData, targetQuality: 0.9 );
        //logger.d("微信分享图片【原图】大小是-->${imageData!.lengthInBytes / 1024}");
      }
      //微信分享图片【原图】大小是-->786.5390625
    } on Exception catch (e) {
      if (!ObjectUtil.isEmpty(e)) logger.w("shareImageMy catch Exception =>${e.toString()}");
    }

    final weChatImageToShare = WeChatImageToShare(uint8List: imageData);
    WeChatShareImageModel weChatShareImageModel = WeChatShareImageModel(weChatImageToShare);
    Fluwx().share(weChatShareImageModel);
  }

  //仅仅是打开微信，不携带数据的
  static Future<dynamic> shareOpenWeChatApp() async {
    try {
      if (await cacheWechat() == false) {
        showMessage("请先安装微信");
        return;
      }

      Fluwx().open(target: WeChatApp());
    } on Exception catch (e) {
      if (!ObjectUtil.isEmpty(e)) {
        logger.w(" catch Exception =>${e.toString()}");
      }
    }
  }

  // 图片分享 scene 0:聊天界面 1:朋友圈 2:收藏
  // static shareImage(WeChatScene scene, String url) {
  //   Fluwx().share(WeChatShareImageModel(WeChatImage.network(url), scene: scene));
  // }

  // 网页分享 scene 0:聊天界面 1:朋友圈 2:收藏
  // static shareWebpage(WeChatScene scene, String url, String thumbnail, String desc) {
  //   Fluwx().share(WeChatShareWebPageModel(url, thumbnail: WeChatImage.network(thumbnail), description: desc, scene: scene));
  // }

  // 打开微信小程序
  static openMiniProgram(var url) async {
    if (await cacheWechat()) {
      var name = url.replaceAll("open.wechat://", "");
      Fluwx().open(target: MiniProgram(username: name));
    } else {
      showMessage("请先安装微信");
      return;
    }
  }

  //分享微信小程序卡片
  static openShareMiniProgram({
    required String webPageUrl,
    required String userName,
    required String title,
    required String path,
    required String description,
    required String thumbnail,
  }) async {
    try {
      if (await cacheWechat() == false) {
        showMessage("请先安装微信");
        return;
      }

      Uint8List? imageData = await fetchImageAsUint8List(thumbnail);
      if (!ObjectUtil.isEmpty(imageData)) {
        //TODO 2025/1/18 以下注释代码勿删！！！能查看图片原始大小
        // try {
        //   logger.d("小程序分享【原图】大小是-->${imageData!.lengthInBytes / 1024}");
        // } on Exception catch (e) {
        //   if (!ObjectUtil.isEmpty(e)) logger.w(" catch Exception =>${e.toString()}");
        // }

        //如果图片超过128KB需要压缩
        Uint8List? resultShare;
        bool result = ImageTool.isImageSmallerThan128KB(imageData!);
        if (result) {
          logger.i("小程序分享图--【小于】128KB--不执行压缩");
          resultShare = imageData;
        } else {
          logger.i("小程序分享图--【大于】128KB--即将执行压缩");
          resultShare = await ImageTool.compressImage(imageData, width: 300, quality: 92);

          //TODO 2025/1/18 注释代码勿删！！可以查看【压缩后】图片大小
          /*try {
            logger.d("小程序分享【压缩后】大小是-->${resultShare.lengthInBytes / 1024}");
          } on Exception catch (e) {
            if (!ObjectUtil.isEmpty(e)) logger.w(" catch Exception =>${e.toString()}");
          }*/
        }
        //指定大小和压缩率
        // resultShare = ImageTool.compressImageToSize(imageData!, 90 * 1024);
        if (!ObjectUtil.isEmpty(resultShare)) {
          logger.i("小程序分享走到--【正常】的压缩图片分享");
          var model = WeChatShareMiniProgramModel(
            webPageUrl: webPageUrl,
            userName: userName,
            title: title,
            path: path,
            description: description,
            thumbData: resultShare,
          );

          Fluwx().share(model);
        } else {
          logger.w("小程序分享走到--【异常】的压缩图片分享,那么再次  压缩更小，重试下");
          //如果正常的压缩是空，那么就走到这种肯定能分享出去的逻辑
          Uint8List? result = await ImageTool.compressImage(imageData, width: 200, quality: 80);
          var model = WeChatShareMiniProgramModel(
            // miniProgramType: WXMiniProgramType.preview,//测试时候使用预览版
            webPageUrl: webPageUrl,
            userName: userName,
            title: title,
            path: path,
            description: description,
            thumbData: result,
          );

          Fluwx().share(model);
        }
      } else {
        showMessageBottomLikeAndroid("缩略图是空值", isLong: true);
      }
    } on Exception catch (e) {
      if (!ObjectUtil.isEmpty(e)) {
        logger.w(" catch Exception =>${e.toString()}");
      }
    }
  }

  /*Future<Size> _getImageSize(Uint8List imageBytes) async {
    final Completer<Size> completer = Completer();
    // 使用ExtendedImage来加载图片，并在加载完成后获取其大小
    ExtendedImage.memory(imageBytes).loadImage().then((ExtendedImageState state) {
      // 获取图片的宽和高
      double width = state.imageSize.width;
      double height = state.imageSize.height;
      completer.complete(Size(width, height));
    }).catchError((error) {
      completer.completeError(error);
    });
    return completer.future;
  }
}*/

  //微信分享开发包fluwx给的方法
  static Future<Uint8List?> fetchImageAsUint8List(String imageUrl) async {
    try {
      final response = await http.get(Uri.parse(imageUrl));
      if (response.statusCode == 200) {
        logger.d('response to load image:200}');
        return response.bodyBytes;
      } else {
        //debugPrint('Failed to load image: ${response.statusCode}');
        logger.d('Failed to load image: ${response.statusCode}');
        showMessageBottomLikeAndroid(downShareImageOnFail, isLong: false);
        return null;
      }
    } catch (e) {
      //debugPrint('Error fetching image: $e');
      logger.d('Error fetching image: $e');
      return null;
    }
  }
}
