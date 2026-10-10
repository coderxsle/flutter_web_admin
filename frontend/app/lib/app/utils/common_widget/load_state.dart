// ignore_for_file: must_be_immutable, library_private_types_in_public_api
import 'dart:async';

import 'package:auto_shop_server/res/assets_res.dart';
import 'package:easy_refresh/easy_refresh.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

import '../result_code.dart';

/// 根据不同状态来展示不同的视图
class LayoutSubviews extends StatefulWidget {
  final Header? header;
  final Footer? footer;
  final EasyRefreshController? controller;
  String state = ResultCode.loading; //页面状态 默认为加载状态
  final Function()? emptyRetry; // 空数据事件处理
  final Function()? onRefresh;
  final Function()? onLoad;
  final String? emptyTip; // 空数据界面展示文字
  Widget? child; //成功视图
  Widget? skeleton; // 骨架视图（页面加载中显示）

  LayoutSubviews({super.key, required this.state, this.child, this.skeleton, this.emptyRetry, this.controller, this.header, this.footer, this.onRefresh, this.onLoad, this.emptyTip});
  @override
  _LoadStateLayoutState createState() => _LoadStateLayoutState();
}

class _LoadStateLayoutState extends State<LayoutSubviews> {
  late EasyRefresh _refresh;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: EasyRefresh(
        header: widget.header,
        footer: widget.footer,
        controller: widget.controller,
        onRefresh: widget.onRefresh,
        onLoad: widget.onLoad!=null ? () {
          if (widget.onLoad != null) {
            Future.delayed(const Duration(milliseconds: 500)).then((value){
              widget.onLoad!();
            });
          }
        } : null,
        child: getSubViews,
      ),
    );
  }


  Widget? get getSubViews {
    if (widget.state == ResultCode.loading) {
      return widget.skeleton ?? _loadingView;
    }else if (widget.state == ResultCode.error) {
      return _emptyView("网络失败，请刷新重试！", "no_internet.png");
    }else if (widget.state == ResultCode.empty_data) {
      return _emptyView(widget.emptyTip ?? "暂无内容，请刷新重试！", AssetsRes.EMPTY_DATA);
    } else {
      // widget.state == ResultCode.success
      // widget.state == ResultCode.no_more_data
      return widget.child;
    }
  }

  Widget? get _loadingView {
    return ListView(
      children: [
        SizedBox(
          height: MediaQuery.of(context).size.height-270,
          child: const SpinKitCircle(color: Colors.blueAccent),
        ),
      ],
    );
  }

  Widget _emptyView(var text, var img) {
    return ListView(
      children: [
        SizedBox(
          height: MediaQuery.of(context).size.height-270,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset(img),
              const SizedBox(height: 15),
              Text(text, style: const TextStyle(color: Colors.black45, fontSize: 16),),
            ],
          ),
        ),
      ],
    );
  }
}