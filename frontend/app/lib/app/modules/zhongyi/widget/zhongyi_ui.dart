import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:tdesign_flutter/tdesign_flutter.dart';
import 'package:yun_men_yi_pan/res/assets_res.dart';

import '../../../utils/global.dart';
import '../service/zhongyi_prefix_style.dart';

/// 中药房模块的统一版式件：白底圆角卡片、键值行、状态标签与空态。
///
/// tdesign 只提供了原子组件（TCell / TTag / TEmpty），这里按参考页面的层级
/// 把它们组合成「卡片 + 行」的固定版式，各页直接复用。

/// 白底圆角卡片；[divided] 为真时 [children] 之间自动补 0.5 细分割线。
class ZhongyiCard extends StatelessWidget {
  const ZhongyiCard({super.key, required this.children, this.padding, this.title, this.trailing, this.divided = true});

  final List<Widget> children;
  final EdgeInsetsGeometry? padding;
  final String? title;
  final Widget? trailing;
  final bool divided;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(bottom: 10.h),
      decoration: BoxDecoration(color: TdColors.white, borderRadius: BorderRadius.circular(12.w)),
      clipBehavior: Clip.antiAlias,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          if (title != null) ZhongyiSectionTitle(title!, trailing: trailing),
          Padding(
            padding: padding ?? EdgeInsets.zero,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                for (var index = 0; index < children.length; index++) ...[
                  if (divided && index > 0) const TDivider(),
                  children[index],
                ],
              ],
            ),
          ),
        ],
      ),
    );
  }
}

/// 卡片内的小节标题：品牌色竖条 + 加粗标题 + 可选右侧动作。
class ZhongyiSectionTitle extends StatelessWidget {
  const ZhongyiSectionTitle(this.label, {super.key, this.trailing});

  final String label;
  final Widget? trailing;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.fromLTRB(12.w, 10.h, 12.w, 8.h),
      child: Row(
        children: [
          Text(label, style: blackBoldStyle()),
          if (trailing != null) ...[const Spacer(), trailing!],
        ],
      ),
    );
  }
}

/// 左标签右内容的行，值超长时右侧省略。
class ZhongyiKeyValueRow extends StatelessWidget {
  const ZhongyiKeyValueRow({
    super.key,
    required this.label,
    required this.value,
    this.valueStyle,
    this.trailing,
    this.onTap,
    this.dense = false,
  });

  final String label;
  final String value;
  final TextStyle? valueStyle;
  final Widget? trailing;
  final VoidCallback? onTap;
  final bool dense;

  @override
  Widget build(BuildContext context) {
    final content = Padding(
      padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: dense ? 8.h : 11.h),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(width: 76.w, child: Text(label, style: greyStyle())),
          Expanded(
            child: Text(
              value,
              style: valueStyle ?? blackStyle(),
              textAlign: TextAlign.right,
              maxLines: 3,
              overflow: TextOverflow.ellipsis,
            ),
          ),
          if (trailing != null) ...[SizedBox(width: 6.w), trailing!],
        ],
      ),
    );
    if (onTap == null) return content;
    return InkWell(onTap: onTap, child: content);
  }
}

/// 状态标签，统一圆角胶囊样式。
class ZhongyiStatusTag extends StatelessWidget {
  const ZhongyiStatusTag(this.text, {super.key, this.colorPreset = TTagColorPreset.defaultTheme});

  final String text;
  final TTagColorPreset colorPreset;

  @override
  Widget build(BuildContext context) {
    return TTag(text,
        colorPreset: colorPreset, variant: TTagVariant.light, size: TTagSize.small, shape: TTagShape.round);
  }
}

/// 列表空态：tdesign [TEmpty] + 统一间距。
class ZhongyiEmpty extends StatelessWidget {
  const ZhongyiEmpty({super.key, this.text = '暂无数据', this.operation});

  final String text;
  final Widget? operation;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 40.h),
      child: TEmpty(image: imageAsset(height: 32, AssetsRes.QIANZI, fit: BoxFit.fill), emptyText: text, operation: operation),
    );
  }
}

/// 页面加载中。
class ZhongyiLoading extends StatelessWidget {
  const ZhongyiLoading({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 40.h),
      child: const Center(child: TLoading(text: '加载中...')),
    );
  }
}

/// 页面级的错误/提示条。
class ZhongyiNotice extends StatelessWidget {
  const ZhongyiNotice(this.text, {super.key});

