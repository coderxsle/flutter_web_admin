import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ShapeRadiusContainer extends Container {
  final double? height;
  final BorderRadiusGeometry? borderRadius;
  ShapeRadiusContainer({super.key, this.height, super.decoration, this.borderRadius, super.color, super.margin, super.padding, required super.child});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: height,
      margin: margin??EdgeInsets.zero,
      padding: padding??EdgeInsets.zero,
      decoration: decoration??BoxDecoration(
        color: color??Colors.white,
        borderRadius: borderRadius??const BorderRadius.all(Radius.circular(10)),
        shape: BoxShape.rectangle,
        boxShadow: [
          BoxShadow(
            color: Colors.grey[200]!,
            offset: Offset(0, 0), // 设置阴影偏移量
            blurRadius: 6, // 设置阴影模糊程度
            spreadRadius: 0.3, // 设置阴影扩散程度
          ),
        ],
      ),
      child: child,
    );
  }
}

/*
  ListView.builder(
    itemCount: 20,
    itemBuilder: (context, index) {
      // 为每个 item 创建独立的 Controller
      final ItemController controller = Get.put(ItemController(), tag: '$index');
      return ItemWidget(index: index, controller: controller);
    },
  )
*/

// 定义一个简单的 Item Controller
abstract class BaseItemController extends GetxController {}

abstract class BaseItem extends StatelessWidget {
  final void Function()? onTap;
  const BaseItem({super.key, this.onTap});

}
