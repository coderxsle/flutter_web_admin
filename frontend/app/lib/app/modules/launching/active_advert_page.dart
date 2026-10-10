import 'package:auto_shop_server/app/utils/app_manager.dart';
import 'package:flutter/material.dart';


class ActiveAdvertPage extends StatefulWidget {
  final Widget? child;
  const ActiveAdvertPage({super.key, this.child});

  @override
  State<ActiveAdvertPage> createState() => _ActiveAdvertPageState();
}

class _ActiveAdvertPageState extends State<ActiveAdvertPage> {
  @override
  Widget build(BuildContext context) {
    return Container(
        color: Colors.white,
        child: Stack(
          fit: StackFit.expand,
          children: [
            // 多张图片需要切换 未完成
            Image(
                image: NetworkImage(
                    AppManager.activeAdvert!.picUrls!.first.picUrlAll!),
                fit: BoxFit.cover),
            Align(
              alignment: Alignment.topRight,
              child: Container(
                margin: const EdgeInsets.only(top: 88, right: 20),
                child: ElevatedButton(
                    child: const Text('立即体验', style: TextStyle(fontSize: 16.0)),
                    onPressed: () {}),
              ),
            ),
          ],
        ));
  }
}
