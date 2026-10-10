import 'package:auto_shop_server/app/utils/global.dart';
import 'package:flutter/material.dart';

// typedef Callback = void Function(Object o);

class SettingCell extends StatefulWidget {
  final String? title;
  final String? imageName;
  final IconData? iconData;
  final Color? titleColor;
  final String? subTitle;
  final String? bottomTitle;
  final double? subTitlePaddingR;
  final String? subImageName;
  final bool showArrow;
  final Widget? trailing;
  final VoidCallback? callback;

  const SettingCell({
    super.key,
    this.title,
    this.imageName,
    this.iconData,
    this.titleColor,
    this.subTitle,
    this.subTitlePaddingR,
    this.bottomTitle,
    this.subImageName,
    this.showArrow = false,
    this.trailing,
    this.callback,
  }) : assert(title != null, 'title不能为空!');
  // assert(imageName != null, 'imageName不能为空！');

  /// 点击事件：叠一层 InkWell 出水波纹（白底在下面，水波纹画在上层 Material 上）
  /// 必须显式给色：主题里 highlightColor 是 greenAccent，不覆盖会按出绿色
  Widget onTap(VoidCallback? callBack) => Material(
        color: Colors.transparent,
        child: Stack(
          children: [
            this,
            Positioned.fill(
              child: InkWell(onTap: callBack, splashColor: Colors.black12, highlightColor: Colors.transparent),
            ),
          ],
        ),
      );

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
              Text(widget.title!, style: TextStyle(fontSize: 15, color: widget.titleColor ?? Colors.black))
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
            // 附加控件（如更新红点）
            if (widget.trailing != null) Padding(padding: const EdgeInsets.only(right: 6), child: widget.trailing),
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
          // 图标
          widget.imageName != null
              ? Image(
                  image: AssetImage('images/${widget.imageName!}'),
                  width: 20,
                )
              : Icon(widget.iconData, size: 22.0, color: Colors.black38),
          const SizedBox(width: 10),
          // title + 说明
          Expanded(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(widget.title!, style: TextStyle(fontSize: 14, color: widget.titleColor ?? Colors.black)),
                const SizedBox(height: 2),
                Text(widget.bottomTitle!, style: const TextStyle(fontSize: 12, color: Colors.grey)),
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
    // 单行统一 48（满足 Material 最小点击区）；带说明的双行给 60，避免放大字号后溢出
    return Container(
      height: widget.bottomTitle == null ? 48 : 60,
      color: _currentColor,
      child: widget.bottomTitle == null ? _subTitle(subTitlePaddingR) : _bottomTitle(),
    );
  }
}