  final String text;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(bottom: 10.h),
      padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 10.h),
      decoration: BoxDecoration(color: TdColors.redBg, borderRadius: BorderRadius.circular(12.w)),
      child: Row(
        children: [
          Icon(Icons.error_outline, size: 16.w, color: TdColors.brand),
          SizedBox(width: 6.w),
          Expanded(child: Text(text, style: redThemeStyle())),
        ],
      ),
    );
  }
}

/// 主按钮，统一样式（圆角实心，默认品牌色）。
class ZhongyiPrimaryButton extends StatelessWidget {
  const ZhongyiPrimaryButton({
    super.key,
    required this.text,
    this.onPressed,
    this.loading = false,
    this.height = 44,
    this.variant = TButtonVariant.fill,
    this.color = TdColors.brand,
  });

  final String text;
  final VoidCallback? onPressed;
  final bool loading;
  final double height;
  final TButtonVariant variant;
  final Color color;

  @override
  Widget build(BuildContext context) {
    final isFill = variant == TButtonVariant.fill;
    // 只有真正不可用时才降透明度；提交中保持实心，免得转圈看不清。
    final tint = onPressed == null && !loading ? color.withValues(alpha: 0.35) : color;
    return TButton(
      variant: variant,
      onPressed: loading ? null : onPressed,
      style: ButtonStyle(
        minimumSize: WidgetStatePropertyAll(Size(double.infinity, height.h)),
        backgroundColor: WidgetStatePropertyAll(isFill ? tint : Colors.transparent),
        foregroundColor: WidgetStatePropertyAll(isFill ? TdColors.white : tint),
        side: isFill ? null : WidgetStatePropertyAll(BorderSide(color: tint)),
        shape: WidgetStatePropertyAll(RoundedRectangleBorder(borderRadius: BorderRadius.circular(8.w))),
      ),
      child: loading
          ? SizedBox(
              width: 18.w, height: 18.w, child: const CircularProgressIndicator(strokeWidth: 2, color: TdColors.white))
          : Text(text, style: isFill ? whiteStyle() : blackStyle().copyWith(color: tint)),
    );
  }
}

/// 带右箭头的可点击行，用于列表项与跳转入口。
class ZhongyiArrowRow extends StatelessWidget {
  const ZhongyiArrowRow({super.key, required this.child, this.onTap, this.padding});

  final Widget child;
  final VoidCallback? onTap;
  final EdgeInsetsGeometry? padding;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Padding(
        padding: padding ?? EdgeInsets.symmetric(horizontal: 12.w, vertical: 12.h),
        child: Row(
          children: [
            Expanded(child: child),
            Icon(Icons.chevron_right, size: 18.w, color: TdColors.grey195),
          ],
        ),
      ),
    );
  }
}

// ===================== 表单件 =====================

/// 单行输入的统一高度，多行输入用 [ZhongyiFormInput.maxLines] 覆盖。
const double zhongyiFormRowHeight = 40;

/// 行内紧凑输入的高度，用于明细列表里每行都要放的输入框。
const double zhongyiFormRowDenseHeight = 32;

/// 去掉 TInput 默认的 16 内边距与自带白底：放进固定高度的小框里既不溢出、也不留白块。
ThemeData zhongyiBareInputTheme(BuildContext context) {
  final base = Theme.of(context);
  return base.copyWith(extensions: [
    ...base.extensions.values.where((extension) => extension is! TInputThemeData),
    const TInputThemeData(contentPadding: EdgeInsets.zero, backgroundColor: Colors.transparent),
  ]);
}

/// 炮制前缀标签，配色取自 [zhongyiPrefixStyleOf]；宽度随文案自适应。
///
/// [onTap] 非空即成为可点选项，[selected] 用品牌色描边加粗表示单选选中。
class ZhongyiPrefixChip extends StatelessWidget {
  const ZhongyiPrefixChip(
    this.prefix, {
    super.key,
    this.height = 24,
    this.horizontalPadding = 6,
    this.selected = false,
    this.onTap,
  });

