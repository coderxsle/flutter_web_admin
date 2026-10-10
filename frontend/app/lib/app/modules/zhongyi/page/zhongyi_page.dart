import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../../../utils/global.dart';

/// 中医门诊（占位页），具体功能待接入。
class ZhongyiPage extends StatelessWidget {
  const ZhongyiPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: TdColors.pageBg,
      appBar: AppBar(
        // 作为底部 Tab 根页面时不显示返回
        leading: Navigator.canPop(context)
            ? IconButton(
                icon: const Icon(Icons.arrow_back_ios, color: TdColors.white),
                onPressed: () => Get.back(),
              )
            : null,
        title: const NavigatorTitle("中医门诊"),
      ),
      body: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Icon(Icons.medical_services_outlined,
                size: 48, color: TdColors.grey195),
            SizedBox(height: 12.h),
            Text("中医门诊功能建设中", style: greyStyle(font: 14)),
          ],
        ),
      ),
    );
  }
}
