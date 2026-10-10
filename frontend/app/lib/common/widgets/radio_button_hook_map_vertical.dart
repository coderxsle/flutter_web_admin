import 'package:auto_shop_server/common/widgets/radio_button_widget.dart';
import 'package:flutter/material.dart';

import '../../app/utils/global.dart';

///@description 垂直方向的 ，true是选中，false是不选中
///@updateTime 2024/9/13 18:50
class RadioButtonHookMapVertical extends StatefulWidget {
  final bool? required;
  final String title;
  final bool? firstValue; //外部影响
  final bool? secondValue; //外部影响
  final bool? threeValue; //外部影响
  // final Map<String, dynamic>? keyValues;
  final List<Map<String, dynamic>> mapList; //第二种方式 方便打印整块单个数据。
  final ValueChanged onTap;
  final Color? backgroundColor;
  final EdgeInsetsGeometry? padding;
  final Decoration? decoration;

  const RadioButtonHookMapVertical(
    this.title, {
    super.key, //
    required this.mapList, //
    this.required, //
    required this.onTap, //
    this.backgroundColor, //
    this.padding, //
    this.decoration, //
    required this.firstValue,
    required this.secondValue,
    required this.threeValue,
  }); //

  @override
  State<RadioButtonHookMapVertical> createState() => _RadioButtonHookMapVerticalState();
}

class _RadioButtonHookMapVerticalState extends State<RadioButtonHookMapVertical> {
  bool _selectedFirstValue = false;
  bool _selectedSecondValue = false;
  bool _selectedThreeValue = false;

  @override
  void initState() {
    super.initState();
    //mapEntryList = (widget.keyValues)!.entries.toList();
    // logger.d("keyValuesToList值${CommonTools.prettyJsonStringSimple(widget.keyValues)}");
    _selectedFirstValue = widget.firstValue!;
    _selectedSecondValue = widget.secondValue!;
    _selectedThreeValue = widget.threeValue!;
  }

  @override
  void didUpdateWidget(RadioButtonHookMapVertical oldWidget) {
    super.didUpdateWidget(oldWidget);

    // logger.d("oldWidget-${oldWidget.title.toString()}-左侧-旧状态->${oldWidget.leftValue}");
    // logger.d("widget.value-${oldWidget.title.toString()}-左侧-新状态->${widget.leftValue.toString()}");
    //
    // logger.d("oldWidget-${oldWidget.title.toString()}-右侧-旧状态->${oldWidget.rightValue}");
    // logger.d("widget.value-${oldWidget.title.toString()}-右侧-新状态->${widget.rightValue.toString()}");

    if (oldWidget.firstValue != widget.firstValue) {
      _selectedFirstValue = widget.firstValue!;
    }

    if (oldWidget.secondValue != widget.secondValue) {
      _selectedSecondValue = widget.secondValue!;
    }

    if (oldWidget.threeValue != widget.threeValue) {
      _selectedThreeValue = widget.threeValue!;
    }
  }

  void _onChangeFirst() {
    // final keyValues = widget.keyValues ?? {"是": "1", "否": "0"};
    // List keys = keyValues.keys.toList();
    setState(() {
      _selectedFirstValue = true;
      _selectedSecondValue = false;
      _selectedThreeValue = false;
    });
    // logger.d("_buildRadioButton-点击了左侧${keyValues[keys.first]!.toString()}");
    widget.onTap(widget.mapList.first);
  }

  void _onChangeSecond() {
    setState(() {
      _selectedFirstValue = false;
      _selectedSecondValue = true;
      _selectedThreeValue = false;
    });
    // logger.d("_buildRadioButton-点击了右侧${keyValues[keys.last]!.toString()}");
    widget.onTap(widget.mapList[1]);
  }

  void _onChangeThree() {
    setState(() {
      _selectedFirstValue = false;
      _selectedSecondValue = false;
      _selectedThreeValue = true;
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
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  RadioButtonWidget(
                      label: widget.mapList.first[keyLabel],
                      checkValue: _selectedFirstValue, // 左值
                      onChanged: _onChangeFirst),
                  const SizedBox(width: 20),
                  RadioButtonWidget(
                      label: widget.mapList.last[keyLabel],
                      checkValue: _selectedSecondValue, // 右值
                      onChanged: _onChangeSecond),
                  const SizedBox(width: 20),
                  RadioButtonWidget(
                      label: widget.mapList.last[keyLabel],
                      checkValue: _selectedThreeValue, // 右值
                      onChanged: _onChangeThree),
                ],
              ),
            )
          ],
        ));
  }
}
