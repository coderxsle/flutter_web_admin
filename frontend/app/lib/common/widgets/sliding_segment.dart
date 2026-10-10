import 'package:auto_shop_server/app/utils/global.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';


/*
  使用示例 groupValue: 0 默认选中无
    用法一
    SlidingSegmented(
      groupValue: 0,
      keyValues: {"无": 0, "本品": 1, "他品": 2},
      backgroundColor: Colors.grey[300],
      valueChanged: (value) => controller.displacement = value,
    ),

    用法二
    SlidingSegmented(
      title: "置换类型：",
      required: true,
      margin: const EdgeInsets.fromLTRB(0, 0, 0, 1),
      keyValues: {"无": 0, "本品": 1, "他品": 2},
      backgroundColor: Colors.grey[300],
      valueChanged: (value)=> controller.displacement = value
    ),
*/
class SlidingSegmented extends StatefulWidget {
  final String? title;
  final bool? required;
  final EdgeInsetsGeometry? margin;
  final EdgeInsetsGeometry? padding;
  final Decoration? decoration;
  final MainAxisAlignment? mainAxisAlignment;
  final int? groupValue;                  // 将 groupValue 类型改为 int
  final Color? thumbColor;
  final Color? backgroundColor;
  final Map<String, int> keyValues;      // keyValues 类型改为 Map<String, int>
  final ValueChanged<int> valueChanged;  // ValueChanged 类型改为 int

  const SlidingSegmented({
    super.key,
    this.title,
    this.required,
    this.margin,
    this.padding,
    this.thumbColor,
    this.backgroundColor,
    this.decoration,
    this.mainAxisAlignment,
    this.groupValue,
    required this.keyValues,
    required this.valueChanged,
  });

  @override
  State<SlidingSegmented> createState() => _SlidingSegmentedRowState();
}

class _SlidingSegmentedRowState extends State<SlidingSegmented> {
  late int value;

  @override
  void didUpdateWidget(SlidingSegmented oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.groupValue != widget.groupValue) {
      setState(() {
        value = widget.groupValue ?? widget.keyValues.values.first;
      });
    }
  }

  @override
  void initState() {
    value = widget.groupValue ?? widget.keyValues.values.first;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {


    if (widget.title != null) {
      return _builderRow();
    }else {
      return buildSegment();
    }
  }

  Widget buildSegment() {
    Map<int, Widget> children = {}; // 创建 Map<int, Widget> 以适配 CupertinoSlidingSegmentedControl
    widget.keyValues.forEach((label, key) {
      children[key] = Container(
        alignment: Alignment.center,
        child: Text(label, style: value == key ? whiteStyle() : blackStyle()),
      );
    });

    return SizedBox(
      height: 44.h,
      child: CupertinoSlidingSegmentedControl<int>(
        backgroundColor: widget.backgroundColor ?? Colors.grey[200]!,
        groupValue: value,         // 设置为 int 类型的 value
        thumbColor: widget.thumbColor ?? Colors.red,
        padding: widget.padding ?? const EdgeInsets.fromLTRB(4, 4, 4, 4).r,
        onValueChanged: (newValue) {
          setState(() {
            value = newValue!;     // 更新本地状态
          });
          widget.valueChanged(newValue!); // 通知外部组件
        },
        children: children,        // 将 Map<int, Widget> 传入 children
      ),
    );
  }


  _builderRow() {
    return Container(
        height: 44.h,
        margin: widget.margin ?? const EdgeInsets.fromLTRB(0, 0, 0, 0.5).r,
        padding: widget.padding ?? const EdgeInsets.fromLTRB(0, 0, 10, 0).r,
        decoration: widget.decoration ?? BoxDecoration(color: Colors.white),
        child: Row(
          mainAxisAlignment: widget.mainAxisAlignment ?? MainAxisAlignment.spaceBetween,
          children: [
            if (widget.title != null) Padding(
              padding: const EdgeInsets.fromLTRB(10, 4, 0, 0).r,
              child: Row(
                children: [
                  if (widget.required == true) Text("*", style: redBoldStyle()),
                  Text(widget.title!, style: TextStyle(color: Colors.black, fontSize: 14.sp)),
                ],
              ),
            ),
            // 
            // if (widget.mainAxisAlignment == null)
            //  Spacer()
            // else
             SizedBox(width: 10.r),
            buildSegment()
          ],
        )
    );
  }
}