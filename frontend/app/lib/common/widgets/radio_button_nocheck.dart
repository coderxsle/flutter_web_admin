import 'package:auto_shop_server/common/common_tools.dart';
import 'package:auto_shop_server/app/utils/common_widget/logger.dart';
import 'package:flutter/material.dart';

import '../../app/utils/global.dart';

// RadioButton("测试是否控件：", decoration: BoxDecorationRadius.topRadius(), valueChanged: (value) {
//   showMessage("$value");
// }),

///@description 勾选样式的单选按钮，单独赋值左侧和右侧的值 ，true是选中，false是不选中
///@updateTime 2024/9/13 18:50
class RadioButtonNoCheck extends StatefulWidget {
  final bool? required;
  final String title;
  final bool? leftValue; //外部影响
  final bool? rightValue; //外部影响
  final Map<String, dynamic>? keyValues;
  final ValueChanged onTap;
  final Color? backgroundColor;
  final EdgeInsetsGeometry? padding;
  final Decoration? decoration;

  const RadioButtonNoCheck(
    this.title, {
    super.key, //
    this.keyValues, //
    this.required, //
    required this.onTap, //
    this.backgroundColor, //
    this.padding, //
    this.decoration, //
    this.leftValue,
    this.rightValue,
  }); //

  @override
  State<RadioButtonNoCheck> createState() => _RadioButtonNoCheckState();
}

class _RadioButtonNoCheckState extends State<RadioButtonNoCheck> {
  bool _selectedLeftValue = false; // 内部管理选中状态
  bool _selectedRightValue = false; // 内部管理选中状态
  List keyValuesToList = [];

  @override
  void initState() {
    super.initState();

    // logger.d("initState+${widget.title.toString()}");
    keyValuesToList = (widget.keyValues ?? {"是": "1", "否": "0"}).keys.toList();
    logger.d("keyValuesToList值${CommonTools.prettyJsonStringSimple(keyValuesToList)}"); 
    _selectedLeftValue = widget.leftValue!;
    _selectedRightValue = widget.rightValue!;
  }

  @override
  void didUpdateWidget(RadioButtonNoCheck oldWidget) {
    super.didUpdateWidget(oldWidget);

    // logger.d("oldWidget-${oldWidget.title.toString()}-左侧-旧状态->${oldWidget.leftValue}");
    // logger.d("widget.value-${oldWidget.title.toString()}-左侧-新状态->${widget.leftValue.toString()}");
    //
    // logger.d("oldWidget-${oldWidget.title.toString()}-右侧-旧状态->${oldWidget.rightValue}");
    // logger.d("widget.value-${oldWidget.title.toString()}-右侧-新状态->${widget.rightValue.toString()}");

    if (oldWidget.leftValue != widget.leftValue) {
      _selectedLeftValue = widget.leftValue!;
    }

    if (oldWidget.rightValue != widget.rightValue) {
      _selectedRightValue = widget.rightValue!;
    }
  }

  void _onChangeLeft() {
    // final keyValues = widget.keyValues ?? {"是": "1", "否": "0"};
    // List keys = keyValues.keys.toList();

    setState(() {
      _selectedLeftValue = true;
      _selectedRightValue = false;
    });

    // logger.d("_buildRadioButton-点击了左侧${keyValues[keys.first]!.toString()}");
    widget.onTap(widget.keyValues![keyValuesToList.first]!);
  }

  void _onChangeRight() {
    // final keyValues = widget.keyValues ?? {"是": "1", "否": "0"};
    // List keys = keyValues.keys.toList();

    setState(() {
      _selectedLeftValue = false;
      _selectedRightValue = true;
    });

    // logger.d("_buildRadioButton-点击了右侧${keyValues[keys.last]!.toString()}");
    widget.onTap(widget.keyValues![keyValuesToList.last]!);
  }

  @override
  Widget build(BuildContext context) {
    // final keyValues = widget.keyValues ?? {"是": "1", "否": "0"};
    // List keys = keyValues.keys.toList();
    return Container(
        height: 44,
        margin: const EdgeInsets.fromLTRB(0, 0, 0, 0.4),
        decoration: widget.decoration ?? BoxDecoration(color: widget.backgroundColor ?? Colors.white),
        padding: widget.padding ?? const EdgeInsets.fromLTRB(8, 0, 10, 0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(children: [
              Padding(
                padding: const EdgeInsets.fromLTRB(0, 4, 2, 0),
                child: Text(widget.required == true ? "*" : "  ", style: redBoldStyle()),
              ),
              Text(widget.title, style: blackStyle()),
            ]),
            const SizedBox(width: 5),
            Container(
              padding: const EdgeInsets.fromLTRB(0, 0, 10, 0),
              child: Row(
                children: [
                  _buildRadioButton(
                      label: keyValuesToList.first,
                      value: _selectedLeftValue, // 左值
                      onChanged: _onChangeLeft),
                  const SizedBox(width: 25),
                  _buildRadioButton(
                      label: keyValuesToList[1],
                      value: _selectedRightValue, // 右值
                      onChanged: _onChangeRight),
                ],
              ),
            )
          ],
        ));
  }

  Widget _buildRadioButton({required String label, required bool value, required VoidCallback onChanged}) {
    return Row(
      children: [
        SizedBox(
          width: 30,
          height: 30,
          child: Checkbox(
            shape: const CircleBorder(),
            side: const BorderSide(width: 1, color: Color.fromRGBO(151, 151, 151, 1)),
            value: value,
            activeColor: TdColors.brand,
            onChanged: (bool? checked) {
              if (checked == true) {
                onChanged();
              }
            },
          ),
        ),
        Text(label, style: blackStyle()),
      ],
    );
  }
}