  final String prefix;
  final double height;
  final double horizontalPadding;
  final bool selected;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    final style = zhongyiPrefixStyleOf(prefix);
    final chip = Container(
      height: height.h,
      padding: EdgeInsets.symmetric(horizontal: horizontalPadding.w),
      decoration: zhongyiPrefixDecoration(
        style,
        borderRadius: BorderRadius.circular(6.w),
        border: Border.all(
          color: selected ? TdColors.brand : Colors.black.withValues(alpha: 0.08),
          width: selected ? 1.2 : 0.5,
        ),
      ),
      // 不能用 Container 的 alignment：Wrap 里 maxWidth 有限，标签会被撑成整行。
      // FittedBox 按内容取宽，空间实在不够时等比缩小，避免被省略号吃掉文字。
      child: FittedBox(
        fit: BoxFit.scaleDown,
        child: Text(
          prefix,
          style: blackStyle(font: 14.sp).copyWith(
            fontWeight: selected ? FontWeight.w700 : FontWeight.w500,
            color: style.foreground,
          ),
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
        ),
      ),
    );
    if (onTap == null) return chip;
    return GestureDetector(behavior: HitTestBehavior.opaque, onTap: onTap, child: chip);
  }
}

/// 指标块：小标题 + 加粗数值，用于身份头与库存总览。
class ZhongyiMetricTile extends StatelessWidget {
  const ZhongyiMetricTile({
    super.key,
    required this.label,
    required this.value,
    this.color,
    this.background,
  });

  final String label;
  final String value;
  final Color? color;
  final Color? background;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 10.h),
        decoration: BoxDecoration(
          color: background ?? TdColors.pageBg,
          borderRadius: BorderRadius.circular(8.w),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(label, style: greyStyle(font: 12.sp)),
            SizedBox(height: 4.h),
            Text(
              value,
              style: blackStyle().copyWith(
                fontWeight: FontWeight.w800,
                color: color ?? TdColors.textPrimary,
              ),
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            ),
          ],
        ),
      ),
    );
  }
}

/// 小号清除钮，挂在选择行右侧用于清空已选项。
class ZhongyiClearButton extends StatelessWidget {
  const ZhongyiClearButton({super.key, required this.onTap});

  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: 17.w,
        height: 17.w,
        alignment: Alignment.center,
        decoration: const BoxDecoration(color: Color(0xFFEEF1F5), shape: BoxShape.circle),
        child: const Icon(Icons.close, size: 11, color: Color(0xFF6B7280)),
      ),
    );
  }
}

/// 数字输入放行规则：只放行可解析的进度，负号与小数点位置都受控。
class ZhongyiNumberFormatter extends TextInputFormatter {
  const ZhongyiNumberFormatter({this.signed = false, this.decimals = 3});

  final bool signed;
  final int decimals;

  @override
  TextEditingValue formatEditUpdate(TextEditingValue oldValue, TextEditingValue newValue) {
    final text = newValue.text;
    final sign = signed ? '-?' : '';
    final pattern = decimals == 0
        ? RegExp('^$sign\\d*\$')
        : RegExp('^$sign\\d*\\.?\\d{0,$decimals}\$');
    if (text.isEmpty || pattern.hasMatch(text)) return newValue;
    return oldValue;
  }
}

/// 表单行：左标签 + 右控件，编辑类页面统一用它，避免各页自搓高度。
class ZhongyiFormRow extends StatelessWidget {
  const ZhongyiFormRow({super.key, required this.label, required this.child, this.labelWidth = 76});

  final String label;
  final Widget child;
  final double labelWidth;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.fromLTRB(12.w, 5.h, 12.w, 5.h),
      child: Row(
        children: [
          SizedBox(width: labelWidth.w+8, child: Text(label, style: greyStyle())),
          Expanded(child: child),
        ],
      ),
    );
  }
}

/// 卡片内的字段小标题，用在标签组上方。
class ZhongyiFieldLabel extends StatelessWidget {
  const ZhongyiFieldLabel(this.label, {super.key, this.trailing});

  final String label;
  final Widget? trailing;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.fromLTRB(12.w, 8.h, 12.w, 4.h),
      child: Row(
        children: [
          Text(label, style: greyStyle()),
          if (trailing != null) ...[const Spacer(), trailing!],
        ],
      ),
    );
  }
}

/// 胶囊输入框：页底色 + 圆角 8，右侧可挂单位后缀；多行时高度随内容增长。
class ZhongyiFormInput extends StatelessWidget {
  const ZhongyiFormInput({
    super.key,
    required this.controller,
    this.hint,
    this.suffix,
    this.number = false,
    this.signed = false,
    this.decimals = 3,
    this.maxLength,
    this.maxLines = 1,
    this.readOnly = false,
    this.dense = false,
    this.onChanged,
  });

