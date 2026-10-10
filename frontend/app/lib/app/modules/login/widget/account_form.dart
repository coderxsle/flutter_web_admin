import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../common/widgets/divider_line_light.dart';
import '../../../utils/global.dart';

/// 账号模块表单页共用的一套零件：滚动容器 / 分组标题 / 白底卡片 / 输入行 /
/// 只读信息行 / 获取验证码按钮 / 警示条 / 说明文字 / 主按钮。
/// 修改手机号、修改密码、删除账号三页共用，样式只在这里定义一份。

/// 表单页统一的滚动容器：左右 12 边距、底部避让 Home Indicator、滚动时收起键盘
class FormScrollBody extends StatelessWidget {
  final List<Widget> children;

  const FormScrollBody({super.key, required this.children});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
      padding: EdgeInsets.fromLTRB(12.w, 12.h, 12.w, 12.h + MediaQuery.paddingOf(context).bottom),
      child: Column(crossAxisAlignment: CrossAxisAlignment.stretch, children: children),
    );
  }
}

/// 表单块之间的间距，统一收口在这里，页面不必再引 screenutil
class FormGap extends StatelessWidget {
  final double height;

  const FormGap(this.height, {super.key});

  @override
  Widget build(BuildContext context) => SizedBox(height: height.h);
}

/// 分组标题
class FormGroupTitle extends StatelessWidget {
  final String title;

  const FormGroupTitle(this.title, {super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(left: 4.w, bottom: 8.h),
      child: Text(title, style: const TextStyle(fontSize: 13, color: TdColors.grey85)),
    );
  }
}

/// 白底圆角卡片，行与行之间自动补浅色分隔线
class FormCard extends StatelessWidget {
  final List<Widget> children;

  const FormCard({super.key, required this.children});

  @override
  Widget build(BuildContext context) {
    return Container(
      clipBehavior: Clip.antiAlias,
      decoration: BoxDecoration(color: TdColors.white, borderRadius: BorderRadius.circular(8)),
      child: Column(
        children: [
          for (int i = 0; i < children.length; i++) ...[
            if (i > 0) const DividerLineLight(height: 0.5),
            children[i],
          ],
        ],
      ),
    );
  }
}

/// 一行输入：左侧定宽标签 + 输入框，右侧可挂按钮
class FormInputRow extends StatefulWidget {
  final String label;
  final TextEditingController controller;
  final String hintText;
  final int? maxLength;
  final bool digitsOnly;

  /// 密码框：默认隐藏，带右侧显隐切换
  final bool password;
  final Widget? trailing;
  final ValueChanged<String>? onChanged;

  const FormInputRow({
    super.key,
    required this.label,
    required this.controller,
    required this.hintText,
    this.maxLength,
    this.digitsOnly = false,
    this.password = false,
    this.trailing,
    this.onChanged,
  });

  @override
  State<FormInputRow> createState() => _FormInputRowState();
}

class _FormInputRowState extends State<FormInputRow> {
  bool _obscured = true;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 52,
      padding: EdgeInsets.symmetric(horizontal: 12.w),
      child: Row(
        children: [
          SizedBox(width: 70.w, child: Text(widget.label, style: const TextStyle(fontSize: 15, color: TdColors.textPrimary))),
          Expanded(
            child: TextField(
              controller: widget.controller,
              obscureText: widget.password && _obscured,
              keyboardType: widget.digitsOnly
                  ? TextInputType.number
                  : widget.password
                      ? TextInputType.visiblePassword
                      : TextInputType.text,
              inputFormatters: [
                if (widget.digitsOnly) FilteringTextInputFormatter.digitsOnly,
                if (widget.maxLength != null) LengthLimitingTextInputFormatter(widget.maxLength),
              ],
              autocorrect: false,
              enableSuggestions: !widget.password,
              style: const TextStyle(fontSize: 15, color: TdColors.textPrimary),
              decoration: InputDecoration(
                isDense: true,
                border: InputBorder.none,
                contentPadding: EdgeInsets.zero,
                hintText: widget.hintText,
                hintStyle: const TextStyle(fontSize: 15, color: TdColors.grey153),
              ),
              onChanged: widget.onChanged,
            ),
          ),
          if (widget.password)
            GestureDetector(
              behavior: HitTestBehavior.opaque,
              onTap: () => setState(() => _obscured = !_obscured),
              child: Padding(
                padding: EdgeInsets.only(left: 8.w),
                child: Icon(
                  _obscured ? Icons.visibility_off_outlined : Icons.visibility_outlined,
                  size: 18,
                  color: TdColors.grey135,
                ),
              ),
            ),
          if (widget.trailing != null) widget.trailing!,
        ],
      ),
    );
  }
}

