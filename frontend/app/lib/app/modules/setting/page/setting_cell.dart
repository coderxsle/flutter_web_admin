import 'dart:io';

import 'package:auto_shop_server/app/utils/global.dart';
import 'package:flutter/material.dart';

// typedef Callback = void Function(Object o);

class SettingCell extends StatefulWidget {
  final String? title;
  final String? imageName;
  final IconData? iconData;
  final String? subTitle;
  final String? bottomTitle;
  final double? subTitlePaddingR;
  final String? subImageName;
  final bool showArrow;
  final VoidCallback? callback;

  const SettingCell({
    super.key,
    this.title,
    this.imageName,
    this.iconData,
    this.subTitle,
    this.subTitlePaddingR,
    this.bottomTitle,
    this.subImageName,
    this.showArrow = false,
    this.callback,
  }) : assert(title != null, 'title不能为空!');
  // assert(imageName != null, 'imageName不能为空！');

  /// 点击事件
  onTap(var callBack) => GestureDetector(
      child: this,
      onTap: () {
        callBack();
      });

  @override
  State<StatefulWidget> createState() => _SettingCellState();
}

class _SettingCellState extends State<SettingCell> {
  final Color _currentColor = Colors.white;

  @override
  Widget build(BuildContext context) {
    // return GestureDetector(
    //   onTap: () { widget.callback?.call(); },
    //   child: subView(),
    // );
    return subView(widget.subTitlePaddingR);
  }

  Widget _subTitle(double? subTitlePaddingR) {
    return Row(
      // 主轴 spaceBeween
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        // left
        Container(
          padding: const EdgeInsets.all(10),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              // 图标
              //widget.imageName != null ? Image(image: AssetImage('images/${widget.imageName!}'), height: 18, fit: BoxFit.fill) : Container(),
              widget.imageName != null ? Image(image: AssetImage('images/${widget.imageName!}'), height: 18, fit: BoxFit.fill) :  Icon(widget.iconData, size: 22.0, color: Colors.black38),
              const SizedBox(width: 10),
              Text(widget.title!, style: Platform.isIOS ? const TextStyle(fontSize: 17) : const TextStyle(fontSize: 15))
            ],
          ),
        ),
        // right
        Container(
          padding: const EdgeInsets.only(right: 10),
          child: Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
            // 副标题
            widget.subTitle != null ? Text(widget.subTitle!, style: const TextStyle(color: Colors.grey)) : Container(),
            // 副图片
            widget.subImageName != null
                ? Image.asset(
                    'images/${widget.subImageName!}',
                    width: 15,
                  )
                : Container(),
            // 箭头
            widget.showArrow == true
                ? Padding(
                    padding: EdgeInsets.only(left: subTitlePaddingR??20),
                    child: RowArrow(),
                  )
                : Container(),
          ]),
        ),
      ],
    );
  }

  Widget _bottomTitle() {
    return Container(
      padding: const EdgeInsets.fromLTRB(10, 0, 10, 0),
      child: Row(
        children: [
          // 头像
          widget.imageName != null
              ? Image(
                  image: AssetImage('images/${widget.imageName!}'),
                  width: 20,
                )
              : Container(),
          const SizedBox(width: 10),
          // title
          Expanded(
            child: Column(
              children: [
                Container(
                  alignment: Alignment.centerLeft,
                  padding: const EdgeInsets.fromLTRB(0, 5, 0, 0),
                  child: Text(widget.title!, style: Platform.isIOS ? const TextStyle(fontSize: 16) : const TextStyle(fontSize: 14)),
                ),
                Container(
                  alignment: Alignment.centerLeft,
                  child: Text(widget.bottomTitle!, style: const TextStyle(fontSize: 12, color: Colors.grey)),
                )
              ],
            ),
          ),
          // 副图片
          widget.subImageName != null
              ? Image.asset(
                  'images/${widget.subImageName!}',
                  width: 30,
                )
              : Container(),
          // 箭头
          widget.showArrow == true ? RowArrow() : Container(),
          // bottomTitle
          // rightImage
        ],
      ),
    );
  }

  Widget subView(double? subTitlePaddingR) {
    return Container(
      height: Platform.isIOS ? 50 : 42,
      color: _currentColor,
      child: widget.bottomTitle == null ? _subTitle(subTitlePaddingR) : _bottomTitle(),
    );
  }
}
