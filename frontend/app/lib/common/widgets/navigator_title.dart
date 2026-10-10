import 'package:auto_shop_server/common/widgets/remark_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:http_manager/http_manager.dart';

import '../../app/utils/common_widget/my_dialog.dart';

class NavigatorTitle extends StatefulWidget {
  final String? title;
  final Color? color;
  const NavigatorTitle(this.title, {super.key, this.color});
  @override
  State<NavigatorTitle> createState() => _NavigatorTitleState();
}
class _NavigatorTitleState extends State<NavigatorTitle> {
  int _tapCount = 0;
  DateTime? _lastTapTime;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
        onTap: () {
          final now = DateTime.now();
          if (_lastTapTime == null || now.difference(_lastTapTime!).inMilliseconds > 500) {
            _tapCount = 1; // 重置为第一次点击
          } else {
            _tapCount++;
          }
          _lastTapTime = now;
          if (_tapCount == 10) {
            _tapCount = 0; // 重置点击次数
            final hostVC = TextEditingController(text: "192.168.");
            final portVC = TextEditingController(text: "8888");
            showAlertDialog(
                title: "请输入代理",
                content: Column(
                  children: [
                    RemarkView(title: "", controller: hostVC, height: 32, hintText: "请输入代理地址", bgColor: Colors.grey[100]),
                    const SizedBox(height: 10),
                    RemarkView(title: "", controller: portVC, height: 32, hintText: "请输入端口号", bgColor: Colors.grey[100]),
                  ],
                ),
                confirm: () async {
                  httpManager.setProxy(host: hostVC.text, port: portVC.text);
                  showMessage("代理设置成功");
                  dismissAlertDialog();
                },
                confirmText: "开启联机",
                cancelText: "关闭代理",
                cancel: () {
                  httpManager.setProxy();
                  dismissAlertDialog();
                }
            );
          }
        },
        child: Container(
          color: Colors.transparent,
          padding: const EdgeInsets.fromLTRB(10, 10, 10, 10),
          child: Text(widget.title??"", style: TextStyle(fontSize: 16.h, color: widget.color, fontWeight: FontWeight.w600))
        )
    );
  }
}