import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../app/utils/global.dart';

// RadioButton 是一个自定义的 Flutter 组件，用于在表单中显示单选按钮组。
// 它允许用户在两个选项之间进行选择（类似于 Yes/No 或者 Personal/Company），并支持在外部控制其选中状态。
// 该组件主要用于场景需要根据外部状态（如表单数据）显示当前选中项，并将用户的选择回传给调用者。
//
// 1.	外部控制选中状态：
//    keyValues 属性用于定义按钮的显示文本和对应的值（如 {"个人": 1, "公司": 2}）。
//    value 属性决定当前选中的按钮。该属性来自外部， 为 keyValues 中的 value，用于选中对应的按钮。
//    假设：keyValues = {"个人": 1, "公司": 2}
//    当 value 为 1 时，选中第一个按钮；
//    当 value 为 2 时，选中第二个按钮。
//    value 为 null 或不匹配时，两个按钮都不选中。
//
// 2.	按钮样式与布局：
//  	组件的样式和布局可通过 backgroundColor、padding 和 decoration 等属性进行定制。
//  	组件中有两个按钮，左侧为标签文本，右侧为两个单选按钮，用户可点击按钮切换选择。
//
// 3.	事件回调：
//  	通过 onTap 回调函数，将用户的选择结果回传给外部调用者。
//  	每当用户点击某个按钮时，onTap 会被触发，并将对应的 keyValues 中的值返回。
//
// 4.	内部状态管理：
//  	组件内部维护 _selectedValue 状态，用于记录当前哪个按钮被选中
//  	（true 表示选中第一个，false 表示选中第二个，null 表示没有选中任何按钮）。
//  	当 value 属性或 keyValues 属性变化时，组件会自动更新 _selectedValue 状态，以保证界面与数据的一致性。

class RadioButton extends StatefulWidget {
  final bool? required;
  final String title;
  final num? value; // 外部传入的值，控制选中状态
  final Map<String, int>? keyValues; // key-value 映射，用于显示标签和实际值
  final ValueChanged onTap;
  final Color? backgroundColor;
  final EdgeInsetsGeometry? padding;
  final Decoration? decoration;

  const RadioButton(this.title, {
    super.key,
    this.keyValues,
    this.required,
    required this.onTap,
    this.backgroundColor,
    this.padding,
    this.decoration,
    this.value,
  });

  @override
  State<RadioButton> createState() => _RadioButtonState();
}

class _RadioButtonState extends State<RadioButton> {
  bool? _selectedValue; // 选中状态，true 代表选中第一个按钮，false 代表选中第二个按钮

  @override
  void initState() {
    super.initState();
    _updateSelectedValue();
  }

  @override
  void didUpdateWidget(RadioButton oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.value != widget.value) {
      _updateSelectedValue(); // 更新选中状态
    }
  }

  // 更新选中状态
  void _updateSelectedValue() {
    final keyValues = widget.keyValues ?? {"是": 1, "否": 0};
    if (widget.value == keyValues.values.first) {
      _selectedValue = true; // 选中第一个按钮
    } else if (widget.value == keyValues.values.elementAt(1)) {
      _selectedValue = false; // 选中第二个按钮
    } else {
      _selectedValue = null; // 都不选中
    }
  }

  @override
  Widget build(BuildContext context) {
    final keyValues = widget.keyValues ?? {"是": 1, "否": 0};
    List keys = keyValues.keys.toList();
    return Container(
      height: 44.h,
      margin: const EdgeInsets.fromLTRB(0, 0, 0, 0.4).r,
      decoration: widget.decoration ?? BoxDecoration(color: widget.backgroundColor ?? Colors.white),
      padding: widget.padding ?? const EdgeInsets.fromLTRB(8, 0, 10, 0).r,
      child: Row(
        mainAxisAlignment: widget.title.isEmpty
            ? MainAxisAlignment.center
            : MainAxisAlignment.spaceBetween,
        children: [
          Row(children: [
            Padding(
              padding: const EdgeInsets.fromLTRB(0, 4, 2, 0).r,
              child: Text(widget.required == true ? "*" : "  ", style: redBoldStyle()),
            ),
            if (widget.title.isNotEmpty) Text(widget.title, style: blackStyle()),
          ]),
          SizedBox(width: 5.w),
          Container(
            padding: const EdgeInsets.fromLTRB(0, 0, 10, 0).r,
            child: Row(
              children: [
                _buildRadioButton(
                  label: keys.first,
                  value: _selectedValue == true, // 当前选中状态
                  onChanged: () {
                    setState(() {
                      _selectedValue = true;
                      widget.onTap(keyValues[keys.first]!);
                    });
                  },
                ),
                SizedBox(width: 25.w),
                _buildRadioButton(
                  label: keys[1],
                  value: _selectedValue == false, // 反选状态
                  onChanged: () {
                    setState(() {
                      _selectedValue = false;
                      widget.onTap(keyValues[keys[1]]!);
                    });
                  },
                ),
              ],
            ),
          )
        ],
      ),
    );
  }

  Widget _buildRadioButton({
    required String label,
    required bool value,
    required VoidCallback onChanged,
  }) {
    return Row(
      children: [
        Transform.scale(
          scale: 1.2.r,
          child: SizedBox(
            width: 32, height: 32,
            child: Checkbox(
              shape: const CircleBorder(),
              side: const BorderSide(width: 1, color: Color.fromRGBO(151, 151, 151, 1)),
              value: value,
              activeColor: ThemeColor,
              onChanged: (bool? checked) {
                if (checked == true) {
                  onChanged();
                }
              },
            ),
          ),
        ),
        Text(label, style: blackStyle()),
      ],
    );
  }
}