import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

/// 三奇（乙丙丁）红 —— 安卓 Color.rgb(238, 0, 0)
const Color kQiMenRed = Color(0xFFEE0000);

/// 九星任冲 / 八门杜景 蓝 —— 安卓 Color.rgb(0, 0, 255)
const Color kQiMenBlue = Color(0xFF0000FF);

/// 马星底色 —— 安卓 Color.argb(127, 255, 0, 255)
const Color kQiMenMaXingBg = Color.fromARGB(127, 255, 0, 255);

/// 日干、时干天盘干底色 —— 安卓 Color.argb(127, 0, 191, 255)
const Color kQiMenRiShiGanBg = Color.fromARGB(127, 0, 191, 255);

/// 主题默认文字色 —— 安卓 Theme.AppCompat.Light 的 textColorPrimary
///
/// 空亡、马星在安卓布局里未设 textColor，落在这个色上；
/// 它是 87% 黑，白底合成后约 #212121，比 Color.BLACK 浅一档。
const Color kQiMenThemeText = Color(0xDE000000);

/// 暗干飞支（左上角竖排）文字色 —— 安卓 Color.GRAY
const Color kQiMenAnGanGray = Color(0xFF808080);

/// 九宫格单元格。
///
/// 严格对齐安卓 item_station_detail_videolist.xml 的元素位置与
/// NineGridAdapter 的全部着色规则：
///
/// ```
///   八神 ○                              马(右上)
///   暗干(左上竖排)      [寄干] 九星        天盘干(右中)
///   地盘八神(左下)        八门            地盘干(右下)
/// ```
class QiMenGridCell extends StatelessWidget {
  const QiMenGridCell({
    super.key,
    required this.diGan,
    required this.star,
    required this.tianGan,
    required this.door,
    required this.god,
    this.diGod = '',
    this.anGan = '',
    this.riGan = '',
    this.shiGan = '',
    this.showKongWang = false,
    this.showMaXing = false,
    this.methodName,
    this.height = 100,
  });

  /// 地盘三奇六仪（右下角）
  final String diGan;

  /// 九星（正中）；中 5 宫传入的会被 [methodName] 覆盖
  final String star;

  /// 天盘三奇六仪（右侧垂直居中）；值符宫可能为两字
  final String tianGan;

  /// 八门（底部居中）
  final String door;

  /// 天盘八神（顶部居中）
  final String god;

  /// 地盘八神（左下角），未开启时不显示
  final String diGod;

  /// 暗干飞支（左上角竖排，每行一字）
  final String anGan;

  /// 是否显示空亡「○」
  final bool showKongWang;

  /// 是否显示马星「马」
  final bool showMaXing;

  /// 日干，用于给天盘干加高亮底色
  final String riGan;

  /// 时干，用于给天盘干加高亮底色
  final String shiGan;

  /// 中 5 宫在九星位置显示的方法名（拆补/置闰），其余宫为 null
  final String? methodName;

  final double height;

  /// 九星两侧的对称占位槽，保证九星严格居中（对齐安卓 centerInParent）。
  /// 左槽需容纳 16sp 的寄二宫天盘干 + 3 间距，故取 20
  static const double _sideSlot = 20;

  /// 八神右侧空亡「○」的槽宽（5 间隔 + 16sp 的 ○），左右各留一份以保居中
  static const double _kongWangSlot = 23;

