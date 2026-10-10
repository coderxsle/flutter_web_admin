import 'package:flutter/cupertino.dart';

//宽高自适应
class HYSizeFit {
  static double screenWidth = 0.0;
  static double screenHeight = 0.0;

  static double physicalWidth = 0.0;
  static double physicalHeight = 0.0;
  static double dpr = 0.0;
  static double statusHeight = 0.0;

  static double rpx = 0.0;
  static double px = 0.0;

  BuildContext? mContext;

  HYSizeFit(this.mContext);

  void initialize({double standardSize = 750}) {
    // 1、手机的物理分辨率
    // physicalWidth = window.physicalSize.width;
    // physicalHeight = window.physicalSize.height;

    physicalWidth = MediaQuery.of(mContext!).size.width;
    physicalHeight = MediaQuery.of(mContext!).size.height;

    // 2、 获取dpr
    //dpr = window.devicePixelRatio;
    dpr = MediaQuery.of(mContext!).devicePixelRatio;

    // 3、宽度和高度
    screenWidth = physicalWidth / dpr;
    screenHeight = physicalHeight / dpr;

    // 4、 状态栏高度
    //statusHeight = window.padding.top / dpr;
    statusHeight = MediaQuery.of(mContext!).padding.top / dpr;

    // 5、计算 rpx 的大小
    rpx = screenWidth / standardSize;
    px = screenWidth / standardSize * 2;
  }

// 按照像素来设置
  static double setPx(double size) {
    return px * size;
  }

// 按照rpx来设置
  static double setRpx(double size) {
    return rpx * size;
  }
}
