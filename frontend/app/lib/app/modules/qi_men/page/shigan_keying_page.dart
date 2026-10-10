import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../../../utils/global.dart';

/// 十干克应详情页入参
class ShiGanKeyingArgs {
  const ShiGanKeyingArgs({
    required this.title,
    required this.description1,
    required this.description2,
  });

  final String title;
  final String description1;
  final String description2;
}

/// 十干克应详情页（对应安卓 ShiGanTextActivity）。
class ShiGanKeyingPage extends StatelessWidget {
  const ShiGanKeyingPage({super.key});

  @override
  Widget build(BuildContext context) {
    final args = Get.arguments as ShiGanKeyingArgs?;
    final title = args?.title ?? "时干克应";
    final description1 = args?.description1 ?? "";
    final description2 = args?.description2 ?? "";

    return Scaffold(
      backgroundColor: PageBackgroundColor,
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios, color: BGColor_white_255),
          onPressed: () => Get.back(),
        ),
        title: NavigatorTitle(title),
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(12.w),
        child: Container(
          width: double.infinity,
          padding: EdgeInsets.all(14.w),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(8),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(title, style: blackBoldStyle(font: 16)),
              SizedBox(height: 10.h),
              if (description1.isNotEmpty)
                Text(description1, style: blackStyle(font: 14)),
              if (description1.isNotEmpty && description2.isNotEmpty)
                SizedBox(height: 10.h),
              if (description2.isNotEmpty)
                Text(description2, style: blackStyle(font: 14)),
            ],
          ),
        ),
      ),
    );
  }
}
