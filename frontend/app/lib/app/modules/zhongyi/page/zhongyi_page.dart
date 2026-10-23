import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../../../routes/app_pages.dart';
import '../../../utils/app_manager.dart';
import '../../../utils/global.dart';

/// 中药房工作台：中医 Tab 的落地页。
///
/// 版式对齐参考实现的【工作台】：顶部一张 hero 卡交代模块定位，下面按模块
/// 列出入口卡，点进去才是各模块自己的列表 / 表单页。
class ZhongyiPage extends StatelessWidget {
  const ZhongyiPage({super.key});

  @override
  Widget build(BuildContext context) {
    final allowed = AppManager.permissions.any(
      (code) => code.startsWith('zhongyi:') || code.startsWith('menu:zhongyi:'),
    );
    if (!allowed) {
      return Scaffold(
        appBar: AppBar(title: const NavigatorTitle("中药房")),
        body: const Center(child: Text('无中医模块权限')),
      );
    }
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
        title: const NavigatorTitle("中药房"),
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.fromLTRB(12.w, 12.h, 12.w, 20.h + MediaQuery.paddingOf(context).bottom),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            const _HeroCard(),
            SizedBox(height: 12.h),
            for (final module in _modules) _ModuleTile(module),
          ],
        ),
      ),
    );
  }
}

/// 工作台模块入口定义，新增模块时只改这里。
class ZhongyiModuleEntry {
  const ZhongyiModuleEntry({
    required this.name,
    required this.desc,
    required this.icon,
    required this.route,
    this.primary = false,
  });

  final String name;
  final String desc;
  final IconData icon;
  final String route;

  /// 主入口用品牌色描边突出，对应参考页面的「开方结算」。
  final bool primary;
}

const List<ZhongyiModuleEntry> _modules = [
  ZhongyiModuleEntry(
    name: '开方结算',
    desc: '选药计价，生成账单',
    icon: Icons.edit_note_outlined,
    route: Routes.ZHONGYIPRESCRIBEPAGE,
    primary: true,
  ),
  ZhongyiModuleEntry(
      name: '药品库存', desc: '维护药品、批次与价格', icon: Icons.inventory_2_outlined, route: Routes.ZHONGYIMEDICINEPAGE),
  ZhongyiModuleEntry(
      name: '处方模板', desc: '管理常用方和默认剂数', icon: Icons.list_alt_outlined, route: Routes.ZHONGYITEMPLATEPAGE),
  ZhongyiModuleEntry(
      name: '结算记录', desc: '查看账单状态与明细', icon: Icons.receipt_long_outlined, route: Routes.ZHONGYIBILLINGPAGE),
];

class _HeroCard extends StatelessWidget {
  const _HeroCard();

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(16.w),
      decoration: BoxDecoration(color: TdColors.white, borderRadius: BorderRadius.circular(12.w)),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text("中药房工作台", style: blackBoldStyle(font: 19.sp)),
                SizedBox(height: 5.h),
                Text("管理药品库存、常用方与结算记录，快速完成日常开方调剂。", style: greyStyle()),
              ],
            ),
          ),
          SizedBox(width: 12.w),
          Container(
            width: 38.w,
            height: 38.w,
            decoration: BoxDecoration(color: TdColors.brandLight, borderRadius: BorderRadius.circular(10.w)),
            child: Icon(Icons.storefront_outlined, size: 22.w, color: TdColors.brand),
          ),
        ],
      ),
    );
  }
}

class _ModuleTile extends StatelessWidget {
  const _ModuleTile(this.module);

  final ZhongyiModuleEntry module;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      behavior: HitTestBehavior.opaque,
      onTap: () => Get.toNamed(module.route),
      child: Container(
        margin: EdgeInsets.only(bottom: 10.h),
        padding: EdgeInsets.all(14.w),
        decoration: BoxDecoration(
          color: TdColors.white,
          borderRadius: BorderRadius.circular(12.w),
          border: module.primary ? Border.all(color: TdColors.brandLight, width: 1.w) : null,
        ),
        child: Row(
          children: [
            Container(
              width: 34.w,
              height: 34.w,
              decoration: BoxDecoration(color: TdColors.brandLight, borderRadius: BorderRadius.circular(9.w)),
              child: Icon(module.icon, size: 20.w, color: TdColors.brand),
            ),
            SizedBox(width: 10.w),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(module.name, style: blackBoldStyle(font: 16.sp)),
                  SizedBox(height: 3.h),
                  Text(module.desc, style: greyStyle(), maxLines: 1, overflow: TextOverflow.ellipsis),
                ],
              ),
            ),
            SizedBox(width: 8.w),
            Icon(Icons.chevron_right, size: 18.w, color: TdColors.grey195),
          ],
        ),
      ),
    );
  }
}
