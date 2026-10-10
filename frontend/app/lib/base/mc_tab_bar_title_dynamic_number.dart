import 'package:auto_shop_server/app/utils/strings.dart';
import 'package:auto_shop_server/common/widgets/row_main_align_center.dart';
import 'package:auto_shop_server/common/widgets/row_main_align_start.dart';
import 'package:common_utils/common_utils.dart';
import 'package:flutter/material.dart';

import '../app/theme/app_colors.dart';

typedef OnChanged<Map> = void Function(Map data);

///@description 选项卡之中的标题是动态改变的选项卡:在优惠券改动时，需要动态改变标题：例如【待审核（12），数字会跟随列表数量变化,导致整个选项卡都要动态变化】
///@updateTime 2024/10/10 9:41
/////@timeUpdate 2025/7/11 直接固定携带具体确定的数字,注意：数字是字符串形式
class MCTabBarTitleDynamicNumber extends StatefulWidget {
  //内部直接传递对象数值
  final List<Map<String, dynamic>> rxListTabKeyValues;
  //
  final OnChanged<Map<String, dynamic>> onChanged;

  const MCTabBarTitleDynamicNumber({
    super.key,
    required this.rxListTabKeyValues,
    required this.onChanged,
  });

  @override
  State<MCTabBarTitleDynamicNumber> createState() => _MCTabBarTitleDynamicNumberState();
}

class _MCTabBarTitleDynamicNumberState extends State<MCTabBarTitleDynamicNumber> with SingleTickerProviderStateMixin {
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
            //传递的参数是内部的单独的map
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
      for (var currentMapDynamic in widget.rxListTabKeyValues) {
        tabs.add(
          Tab(
            //这里应该是有2个小布局的逻辑。
            // child: RowMainAlignStart(
            child: RowMainAlignCenter(
              children: [
                Text(
                  //左侧标题文字
                  currentMapDynamic[typeTitle],
                  style: const TextStyle(fontSize: 14, color: Colors.black),
                ),
                Text(
                  "( ",
                  style: const TextStyle(fontSize: 10, color: Colors.black),
                ),
                Text(
                  //特别注意：数字是字符串格式：
                  currentMapDynamic[typeCount],
                  style: const TextStyle(fontSize: 10, color: Colors.black),
                ),
                Text(
                  " )",
                  style: const TextStyle(fontSize: 10, color: Colors.black),
                ),
              ],
            ),
          ),
        );
      }
    }
    return tabs;
  }
}