  @override
  Widget build(BuildContext context) {
    // 安卓：star 为「禽芮」时把天盘干拆成两字，首字落到「寄二宫」位置
    var fiveTian = '';
    var tian = tianGan;
    if (star == '禽芮' && tianGan.length >= 2) {
      fiveTian = tianGan.substring(0, 1);
      tian = tianGan.substring(1, 2);
    }

    // 中 5 宫的「拆补/置闰」在安卓是直接 setText，无 span，落主题默认色
    final starWidget = methodName != null
        ? _text([
            TextSpan(
              text: methodName,
              style: const TextStyle(color: kQiMenThemeText),
            ),
          ])
        : _starText(star);

    return Container(
      height: height.h,
      padding: EdgeInsets.all(5.w),
      child: Stack(
        children: [
          // 暗干飞支：左上角竖排，13sp
          Align(
            alignment: Alignment.topLeft,
            child: AnGanText(anGan),
          ),
          // 马星：右上角，半透明洋红底
          if (showMaXing)
            Align(
              alignment: Alignment.topRight,
              child: Container(
                color: kQiMenMaXingBg,
                child: _text([
                  const TextSpan(
                    text: '马',
                    style: TextStyle(color: kQiMenThemeText),
                  ),
                ]),
              ),
            ),
          // 天盘八神：顶部居中；空亡「○」附加在其右侧，不参与居中
          Align(
            alignment: Alignment.topCenter,
            child: Row(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // 左侧对称占位：抵消右侧空亡槽，保证八神本身仍居中
                if (showKongWang) SizedBox(width: _kongWangSlot.w),
                _godText(god),
                if (showKongWang)
                  SizedBox(
                    width: _kongWangSlot.w,
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        SizedBox(width: 5.w),
                        Text(
                          '○',
                          style: TextStyle(
                            fontSize: 16.sp,
                            fontWeight: FontWeight.bold,
                            color: kQiMenThemeText,
                          ),
                        ),
                      ],
                    ),
                  ),
              ],
            ),
          ),
          // 天盘三奇六仪：右侧垂直居中
          Align(
            alignment: Alignment.centerRight,
            child: _qiyiText(
              tian,
              // 安卓 setTianPanText：天盘干等于日干或时干时加透明天蓝底
              bg: (tian.isNotEmpty && (tian == riGan || tian == shiGan))
                  ? kQiMenRiShiGanBg
                  : null,
            ),
          ),
          // 九星：正中；寄二宫天盘干在其左侧顶部对齐
          Align(
            alignment: Alignment.center,
            child: Row(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  width: _sideSlot.w,
                  child: fiveTian.isEmpty
                      ? null
                      : Align(
                          alignment: Alignment.topRight,
                          // 高度收缩到自身内容，避免撑高整个 Row 导致 禽芮 二星 与神盘位置重叠。 
                          heightFactor: 1,
                          child: Padding(
                            padding: EdgeInsets.only(right: 3.w),
                            child: _qiyiText(fiveTian),
                          ),
                        ),
                ),
                starWidget,
                SizedBox(width: _sideSlot.w),
              ],
            ),
          ),
          // 八门：底部居中
          Align(
            alignment: Alignment.bottomCenter,
            child: _doorText(door),
          ),
          // 地盘八神：左下角
          if (diGod.isNotEmpty)
            Align(
              alignment: Alignment.bottomLeft,
              child: _godText(diGod),
            ),
          // 地盘三奇六仪：右下角
          Align(
            alignment: Alignment.bottomRight,
            child: _qiyiText(diGan),
          ),
        ],
      ),
    );
  }

  // ---------------------------------------------------------------------------
  // 着色规则
  // ---------------------------------------------------------------------------

  /// 三奇六仪：含乙/丙/丁 → 红，否则黑（安卓 setSanqiLiuYiText / setTianPanText）
  Widget _qiyiText(String value, {Color? bg}) {
    return _text(
      [TextSpan(text: value, style: TextStyle(color: _qiyiColor(value)))],
      bg: bg,
    );
  }

  static Color _qiyiColor(String value) =>
      (value.contains('乙') || value.contains('丙') || value.contains('丁'))
          ? kQiMenRed
          : Colors.black;

  /// 九星：含「禽」只染首字；心/辅全红；任/冲全蓝；其余黑
  Widget _starText(String value) {
    if (value.isEmpty) return _text(const [TextSpan(text: '')]);

    if (value.contains('禽')) {
      // 安卓只对 [0,1) 着色，其余字保持默认色
      return _text([
        TextSpan(
          text: value.substring(0, 1),
          style: const TextStyle(color: kQiMenRed),
        ),
        TextSpan(
          text: value.substring(1),
          style: const TextStyle(color: kQiMenThemeText),
        ),
      ]);
    }
    if (value.contains('心') || value.contains('辅')) {
      return _text([TextSpan(text: value, style: const TextStyle(color: kQiMenRed))]);
    }
    if (value.contains('任') || value.contains('冲')) {
      return _text([TextSpan(text: value, style: const TextStyle(color: kQiMenBlue))]);
    }
    // 安卓 else 分支显式设 Color.BLACK
    return _text([
      TextSpan(text: value, style: const TextStyle(color: Colors.black)),
    ]);
  }

  /// 八门：开/休/生 → 红，杜/景 → 蓝，均只染前 2 字；其余全黑
  Widget _doorText(String value) {
    if (value.isEmpty) return _text(const [TextSpan(text: '')]);

    Color? color;
    if (value.contains('开') || value.contains('休') || value.contains('生')) {
      color = kQiMenRed;
    } else if (value.contains('杜') || value.contains('景')) {
      color = kQiMenBlue;
    }
    if (color == null) {
      // 安卓 else 分支显式设 Color.BLACK
      return _text([
        TextSpan(text: value, style: const TextStyle(color: Colors.black)),
      ]);
    }
    if (value.length <= 2) {
      return _text([TextSpan(text: value, style: TextStyle(color: color))]);
    }
    return _text([
      TextSpan(text: value.substring(0, 2), style: TextStyle(color: color)),
      TextSpan(
        text: value.substring(2),
        style: const TextStyle(color: kQiMenThemeText),
      ),
    ]);
  }

  /// 八神：含 符/阴/合/地/天 → 红，否则黑
  Widget _godText(String value) {
    final red = value.contains('符') ||
        value.contains('阴') ||
        value.contains('合') ||
        value.contains('地') ||
        value.contains('天');
    return _text([
      TextSpan(text: value, style: TextStyle(color: red ? kQiMenRed : Colors.black)),
    ]);
  }

  Widget _text(List<TextSpan> spans, {Color? bg}) {
    final content = Text.rich(
      TextSpan(children: spans),
      style: TextStyle(fontSize: 16.sp),
      textAlign: TextAlign.center,
    );
    return bg == null ? content : Container(color: bg, child: content);
  }
}

/// 暗干飞支（左上角竖排，安卓显式 13sp）
///
/// 安卓 tv_an_gan 用 ems="1" 把宽度锁成一个字宽逼出逐字换行；
/// 这里直接逐字堆叠，不依赖断行算法与字体度量。
class AnGanText extends StatelessWidget {
  const AnGanText(this.value, {super.key});

  final String value;

  @override
  Widget build(BuildContext context) {
    if (value.isEmpty) return const SizedBox.shrink();
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        for (final ch in value.characters)
          Text(
            ch,
            style: TextStyle(
              fontSize: 13.sp,
              height: 1.2,
              color: kQiMenAnGanGray,
            ),
          ),
      ],
    );
  }
}
