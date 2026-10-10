import 'package:auto_shop_server/app/modules/message/model/jump_app_message.dart';
import 'package:auto_shop_server/app/modules/message/model/my_message_model.dart';
import 'package:auto_shop_server/common/index.dart';
import 'package:auto_shop_server/common/widgets/column_with_size_min.dart';
import 'package:auto_shop_server/common/widgets/container_with_radius.dart';
import 'package:auto_shop_server/common/widgets/item_wrap_widget_with_click.dart';
import 'package:auto_shop_server/common/widgets/row_main_align_end.dart';
import 'package:auto_shop_server/common/widgets/web_view/web_view_page.dart';
import 'package:get/get.dart';
import 'package:tdesign_flutter/tdesign_flutter.dart';

import '../../../utils/global.dart';
import '../controller/message_controller.dart';

class MessageBinding extends Binding {
  @override
  List<Bind> dependencies() => [
        // autoRemove:false —— 与旧 Get.lazyPut 一致：注册后不随路由销毁
        Bind<MessageController>.builder(
          create: (_) => MessageController(),
          autoRemove: false,
        ),
      ];
}

class MessagePage extends GetView<MessageController> {
  const MessagePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        // 作为底部 Tab 根页面时不显示返回
        leading: Navigator.canPop(context)
            ? IconButton(
                icon: const Icon(Icons.arrow_back_ios, color: TdColors.white),
                onPressed: () => Get.back(),
              )
            : null,
        title: const NavigatorTitle("我的消息"),
      ),
      body: Column(
        children: [
          Obx(() => buildLoadingView()),
        ],
      ),
    );
  }

  Widget buildLoadingView() {
    return LayoutSubviews(
      state: controller.recode.value,
      onRefresh: controller.onRefresh,
      onLoad: controller.onLoad,
      controller: controller.refreshCtrl,
      child: _buildListView(),
    );
  }

  Widget _buildListView() {
    return ListView.builder(
      padding: const EdgeInsets.fromLTRB(0, 0, 0, 0),
      itemCount: controller.models.length,
      itemBuilder: (context, index) {
        MyMessageModel item = controller.models[index];

        // 有原生跳转标识或外部链接时才展示【查看详情】
        bool isShowLinkClick = false;
        String? urlApp = item.urlApp;
        if (!ObjectUtil.isEmpty(urlApp)) {
          JumpAppMessage? jumpAppMessage = JsonUtil.getObj(urlApp, (v) => JumpAppMessage.fromJson(v as Map<String, dynamic>));
          if (!ObjectUtil.isEmpty(jumpAppMessage)) {
            isShowLinkClick = true;
          }
        }
        String? currUrl = item.url;
        if (!ObjectUtil.isEmptyString(currUrl)) {
          isShowLinkClick = true;
        }

        /// 消息点击：优先按 urlApp 里的 jumpApp 跳原生页面，其次打开 url 网页。
        /// 新业务的跳转分支在此扩展，跳转目标需在 AppPages.routes 中注册。
        void clickLink() {
          String? urlApp = item.urlApp;
          if (!ObjectUtil.isEmptyString(urlApp)) {
            JumpAppMessage? jumpAppMessage = JsonUtil.getObj(urlApp, (v) => JumpAppMessage.fromJson(v as Map<String, dynamic>));
            String? jumpApp = jumpAppMessage?.jumpApp;
            if (!ObjectUtil.isEmptyString(jumpApp)) {
              String page = jumpApp!.startsWith("/") ? jumpApp : "/$jumpApp";
              if (AppPages.routes.any((route) => route.name == page)) {
                Get.toNamed(page, arguments: item.paramsApp);
              } else {
                logger.d("消息跳转的页面未注册：$page");
                showMessage("该功能正在开发中...");
              }
              return;
            }
          }
          if (!ObjectUtil.isEmptyString(currUrl) && currUrl!.startsWith("http")) {
            Get.to(() => WebViewPage(url: currUrl!));
          } else {
            logger.d("消息链接是空，不能点击");
          }
        }

        itemContent() {
          StringBuffer stringBuffer = StringBuffer();
          stringBuffer.write(controller.models[index].title ?? "标题");
          stringBuffer.write("\n");
          stringBuffer.write(controller.models[index].content ?? "暂无内容");
          stringBuffer.write("\n");
          stringBuffer.write(controller.models[index].createTime ?? DateUtil.getNowDateStr());

          return ColumnWithSizeMin(
            children: [
              const SizedBox(height: 6),
              Container(
                alignment: Alignment.centerLeft,
                child: Text(controller.models[index].title ?? "标题", style: blackBoldStyle(font: 14)),
              ),
              const SizedBox(height: 4),
              Container(
                alignment: Alignment.centerLeft,
                padding: const EdgeInsets.fromLTRB(0, 0, 5, 0),
                child: Text(
                  controller.models[index].content ?? "暂无内容",
                  style: const TextStyle(fontSize: 14, color: Colors.black),
                ),
              ),
              Container(
                  color: TStyleResolver.of(context).token.whiteColor1,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Container(
                        alignment: Alignment.centerLeft,
                        padding: const EdgeInsets.fromLTRB(0, 4, 5, 0),
                        child: Text(controller.models[index].createTime ?? DateUtil.getNowDateStr(), style: greyStyle85()),
                      ),
                      Visibility(
                        visible: isShowLinkClick,
                        child: Padding(
                          padding: const EdgeInsets.only(right: 10),
                          child: TLink(
                            colorPreset: TLinkColorPreset.success,
                            size: TLinkSize.small,
                            onPressed: clickLink,
                            child: const Text('查看详情', style: TextStyle(color: Colors.blue)),
                          ),
                        ),
                      ),
                    ],
                  )),
              RowMainAlignEnd(
                children: [
                  RowMainAlignEnd(
                    children: [
                      ItemWrapWidgetWithClick(
                        text: "复制消息",
                        borderColor: Colors.grey[400]!,
                        paddingMy: const EdgeInsets.fromLTRB(7, 2, 7, 3),
                        textStyleMy: blackStyle(font: font_12),
                        clickSate: false,
                        index: 0,
                        onTap: () => CommonTools.copyClipboard(stringBuffer.toString()),
                      ),
                    ],
                  ),
                ],
              ),
            ],
          );
        }

        return InkWell(
          splashColor: Colors.transparent, // 去除水波纹效果
          highlightColor: Colors.transparent, // 去除点击时的高亮颜色
          onTap: () {
            clickLink();
          },
          child: ContainerWithRadius(
            margin: const EdgeInsets.fromLTRB(6, 6, 6, 0),
            child: itemContent(),
          ),
        );
      },
    );
  }
}
