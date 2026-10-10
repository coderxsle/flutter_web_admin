import 'package:auto_shop_server/common/widgets/radio_button_widget.dart';
import 'package:flutter/material.dart';

import '../../app/utils/global.dart';

// RadioButton("测试是否控件：", decoration: BoxDecorationRadius.topRadius(), valueChanged: (value) {
//   showMessage("$value");
// }),

///@description 勾选样式的单选按钮，单独赋值左侧和右侧的值 ，true是选中，false是不选中
///@updateTime 2024/9/13 18:50
class RadioButtonHookMap extends StatefulWidget {
  final bool? required;
  final String title;
  final bool? leftValue; //外部影响
  final bool? rightValue; //外部影响
  // final Map<String, dynamic>? keyValues;
  final List<Map<String, dynamic>> mapList; //第二种方式 方便打印整块单个数据。
  final ValueChanged onTap;
  final Color? backgroundColor;
  final EdgeInsetsGeometry? padding;
  final Decoration? decoration;

  const RadioButtonHookMap(
    this.title, {
    super.key, //
    required this.mapList, //
    this.required, //
    required this.onTap, //
    this.backgroundColor, //
    this.padding, //
    this.decoration, //
    this.leftValue,
    this.rightValue,
  }); //

  @override
  State<RadioButtonHookMap> createState() => _RadioButtonHookMapState();
}

class _RadioButtonHookMapState extends State<RadioButtonHookMap> {
  bool _selectedLeftValue = false; // 内部管理选中状态
  bool _selectedRightValue = false; // 内部管理选中状态
  //List<MapEntry<String, dynamic>> mapEntryList = [];

  @override
  void initState() {
    super.initState();
    //mapEntryList = (widget.keyValues)!.entries.toList();
    // logger.d("keyValuesToList值${CommonTools.prettyJsonStringSimple(widget.keyValues)}");

    _selectedLeftValue = widget.leftValue!;
    _selectedRightValue = widget.rightValue!;
  }

  @override
  void didUpdateWidget(RadioButtonHookMap oldWidget) {
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
    widget.onTap(widget.mapList.first);
  }

  void _onChangeRight() {
    setState(() {
      _selectedLeftValue = false;
      _selectedRightValue = true;
    });

    // logger.d("_buildRadioButton-点击了右侧${keyValues[keys.last]!.toString()}");
    widget.onTap(widget.mapList.last);
  }

  @override
  Widget build(BuildContext context) {
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
                  RadioButtonWidget(
                      label: widget.mapList.first[keyLabel],
                      checkValue: _selectedLeftValue, // 左值
                      onChanged: _onChangeLeft),
                  const SizedBox(width: 20),
                  RadioButtonWidget(
                      label: widget.mapList.last[keyLabel],
                      checkValue: _selectedRightValue, // 右值
                      onChanged: _onChangeRight),
                ],
              ),
            )
          ],
        ));
  }

  /*Widget buildRadioButton({required String label, required bool checkValue, required VoidCallback onChanged}) {
    return Row(
      children: [
        SizedBox(
          width: 30,
          height: 30,
          child: Checkbox(
            shape: const CircleBorder(),
            side: const BorderSide(width: 1, color: Color.fromRGBO(151, 151, 151, 1)),
            value: checkValue,
            activeColor: ThemeColor,
            onChanged: (bool? checked) {
              if (checked == true) {
                onChanged.call();
              }
            },
          ),
        ),
        Text(label, style: blackStyle()),
      ],
    );
  }*/
}
