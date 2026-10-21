// ignore_for_file: must_be_immutable, library_private_types_in_public_api
import 'dart:async';

import 'package:easy_refresh/easy_refresh.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:tdesign_flutter/tdesign_flutter.dart';

import '../../theme/app_theme.dart';
import '../result_code.dart';

/// 按页面状态渲染：加载中 / 空数据 / 请求失败 / 成功，自带下拉刷新与上拉加载。
///
/// 必须放在 Column 里（内部返回 Expanded）。四种状态都可整体替换：
/// [skeleton] / [loadingView]、[emptyView]、[errorView]；也可只改文案和按钮。
class LayoutSubviews extends StatefulWidget {
  final Header? header;
  final Footer? footer;
  final EasyRefreshController? controller;
  String state = ResultCode.loading; //页面状态 默认为加载状态
  final Function()? onRefresh;
  final Function()? onLoad;

  /// 加载态：skeleton 优先于 loadingView，两者都没传才用默认的 TLoading
  Widget? skeleton; // 骨架视图（页面加载中显示）
  final Widget? loadingView;
  final String? loadingText;

  /// 空数据
  final String? emptyTip; // 空数据界面展示文字
  final Widget? emptyImage; // 传了就用图，不传走 emptyIcon
  final IconData? emptyIcon;
  final Widget? emptyView; // 整块替换空态
  final String? emptyActionText; // 传了 emptyRetry 才出按钮
  final Function()? emptyRetry;

  /// 请求失败
  final String? errorTip;
  final Widget? errorImage; // 传了就用图，不传走 errorIcon
  final IconData? errorIcon;
  final Widget? errorView; // 整块替换错误态
  final String? errorActionText;
  final Function()? onRetry;

  Widget? child; //成功视图

  LayoutSubviews({
    super.key,
    required this.state,
    this.child,
    this.skeleton,
    this.loadingView,
    this.loadingText,
    this.emptyView,
    this.emptyTip,
    this.emptyImage,
    this.emptyIcon,
    this.emptyActionText,
    this.emptyRetry,
    this.errorView,
    this.errorTip,
    this.errorImage,
    this.errorIcon,
    this.errorActionText,
    this.onRetry,
    this.controller,
    this.header,
    this.footer,
    this.onRefresh,
    this.onLoad,
  });

  @override
  _LoadStateLayoutState createState() => _LoadStateLayoutState();
}

class _LoadStateLayoutState extends State<LayoutSubviews> {
  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: EasyRefresh(
        header: widget.header ?? _header,
        footer: widget.footer ?? _footer,
        controller: widget.controller,
        onRefresh: widget.onRefresh,
        onLoad: widget.onLoad != null
            ? () {
                // 等下拉回弹完再拉数据，避免和下拉动画抢帧
                Future.delayed(const Duration(milliseconds: 500)).then((value) {
                  widget.onLoad!();
                });
              }
            : null,
        child: getSubViews,
      ),
    );
  }

  /// 默认下拉头：品牌红 + 中文文案，页面传了 header 就用页面的
  late final Header _header = ClassicHeader(
    iconTheme: const IconThemeData(color: TdColors.brand),
    textStyle: TextStyle(fontSize: 12.sp, color: TdColors.grey85),
    messageStyle: TextStyle(fontSize: 11.sp, color: TdColors.grey153),
    dragText: "下拉刷新",
    armedText: "释放立即刷新",
    readyText: "刷新中...",
    processingText: "刷新中...",
    processedText: "刷新完成",
    failedText: "刷新失败",
    messageText: "上次更新 %T",
  );

  late final Footer _footer = ClassicFooter(
    iconTheme: const IconThemeData(color: TdColors.brand),
    textStyle: TextStyle(fontSize: 12.sp, color: TdColors.grey85),
    messageStyle: TextStyle(fontSize: 11.sp, color: TdColors.grey153),
    dragText: "上拉加载",
    armedText: "释放立即加载",
    readyText: "加载中...",
    processingText: "加载中...",
    processedText: "加载完成",
    failedText: "加载失败",
    noMoreText: "没有更多了",
    messageText: "上次更新 %T",
  );

  Widget get getSubViews {
    if (widget.state == ResultCode.loading) {
      return widget.skeleton ?? widget.loadingView ?? _loadingView;
    }
    if (widget.state == ResultCode.error) {
      return widget.errorView ??
          _placeholder(
            icon: widget.errorIcon ?? Icons.wifi_off,
            image: widget.errorImage,
            text: widget.errorTip ?? "网络失败，请刷新重试！",
            actionText: widget.errorActionText ?? "重新加载",
            onAction: widget.onRetry,
            filled: true,
          );
    }
    if (widget.state == ResultCode.empty_data) {
      return widget.emptyView ??
          _placeholder(
            icon: widget.emptyIcon ?? Icons.inbox_outlined,
            image: widget.emptyImage,
            text: widget.emptyTip ?? "暂无内容",
            actionText: widget.emptyActionText,
            onAction: widget.emptyRetry,
          );
    }
    // widget.state == ResultCode.success / no_more_data
    return widget.child ?? const SizedBox.shrink();
  }

  Widget get _loadingView => _scrollable(TLoading(size: 20.w, text: widget.loadingText ?? "加载中..."));

  /// 空态与错误态共用：圆底图标（或页面传的图）+ 文案 + 按钮
  Widget _placeholder({
    required String text,
    required IconData icon,
    Widget? image,
    String? actionText,
    Function()? onAction,
    bool filled = false,
  }) {
    return _scrollable(
      Padding(
        padding: EdgeInsets.symmetric(horizontal: 24.w, vertical: 16.h),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            image ?? _iconBubble(icon),
            SizedBox(height: 12.h),
            Text(
              text,
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 14.sp, color: TdColors.grey153),
            ),
            if (actionText != null && onAction != null) ...[
              SizedBox(height: 16.h),
              _actionButton(actionText, onAction, filled: filled),
            ],
          ],
        ),
      ),
    );
  }

  /// 浅红圆底 + 品牌红图标，替代原来那两张蓝色插画
  Widget _iconBubble(IconData icon) {
    return Container(
      width: 56.w,
      height: 56.w,
      decoration: const BoxDecoration(color: TdColors.brandLight, shape: BoxShape.circle),
      child: Icon(icon, size: 26.w, color: TdColors.brand),
    );
  }

  Widget _actionButton(String text, Function() onTap, {required bool filled}) {
    return GestureDetector(
      onTap: () => onTap(),
      child: Container(
        height: 32.h,
        padding: EdgeInsets.symmetric(horizontal: 20.w),
        alignment: Alignment.center,
        decoration: BoxDecoration(
          color: filled ? TdColors.brand : TdColors.white,
          borderRadius: BorderRadius.circular(6),
          border: filled ? null : Border.all(color: TdColors.brand, width: 0.8),
        ),
        child: Text(
          text,
          style: TextStyle(fontSize: 13.sp, color: filled ? TdColors.white : TdColors.brand),
        ),
      ),
    );
  }

  /// 把内容撑到至少一屏并居中，这样内容不满屏也能下拉刷新
  Widget _scrollable(Widget child) {
    return LayoutBuilder(
      builder: (context, box) => SingleChildScrollView(
        physics: const AlwaysScrollableScrollPhysics(),
        child: ConstrainedBox(
          constraints: BoxConstraints(minHeight: box.hasBoundedHeight ? box.maxHeight : 0),
          child: Center(child: child),
        ),
      ),
    );
  }
}