/// 只读信息行：左侧标签 + 右侧内容
class FormInfoRow extends StatelessWidget {
  final String label;
  final String value;

  const FormInfoRow({super.key, required this.label, required this.value});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 52,
      padding: EdgeInsets.symmetric(horizontal: 12.w),
      child: Row(
        children: [
          SizedBox(width: 70.w, child: Text(label, style: const TextStyle(fontSize: 15, color: TdColors.textPrimary))),
          Expanded(
            child: Text(
              value,
              textAlign: TextAlign.right,
              style: const TextStyle(fontSize: 15, color: TdColors.grey135),
            ),
          ),
        ],
      ),
    );
  }
}

/// 「获取验证码」：可点时品牌色描边，倒计时或不可用时置灰
class FormCodeButton extends StatelessWidget {
  final String title;
  final bool enabled;
  final VoidCallback onTap;

  const FormCodeButton({super.key, required this.title, required this.enabled, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      behavior: HitTestBehavior.opaque,
      onTap: enabled ? onTap : null,
      child: Container(
        margin: EdgeInsets.only(left: 8.w),
        padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 7.h),
        decoration: BoxDecoration(
          border: Border.all(color: enabled ? TdColors.brand : TdColors.grey195, width: 0.5),
          borderRadius: BorderRadius.circular(4),
        ),
        child: Text(
          title,
          style: TextStyle(fontSize: 13, color: enabled ? TdColors.brand : TdColors.grey153),
        ),
      ),
    );
  }
}

/// 警示条：浅红底 + 深红字，用于注销等不可逆操作前的说明
class FormWarnBanner extends StatelessWidget {
  final String text;

  const FormWarnBanner(this.text, {super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(12.w),
      decoration: BoxDecoration(color: TdColors.redBg, borderRadius: BorderRadius.circular(8)),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Icon(Icons.error_outline, size: 18, color: TdColors.brandColor9),
          SizedBox(width: 8.w),
          Expanded(
            child: Text(text, style: const TextStyle(fontSize: 13, color: TdColors.brandColor9, height: 1.5)),
          ),
        ],
      ),
    );
  }
}

/// 表单下方的说明文字
class FormHint extends StatelessWidget {
  final String text;

  const FormHint(this.text, {super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 4.w),
      child: Text(text, style: const TextStyle(fontSize: 12, color: TdColors.grey85, height: 1.5)),
    );
  }
}

/// 整宽主按钮，禁用态用品牌色浅色
class FormPrimaryButton extends StatelessWidget {
  final String title;
  final bool enabled;
  final VoidCallback onTap;

  const FormPrimaryButton({super.key, required this.title, this.enabled = true, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      behavior: HitTestBehavior.opaque,
      onTap: enabled ? onTap : null,
      child: Container(
        height: 46,
        alignment: Alignment.center,
        decoration: BoxDecoration(
          color: enabled ? TdColors.brand : TdColors.brandDisabled,
          borderRadius: BorderRadius.circular(8),
        ),
        child: Text(title, style: const TextStyle(fontSize: 16, color: TdColors.white)),
      ),
    );
  }
}
