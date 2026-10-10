import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../app/theme/app_theme.dart';

typedef OnChanged<T> = void Function(T data);

class MCTabBar extends StatefulWidget {
  late List<String>? tabNames;
  late Map<String, dynamic>? tabKeyValues;
  OnChanged onChanged;
  String type = "";
  bool? indicator;

  MCTabBar({super.key, this.tabNames, this.tabKeyValues, required this.onChanged, this.type = ""});

  @override
  State<MCTabBar> createState() => _MCTabBarState();
}

class _MCTabBarState extends State<MCTabBar> with SingleTickerProviderStateMixin {
  late TabController _ctrl;
  var length = 0;
  List<String> allKeys = [];

  @override
  void initState() {
    super.initState();
    
    if (widget.tabNames != null) {
      length = widget.tabNames!.length;
    }else if (widget.tabKeyValues != null) {
      length = widget.tabKeyValues!.length;
      for (var title in widget.tabKeyValues!.keys) {
        allKeys.add(title);
      }
    }
    _ctrl = TabController(length: length, vsync: this)..addListener(() {
      if (!_ctrl.indexIsChanging) {
        if (widget.tabNames != null) {
          widget.onChanged(_ctrl.index);
        }else if (widget.tabKeyValues != null) {
          final key = allKeys[_ctrl.index];
          widget.onChanged(widget.tabKeyValues?[key]);
        }
        setState((){ });
      }
    });
  }

  @override
  void dispose() {
    _ctrl.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 40.h,
      decoration: const BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.all(Radius.circular(6)),
      ),
      child: TabBar(
        tabs: tabBars(),
        padding: EdgeInsets.zero,
        labelPadding: EdgeInsets.zero,
        controller: _ctrl,
        indicatorColor: TdColors.brand,
        dividerColor: Colors.transparent,
      ),
    );
  }

  List<Widget> tabBars() {
    List<Widget> tabs = [];
    if (widget.tabNames != null) {
      for (var title in widget.tabNames!) {
        tabs.add(
          Tab(child: Text(title, style: TextStyle(fontSize: 14.sp, color: Colors.black)))
        );
      }
    }else if (widget.tabKeyValues != null) {
      for (var title in widget.tabKeyValues!.keys) {
        tabs.add(
          Tab(
            child: Text(title, style: TextStyle(fontSize: 14.sp, color: Colors.black))
          )
        );
      }
    }
    return tabs;
  }
}