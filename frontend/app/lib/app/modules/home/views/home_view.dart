import 'package:auto_shop_server/app/routes/app_pages.dart';
import 'package:auto_shop_server/app/utils/global.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

/// 首页：周易排盘入口。
class HomeView extends StatelessWidget {
  const HomeView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: PageBackgroundColor,
      appBar: AppBar(
        // 作为底部 Tab 根页面时不显示返回
        leading: Navigator.canPop(context)
            ? IconButton(
                icon: const Icon(Icons.arrow_back_ios, color: BGColor_white_255),
                onPressed: () => Get.back(),
              )
            : null,
        title: const NavigatorTitle("首页"),
      ),
      body: ListView(
        padding: EdgeInsets.fromLTRB(12.w, 12.h, 12.w, 12.h),
        children: [
          _entryCard(
            icon: Icons.grid_view_rounded,
            title: "奇门遁甲排盘",
            subtitle: "时家奇门 · 拆补 / 置闰 · 九宫盘面",
            onTap: () => Get.toNamed(Routes.QIMENPAGE),
          ),
          SizedBox(height: 10.h),
          _entryCard(
            icon: Icons.calendar_month_rounded,
            title: "四柱八字排盘",
            subtitle: "四柱干支 · 十神藏干 · 大运流年",
            onTap: () => Get.toNamed(Routes.BAZIPAGE),
          ),
        ],
      ),
    );
  }

  Widget _entryCard({
    required IconData icon,
    required String title,
    required String subtitle,
    required VoidCallback onTap,
  }) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(8),
      ),
      clipBehavior: Clip.antiAlias,
      child: InkWell(
        onTap: onTap,
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 14.w, vertical: 16.h),
          child: Row(
            children: [
              Container(
                width: 42.w,
                height: 42.w,
                decoration: BoxDecoration(
                  color: BGColor_red_253_232_232,
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Icon(icon, size: 24.w, color: ThemeColor),
              ),
              SizedBox(width: 12.w),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(title, style: blackBoldStyle(font: 16)),
                    SizedBox(height: 3.h),
                    Text(subtitle, style: greyStyle(font: 12.5)),
                  ],
                ),
              ),
              const Icon(
                Icons.arrow_forward_ios,
                size: 14,
                color: Font_Color_grey_195,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