  final TextEditingController controller;
  final String? hint;
  final String? suffix;
  final bool number;
  final bool signed;
  final int decimals;
  final int? maxLength;
  final int maxLines;
  final bool readOnly;

  /// 列表内的行内输入用矮一档的高度，避免撑高整行。
  final bool dense;
  final ValueChanged<String>? onChanged;

  @override
  Widget build(BuildContext context) {
    final multi = maxLines > 1;
    return Container(
      // 只给下限不给上限：TInput 内部是 Column(mainAxisSize.max)，有界高度会填满并把文字顶到上面。
      constraints: BoxConstraints(minHeight: (dense ? zhongyiFormRowDenseHeight : zhongyiFormRowHeight).h),
      padding: EdgeInsets.symmetric(horizontal: dense ? 8.w : 10.w, vertical: multi ? 8.h : 0),
      decoration: BoxDecoration(color: TdColors.pageBg, borderRadius: BorderRadius.circular(dense ? 6.w : 8.w)),
      child: Row(
        children: [
          Expanded(
            child: Theme(
              data: zhongyiBareInputTheme(context),
              child: TInput(
                controller: controller,
                hintText: hint,
                borderless: true,
                readOnly: readOnly,
                maxLength: maxLength,
                maxLines: maxLines,
                inputType:
                    number ? TextInputType.numberWithOptions(decimal: true, signed: signed) : TextInputType.text,
                inputFormatters: number ? [ZhongyiNumberFormatter(signed: signed, decimals: decimals)] : null,
                onChanged: onChanged,
                style: blackStyle(),
              ),
            ),
          ),
          if (suffix != null) ...[SizedBox(width: 4.w), Text(suffix!, style: greyStyle())],
        ],
      ),
    );
  }
}

/// 搜索框：外观与 [ZhongyiFormInput] 同一套（页底色、40 高、8 圆角）。
/// 底是页底色，必须放在白底容器里，否则会糊进页面背景。
/// TSearchBar 的圆角取 radiusDefault(6) 且主题不给改，只能在外面再裁一刀。
class ZhongyiSearchBar extends StatelessWidget {
  const ZhongyiSearchBar({
    super.key,
    required this.hintText,
    this.controller,
    this.onChanged,
    this.onSubmitted,
    this.onClearPressed,
  });

  final String hintText;
  final TextEditingController? controller;
  final ValueChanged<String>? onChanged;
  final ValueChanged<String>? onSubmitted;
  final VoidCallback? onClearPressed;

  @override
  Widget build(BuildContext context) {
    final base = Theme.of(context);
    return ClipRRect(
      borderRadius: BorderRadius.circular(8.w),
      child: Theme(
        data: base.copyWith(
          extensions: [
            ...base.extensions.values.where((item) => item is! TSearchBarThemeData),
            TSearchBarThemeData(
              height: zhongyiFormRowHeight.h,
              inputBackgroundColor: TdColors.pageBg,
              contentPadding: EdgeInsets.symmetric(horizontal: 10.w),
              textStyle: blackStyle(),
              hintStyle: greyStyle(),
              clearIconTheme: IconThemeData(size: 16.w, color: TdColors.grey153),
            ),
          ],
        ),
        child: TSearchBar(
          controller: controller,
          hintText: hintText,
          inputAction: TextInputAction.search,
          onChanged: onChanged,
          onSubmitted: onSubmitted,
          onClearPressed: onClearPressed,
        ),
      ),
    );
  }
}

/// 列表页顶部工具栏：白卡托住灰胶囊搜索框，与编辑页「白卡 + 页底灰输入框」同一套层级。
/// [action] 一般放右侧主按钮，与搜索框同高。
class ZhongyiSearchToolbar extends StatelessWidget {
  const ZhongyiSearchToolbar({super.key, required this.search, this.action});

  final Widget search;
  final Widget? action;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(8.w),
      decoration: BoxDecoration(color: TdColors.white, borderRadius: BorderRadius.circular(4.w)),
      child: Row(
        children: [
          Expanded(child: search),
          if (action != null) ...[SizedBox(width: 10.w), action!],
        ],
      ),
    );
  }
}

