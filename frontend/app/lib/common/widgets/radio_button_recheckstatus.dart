import 'package:flutter/material.dart';
import '../../app/utils/global.dart';

// RadioButton("测试是否控件：", decoration: BoxDecorationRadius.topRadius(), valueChanged: (value) {
//   showMessage("$value");
// }),

///@description 勾选样式的单选按钮，单独赋值左侧和右侧的值 ，true是选中，false是不选中，
///额外增加一个因为外部影响导致内部选中更改的值内容的字段：toChangeOpen
///@updateTime 2024/9/13 18:52
class RadioButtonRecheckStatus extends StatefulWidget {
  final bool? required;
  final String title;
  final bool? leftValue; //外部影响
  final bool? rightValue; //外部影响
  final int? toChangeOpen;
  final Map<String, dynamic>? keyValues;
  final ValueChanged onTap;
  final Color? backgroundColor;
  final EdgeInsetsGeometry? padding;
  final Decoration? decoration;

  const RadioButtonRecheckStatus(
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
    required this.toChangeOpen,
  }); //

  @override
  State<RadioButtonRecheckStatus> createState() => _RadioButtonRecheckStatusState();
}

class _RadioButtonRecheckStatusState extends State<RadioButtonRecheckStatus> {
  bool _selectedLeftValue = false; // 内部管理选中状态
  bool _selectedRightValue = false; // 内部管理选中状态
  int _toChangeOpen = -2; // 是否需要主动打开【是】选项或者【否】选项默认-1是啥都不做

  @override
  void initState() {
    super.initState();

    // logger.d("initState+${widget.title.toString()}");

    _selectedLeftValue = widget.leftValue!;
    _selectedRightValue = widget.rightValue!;
    _toChangeOpen = widget.toChangeOpen!;
  }

  @override
  void didUpdateWidget(RadioButtonRecheckStatus oldWidget) {
    super.didUpdateWidget(oldWidget);

    // logger.d("oldWidget-${oldWidget.title.toString()}-是否需要复检-旧状态->${oldWidget.leftValue}");
    // logger.d("widget.value-${oldWidget.title.toString()}-是否需要复检-新状态->${widget.leftValue.toString()}");
    // logger.d("_toChangeOpen-${oldWidget.title.toString()}-是否需要复检-变更->${_toChangeOpen.toString()}");

    if (oldWidget.leftValue != widget.leftValue) {
      _selectedLeftValue = widget.leftValue!;
    }

    if (oldWidget.rightValue != widget.rightValue) {
      _selectedRightValue = widget.rightValue!;
    }

    if (_toChangeOpen != widget.toChangeOpen) {

      _toChangeOpen=widget.toChangeOpen!;

      if (_toChangeOpen == 1) {
        // logger.d("外部触发- 是否需要复检，即将发生变动-改动为【是】");
        _onChangeLeft.call();
      } else if (_toChangeOpen == 0) {
        // logger.d("外部触发-不需要变动 是否需要复检，-改动为【否】");
        _onChangeRight.call();
      } else {
        // logger.d("外部触发-不需要变动 是否需要复检，-不做任何改动");
      }

    }else{
      // logger.d("外部触发-_toChangeOpen值相等");
    }
  }

  void _onChangeLeft() {
    final keyValues = widget.keyValues ?? {"是": "1", "否": "0"};
    List keys = keyValues.keys.toList();

    setState(() {
      _selectedLeftValue = true;
      _selectedRightValue = false;
    });

    // logger.d("_buildRadioButton-点击了左侧${keyValues[keys.first]!.toString()}");
    widget.onTap(keyValues[keys.first]!);
  }

  void _onChangeRight() {
    final keyValues = widget.keyValues ?? {"是": "1", "否": "0"};
    List keys = keyValues.keys.toList();

    setState(() {
      _selectedLeftValue = false;
      _selectedRightValue = true;
    });

    // logger.d("_buildRadioButton-点击了右侧${keyValues[keys[1]]!.toString()}");
    widget.onTap(keyValues[keys[1]]!);
  }

  @override
  Widget build(BuildContext context) {
    final keyValues = widget.keyValues ?? {"是": "1", "否": "0"};
    List keys = keyValues.keys.toList();
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
                      label: keys.first,
                      value: _selectedLeftValue, // 左值
                      onChanged: _onChangeLeft),
                  const SizedBox(width: 25),
                  _buildRadioButton(
                      label: keys[1],
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
