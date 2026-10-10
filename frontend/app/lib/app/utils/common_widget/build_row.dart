import 'package:auto_shop_server/common/index.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../theme/app_text_theme.dart';

class BuildTitle extends StatelessWidget {
  final String? title;
  final TextStyle? titleStyle;
  final EdgeInsetsGeometry? padding;
  final bool? firstRadius;
  final bool? bottomRadius;

  const BuildTitle({super.key, this.title, this.titleStyle, this.padding, this.firstRadius, this.bottomRadius});

  @override
  Widget build(BuildContext context) {
    const top = BoxDecoration(color: Colors.white, borderRadius: BorderRadius.only(topLeft: Radius.circular(8), topRight: Radius.circular(8)));
    const bottom = BoxDecoration(color: Colors.white, borderRadius: BorderRadius.only(bottomLeft: Radius.circular(8), bottomRight: Radius.circular(8)));
    return Container(
      padding: padding ?? const EdgeInsets.fromLTRB(15, 10, 15, 0),
      decoration: firstRadius == true
          ? top
          : bottomRadius == true
              ? bottom
              : const BoxDecoration(color: Colors.white),
      child: Row(
        children: [
          Text(title ?? "", style: titleStyle ?? TextStyle(fontSize: 14.sp, fontWeight: FontWeight.bold)),
        ],
      ),
    );
  }
}

@Deprecated(
  'Use `InputValue()` instead. '
  'Use `RadioButton()` instead. '
  'Use `RemarkView()` instead. '
  '此功能在 v1.6.0 之后已弃用',
)
class BuildRow2 extends StatefulWidget {
  const BuildRow2({
    super.key,
    this.icon,
    this.title,
    this.subTitle,
    this.titleStyle,
    this.titleHasNoPaddingLeft,
    this.imageName,
    this.hintText,
    this.height,
    this.subview,
    this.color,
    this.padding,
    this.tec,
    this.textAlign,
    this.valueRequired = false,
    this.textInputType,
    this.onChanged,
    this.onTap,
    this.readOnly = false,
    this.decoration,
    this.right,
    this.firstRadius,
    this.bottomRadius,
    this.hasTextField = true,
    this.titleMarginTop,
    this.subTitleStyle, //默认设置有文本输入框
  });

  final Widget? icon;
  final String? title;
  final String? subTitle;
  final double? titleMarginTop;
  final TextStyle? titleStyle;
  final TextStyle? subTitleStyle;
  //标题的左侧是否需要距离左侧有padding,如果等于true那就是距离左侧没有padding,如果是false那么就是默认距离左侧有6个padding
  final bool? titleHasNoPaddingLeft;
  final String? imageName;
  final String? hintText;
  final double? height;
  final Widget? subview;
  final Color? color;
  final EdgeInsetsGeometry? padding;
  final TextEditingController? tec;
  final TextAlign? textAlign;
  final bool? valueRequired;
  final TextInputType? textInputType;
  final ValueChanged<String>? onChanged;
  final GestureTapCallback? onTap;
  final bool readOnly;
  final BoxDecoration? decoration;
  final Widget? right;
  final bool? firstRadius;
  final bool? bottomRadius;
  final bool? hasTextField;

  @override
  State<BuildRow2> createState() => _BuildRow2State();
}

class _BuildRow2State extends State<BuildRow2> {
  @override
  Widget build(BuildContext context) {
    return setupSubViews();
  }

  Widget setupSubViews() {
    return Container(
      padding: widget.padding ?? const EdgeInsets.fromLTRB(10, 0, 10, 0),
      margin: const EdgeInsets.fromLTRB(0, 0, 0, 0.4),
      decoration: widget.decoration ?? buildDecoration(),
      child: Column(
        //影响所有的子部件
        //mainAxisAlignment: MainAxisAlignment.start,
        // crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          SizedBox(height: widget.titleMarginTop ?? 0.0), //标题距离顶部的一个高度，不设置就是0，设置就是titleMarginTop
          Row(
            children: [
              if (widget.valueRequired == true) Padding(padding: const EdgeInsets.only(top: 4), child: Text("*", style: redBoldStyle())),

              // 优化图标和图片的处理，避免冗余的布局逻辑
              Padding(
                padding: EdgeInsets.fromLTRB((widget.valueRequired == true ? 0 : (widget.titleHasNoPaddingLeft ?? false ? 0 : 6)), 0, 0, 0),
                child: widget.imageName != null && widget.imageName!.isNotEmpty ? Image(image: AssetImage(widget.imageName!), width: 28) : widget.icon ?? const SizedBox.shrink(),
              ),

              // 确保 title 不为 null
              if (widget.title != null) Text(widget.title!, style: widget.titleStyle ?? blackStyle()),
              //@updateTime 2025-1-5 增加一个subTitle，横向的，放在右侧
              Visibility(visible: ObjectUtil.isNotEmpty(widget.subTitle), child: Text(widget.subTitle ?? "", style: widget.subTitleStyle ?? greyStyle(font: 12))),

              if (widget.hasTextField ?? true) setupTextField(),

              // 如果存在右侧的附加组件则显示
              if (widget.right != null) widget.right!,
            ],
          ),
          // 如果有子视图，则显示子视图
          if (widget.subview != null) widget.subview!,
        ],
      ),
    );
  }

  Widget setupTextField() {
    return Expanded(
      child: Container(
        height: widget.height ?? 44,
        padding: const EdgeInsets.fromLTRB(0, 0, 10, 0),
        alignment: const Alignment(0, 0),
        child: TextField(
          controller: widget.tec,
          onChanged: widget.onChanged,
          onTap: widget.onTap,
          autofocus: false,
          readOnly: widget.readOnly,
          keyboardType: widget.textInputType,
          textAlign: TextAlign.end,
          textAlignVertical: TextAlignVertical.center, // 文字垂直居中
          style: blackStyle(),
          scrollPhysics: const NeverScrollableScrollPhysics(), // 禁止滚动
          decoration: InputDecoration(
            isDense: true,
            border: InputBorder.none,
            hintText: widget.hintText ?? " ",
            hintStyle: greyStyle(),
          ),
          maxLines: widget.height != null ? 1 : null, // 动态调整高度
        ),
      ),
    );
  }

  // 分离装饰逻辑，减少复杂判断
  BoxDecoration buildDecoration() {
    // 提取公共颜色变量，减少重复代码
    final containerColor = widget.color ?? Colors.white;
    if (widget.firstRadius == true) {
      return BoxDecoration(
        color: containerColor,
        borderRadius: const BorderRadius.only(
          topLeft: Radius.circular(8),
          topRight: Radius.circular(8),
        ),
      );
    } else if (widget.bottomRadius == true) {
      return BoxDecoration(
        color: containerColor,
        borderRadius: const BorderRadius.only(
          bottomLeft: Radius.circular(8),
          bottomRight: Radius.circular(8),
        ),
      );
    } else {
      return BoxDecoration(color: containerColor);
    }
  }
}
