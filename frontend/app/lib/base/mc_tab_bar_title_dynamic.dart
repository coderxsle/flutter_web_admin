import 'package:auto_shop_server/app/utils/strings.dart';
import 'package:common_utils/common_utils.dart';
import 'package:flutter/material.dart';

import '../app/theme/app_colors.dart';

typedef OnChanged<Map> = void Function(Map data);

///@description 选项卡之中的标题是动态改变的选项卡:在优惠券改动时，需要动态改变标题：例如【待审核（12），数字会跟随列表数量变化,导致整个选项卡都要动态变化】
///@updateTime 2024/10/10 9:41
class MCTabBarTitleDynamic extends StatefulWidget {
  final List<Map<String, dynamic>> rxListTabKeyValues;
  final OnChanged onChanged;

  const MCTabBarTitleDynamic({super.key, required this.rxListTabKeyValues, required this.onChanged});

  @override
  State<MCTabBarTitleDynamic> createState() => _MCTabBarTitleDynamicState();
}

class _MCTabBarTitleDynamicState extends State<MCTabBarTitleDynamic> with SingleTickerProviderStateMixin {
  late TabController _ctrl;
  var length = 0;

  @override
  void initState() {
    super.initState();

    if (!ObjectUtil.isEmptyList(widget.rxListTabKeyValues)) {
      length = widget.rxListTabKeyValues.length;
    }

    _ctrl = TabController(length: length, vsync: this)
      ..addListener(() {
        if (!_ctrl.indexIsChanging) {
          if (!ObjectUtil.isEmptyList(widget.rxListTabKeyValues)) {
            final mapIndex = widget.rxListTabKeyValues[_ctrl.index];
            widget.onChanged(mapIndex);
          }
          setState(() {});
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
      height: 40,
      decoration: const BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.all(Radius.circular(10)),
      ),
      child: TabBar(
        tabs: tabBars(),
        padding: EdgeInsets.zero,
        labelPadding: EdgeInsets.zero,
        controller: _ctrl,
        indicatorColor: ThemeColor,
        dividerColor: Colors.transparent,
      ),
    );
  }

  List<Widget> tabBars() {
    List<Widget> tabs = [];
    if (!ObjectUtil.isEmptyList(widget.rxListTabKeyValues)) {
      for (var mapDynamic in widget.rxListTabKeyValues) {
        tabs.add(Tab(child: Text(mapDynamic[typeTitle], style: const TextStyle(fontSize: 14, color: Colors.black))));
      }
    }
    return tabs;
  }
}
