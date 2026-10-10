import 'package:flutter/material.dart';

///@description 一个带有通知数字的小红点：目前只有一个用在【设置--检测新版本】地方
class DotWidget extends StatelessWidget {
  final String textNumber;
  final double? height;
  final double? width;
  final double? fontSize; //字号
  final EdgeInsets? padding;
  final BorderRadiusGeometry? borderRadius;
  final MaterialColor? color;
  const DotWidget({
    super.key,
    required this.textNumber,
    this.height,
    this.width,
    this.padding,
    this.fontSize,
    this.borderRadius,
    this.color,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: height ?? 16.0,
      width: width ?? 16.0,
      //padding: EdgeInsets.all(1.0),
      padding: padding ?? EdgeInsets.fromLTRB(2, 2, 2, 4),
      decoration: BoxDecoration(
        color: color ?? Colors.red,
        borderRadius: borderRadius ?? BorderRadius.circular(8.0),
      ),
      constraints: BoxConstraints(
        minWidth: 16.0,
        minHeight: 16.0,
      ),
      child: Center(
        child: Text(
          textNumber,
          style: TextStyle(
            color: Colors.white,
            fontSize: fontSize ?? 10.0,
          ),
          textAlign: TextAlign.center,
        ),
      ),
    );

    /*Stack(
      alignment: Alignment.center,
      children: <Widget>[
        // 主体图标
        Icon(Icons.notifications, size: 20.0, color: Colors.grey),
        // Text(""),
        Positioned(
          top: 0.0,
          right: 0.0,
          child: Container(
            padding: EdgeInsets.all(2.0),
            decoration: BoxDecoration(
              color: Colors.red,
              borderRadius: BorderRadius.circular(10.0),
            ),
            constraints: BoxConstraints(
              minWidth: 16.0,
              minHeight: 16.0,
            ),
            child: Text(
              '1',
              style: TextStyle(
                color: Colors.white,
                fontSize: 12.0,
              ),
              textAlign: TextAlign.center,
            ),
          ),
        ),
      ],
    )*/
  }
}




