import 'package:auto_shop_server/base/screen_adapter.dart';
import 'package:auto_shop_server/common/index.dart';
import 'package:auto_shop_server/res/assets_res.dart';
import 'package:auto_shop_server/common/widgets/web_view/web_view_page.dart';
import 'package:auto_shop_server/app/routes/app_pages.dart';
import 'package:get/get.dart';

import '../../home/models/home_page_model.dart';
import '../../../utils/global.dart';

class MinePage extends StatefulWidget {
  const MinePage({super.key});

  @override
  _MinePageState createState() => _MinePageState();
}

class _MinePageState extends State<MinePage> {
  String _imageUrl = ''; // 账号未就绪或没头像时为空串，交给 imageNetwork 的 failed 兜底

  @override
  void initState() {
    super.initState();
    _imageUrl = AppManager.userAccount?.photoUrl ?? '';
  }

  Widget setupUserImageAndName() {
    return GestureDetector(
      onTap: (){
        Get.toNamed('/MyInfoPage')?.then((value) {
          _imageUrl = AppManager.userAccount?.photoUrl ?? '';
          setState(() {});
        });
      },
      child: Row(
        children: [
          ClipOval(
            child: imageNetwork(_imageUrl, failed: AssetsRes.FACEID_IMAGE, width: 64, height: 64, fit: BoxFit.cover),
          ),
        ],
      ),
    );

  }

  // 在首页下发的权限列表里取对应条目，有 url 就打开网页
  void openPurview(String purviewCode, String purviewName) {
    final appPurviewList = Get.arguments;
    if (appPurviewList is! List) {
      showMessage("该功能正在开发中...");
      return;
    }
    for (HomePageModelAppPurviewList model in appPurviewList) {
      if (model.purviewCode == purviewCode || model.purviewName == purviewName) {
        final url = model.url ?? "";
        if (url.isEmpty) {
          showMessage("该功能正在开发中...");
        } else {
          Get.to(() => WebViewPage(url: url, title: purviewName));
        }
        return;
      }
    }
    showMessage("该功能正在开发中...");
  }

  Widget topView() {
    return Container(
      decoration: const BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.all(Radius.circular(8.0)),
      ),
      padding: const EdgeInsets.fromLTRB(0, 16, 0, 16),
      child: Column(
        children: [
          Row(
            children: [
                Visibility(
                  visible: (Platform.isIOS),
                  child: buildItem(AssetsRes.PERSONAL_DINGDAN, "商品订单", () {
                    openPurview("204", "商品订单");
                  }),
                ),
                buildItem(AssetsRes.PERSONAL_HUIYUAN, "会员管理", () {
                  openPurview("207", "会员管理");
                }),
                buildItem(AssetsRes.LIAO_BA, "我的消息", () {
                  Get.toNamed("/MessagePage");
                }),
            ],
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: TdColors.pageBg,
      child: Stack(
        alignment: const Alignment(0, 0),
        children: [

          // 头部背景
          const Positioned(
            left: 0, top: 0, right: 0,
            child: Image(image: AssetImage(AssetsRes.HOME_NAVIGATION), fit: BoxFit.fitWidth)
          ),

          // 返回按钮（作为底部 Tab 根页面时不显示）
          if (Navigator.canPop(context))
            Positioned(
              left: 5, top: 50,
              child: IconButton(
                icon: const Icon(Icons.arrow_back_ios, color: TdColors.white),
                onPressed: () => Get.back(),
              ),
            ),

          // 设置按钮
          Positioned(
            top: 58, right: 15,
            child: GestureDetector(
              onTap: () => Get.toNamed("/SettingPage"),
              child: const SizedBox(
              height: 30, width: 30,
              child: Image(image: AssetImage(AssetsRes.PERSONAL_SET), fit: BoxFit.contain)),
            ),
          ),

          Positioned(
            top: ScreenAdapter.height(60),
            child: setupUserImageAndName(),
          ),

          Positioned(
            left: 10, top: ScreenAdapter.height(136), right: 10,
            child: Container(
              alignment: Alignment.center,
              child: Column(
                children: [
                  topView(),
                  const SizedBox(height: 15),
                  Container(
                    decoration: const BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.all(Radius.circular(8.0)),
                    ),
                    padding: const EdgeInsets.fromLTRB(0, 14, 0, 14),
                    child: managerHelp(context), // 管理帮助
                  ),
                ],
              ),
            ),
          ),
        ],
      ));
  }
  // 管理帮助
  managerHelp(BuildContext context) {
    return Column(
      children: [
        Container(
          alignment: Alignment.centerLeft,
          padding: const EdgeInsets.fromLTRB(13, 0, 13, 20),
          child: const Text("管理帮助",
            style: TextStyle(
                fontSize: 16, color: Colors.black, fontWeight: FontWeight.w500),
          ),
        ), // 管理帮助
        Column(
          children: [
            Row(
              children: [
                // 账号安全
                buildItem(AssetsRes.ACCOUNT_SECURITY, "账号安全", () {
                  Get.toNamed(Routes.ACCOUNTSECURITYPAGE);
                }),
                buildItem(AssetsRes.PERSONAL_HELP, "帮助中心", () {
                  Get.to(()=> const WebViewPage(url: "https://echelianhtml.ygxpt.com/help", title: "帮助中心"));
                }),
                buildItem(AssetsRes.HOME_PROPERTY_REPAIR, "设置", () {
                  Get.toNamed(Routes.SETTINGPAGE);
                }),
              ],
            ),
            const SizedBox(height: 10,),
          ],
        ),
      ],
    );
  }

}

Widget buildItem(String imageName, String title, GestureTapCallback? onTap) {
  return Expanded(
    child: GestureDetector(
      behavior: HitTestBehavior.opaque,
      onTap: onTap,
      child: Column(
        children: [
          Container(
            height: 35,
            width: 35,
            padding: const EdgeInsets.all(0),
            child: imageName.isEmpty ? const SizedBox(height: 1) : Image(
              image: AssetImage(imageName),
              fit: BoxFit.contain,
            ),
          ),
          const SizedBox(
            height: 8,
          ),
          Text(
            title,
            style: const TextStyle(fontSize: 16, color: Color.fromRGBO(85, 85, 85, 1)),
          )
        ],
      ),
    ),
  );
}