/// 可点击选择行：胶囊底 + 右侧箭头，未选中时显示 [hint]。
class ZhongyiFormPicker extends StatelessWidget {
  const ZhongyiFormPicker({
    super.key,
    required this.onTap,
    this.value,
    this.hint,
    this.leading,
    this.trailing,
  });

  final VoidCallback onTap;
  final String? value;
  final String? hint;
  final Widget? leading;
  final Widget? trailing;

  @override
  Widget build(BuildContext context) {
    final filled = (value ?? '').isNotEmpty;
    return GestureDetector(
      behavior: HitTestBehavior.opaque,
      onTap: onTap,
      child: Container(
        height: zhongyiFormRowHeight.h,
        padding: EdgeInsets.symmetric(horizontal: 10.w),
        decoration: BoxDecoration(color: TdColors.pageBg, borderRadius: BorderRadius.circular(8.w)),
        child: Row(
          children: [
            // 给了 leading（例如前缀 chip）就不再重复渲染文本值。
            // 用 Expanded + Align：不能让 leading 和 Spacer 平分剩余宽度，否则 4 字前缀会被压没。
            if (leading != null)
              Expanded(child: Align(alignment: Alignment.centerLeft, child: leading!))
            else
              Expanded(
                child: Text(
                  filled ? value! : (hint ?? ''),
                  style: filled ? blackStyle() : greyStyle(),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
            if (trailing != null) ...[SizedBox(width: 6.w), trailing!],
            SizedBox(width: 4.w),
            Icon(Icons.keyboard_arrow_down, size: 16.w, color: TdColors.grey153),
          ],
        ),
      ),
    );
  }
}

/// 字段小标题 + 紧跟的标签组：合成卡片的一个子项，免得分隔线插在标题和选项之间。
class ZhongyiChipField extends StatelessWidget {
  const ZhongyiChipField({
    super.key,
    required this.label,
    required this.child,
    this.trailing,
    this.padding,
  });

  final String label;
  final Widget child;
  final Widget? trailing;
  final EdgeInsetsGeometry? padding;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        ZhongyiFieldLabel(label, trailing: trailing),
        Padding(padding: padding ?? EdgeInsets.fromLTRB(12.w, 0, 12.w, 8.h), child: child),
      ],
    );
  }
}

/// 标签选择组：选中项实心品牌色，未选浅底品牌字；[multi] 只影响调用方的集合语义。
class ZhongyiChipGroup extends StatelessWidget {
  const ZhongyiChipGroup({super.key, required this.options, required this.selected, required this.onTap});

  final List<String> options;
  final Set<String> selected;
  final ValueChanged<String> onTap;

  @override
  Widget build(BuildContext context) {
    return Wrap(
      spacing: 6.w,
      runSpacing: 6.h,
      children: [
        for (final option in options)
          GestureDetector(
            behavior: HitTestBehavior.opaque,
            onTap: () => onTap(option),
            child: Container(
              padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 5.h),
              decoration: BoxDecoration(
                color: selected.contains(option) ? TdColors.brand : TdColors.brandLight,
                borderRadius: BorderRadius.circular(6.w),
              ),
              child: Text(
                option,
                style: blackStyle(font: 12.sp).copyWith(
                  color: selected.contains(option) ? TdColors.white : TdColors.brand,
                ),
              ),
            ),
          ),
      ],
    );
  }
}

/// 展开 / 收起次要字段的行，用描边与实心输入框区分。
class ZhongyiMoreToggle extends StatelessWidget {
  const ZhongyiMoreToggle({super.key, required this.expanded, required this.onTap, this.label = '更多字段'});

  final bool expanded;
  final VoidCallback onTap;
  final String label;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      behavior: HitTestBehavior.opaque,
      onTap: onTap,
      child: Container(
        margin: EdgeInsets.fromLTRB(12.w, 6.h, 12.w, 4.h),
        padding: EdgeInsets.symmetric(vertical: 9.h),
        alignment: Alignment.center,
        decoration: BoxDecoration(
          border: Border.all(color: TdColors.grey225, width: 0.5),
          borderRadius: BorderRadius.circular(8.w),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(expanded ? Icons.remove : Icons.add, size: 15.w, color: TdColors.brand),
            SizedBox(width: 4.w),
            Text(expanded ? '收起$label' : '展开$label', style: redThemeStyle()),
          ],
        ),
      ),
    );
  }
}
