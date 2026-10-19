import 'package:flutter/material.dart';

/// 炮制前缀标签配色：单色底用 [bg]，复合炮制用 [gradient]（135° 两段），文字统一 [foreground]。
typedef ZhongyiPrefixStyle = ({Color foreground, Color? bg, List<Color>? gradient});

const ZhongyiPrefixStyle _fallback = (
  foreground: Color(0xFF4B5563),
  bg: Color(0xFFF3F4F6),
  gradient: null,
);

const Map<String, ZhongyiPrefixStyle> _styles = {
  // 辅料
  '酒': (foreground: Color(0xFF7C4A2A), bg: Color(0xFFF5EDE4), gradient: null),
  '醋': (foreground: Color(0xFF2F6B4A), bg: Color(0xFFE8F3EB), gradient: null),
  '盐': (foreground: Color(0xFF4B5563), bg: Color(0xFFEEF2F6), gradient: null),
  '蜜': (foreground: Color(0xFF8B6914), bg: Color(0xFFFDF6E3), gradient: null),
  '姜': (foreground: Color(0xFF8A521F), bg: Color(0xFFFFF0D8), gradient: null),
  '麸': (foreground: Color(0xFF7A5C18), bg: Color(0xFFF8F0D8), gradient: null),
  '土': (foreground: Color(0xFF6B5344), bg: Color(0xFFEDE6DC), gradient: null),
  '米': (foreground: Color(0xFF7A5F2A), bg: Color(0xFFF7F2E7), gradient: null),
  '胆': (foreground: Color(0xFF2E6173), bg: Color(0xFFE8F1F5), gradient: null),
  // 处理状态
  '制': (foreground: Color(0xFF3D4F8C), bg: Color(0xFFE8EDF8), gradient: null),
  '生': (foreground: Color(0xFF2D6B45), bg: Color(0xFFE5F4EA), gradient: null),
  '熟': (foreground: Color(0xFF7A4E2E), bg: Color(0xFFF0E8DF), gradient: null),
  '鲜': (foreground: Color(0xFF1F6B56), bg: Color(0xFFE0F2EC), gradient: null),
  '清': (foreground: Color(0xFF1F6B62), bg: Color(0xFFE4F4F1), gradient: null),
  '法': (foreground: Color(0xFF4C4A86), bg: Color(0xFFEBEAF7), gradient: null),
  // 产地 / 品种
  '藏': (foreground: Color(0xFF6B3F7A), bg: Color(0xFFF0E8F5), gradient: null),
  '北': (foreground: Color(0xFF2E5082), bg: Color(0xFFE5EDF5), gradient: null),
  '南': (foreground: Color(0xFF1F6B62), bg: Color(0xFFE0F0ED), gradient: null),
  '红': (foreground: Color(0xFF9F3048), bg: Color(0xFFF8E8EB), gradient: null),
  '银': (foreground: Color(0xFF5C6570), bg: Color(0xFFECEFF3), gradient: null),
  // 单字炮制
  '炒': (foreground: Color(0xFFB42318), bg: Color(0xFFFCE8E6), gradient: null),
  '炙': (foreground: Color(0xFF9B2C24), bg: Color(0xFFF9D9D5), gradient: null),
  '蒸': (foreground: Color(0xFF2B6C8F), bg: Color(0xFFE3F0F8), gradient: null),
  '煮': (foreground: Color(0xFF1E5F82), bg: Color(0xFFD6EAF5), gradient: null),
  '炮': (foreground: Color(0xFF8B2E28), bg: Color(0xFFF5D5D0), gradient: null),
  '煅': (foreground: Color(0xFF3D4852), bg: Color(0xFFE4E8EC), gradient: null),
  '煨': (foreground: Color(0xFF8B5A2E), bg: Color(0xFFF5E8DC), gradient: null),
  '焙': (foreground: Color(0xFF8B6914), bg: Color(0xFFF5ECD8), gradient: null),
  '焦': (foreground: Color(0xFF6B5344), bg: Color(0xFFEDE6DF), gradient: null),
  '烫': (foreground: Color(0xFF7C4A2A), bg: Color(0xFFF3E4D8), gradient: null),
  // 复合炮制
  '麸炒': (foreground: Color(0xFF8B4518), bg: null, gradient: [Color(0xFFF8F0D8), Color(0xFFFCE8E6)]),
  '土炒': (foreground: Color(0xFF6B4423), bg: null, gradient: [Color(0xFFEDE6DC), Color(0xFFFCE8E6)]),
  '米炒': (foreground: Color(0xFF7A5F2A), bg: null, gradient: [Color(0xFFF7F2E7), Color(0xFFFCE8E6)]),
  '酒炒': (foreground: Color(0xFF7C4A2A), bg: null, gradient: [Color(0xFFF5EDE4), Color(0xFFFCE8E6)]),
  '醋炒': (foreground: Color(0xFF2F5C40), bg: null, gradient: [Color(0xFFE8F3EB), Color(0xFFFCE8E6)]),
  '盐炒': (foreground: Color(0xFF4B5563), bg: null, gradient: [Color(0xFFEEF2F6), Color(0xFFFCE8E6)]),
  '姜炒': (foreground: Color(0xFF8A521F), bg: null, gradient: [Color(0xFFFFF0D8), Color(0xFFFCE8E6)]),
  '蜜炙': (foreground: Color(0xFF8B6914), bg: null, gradient: [Color(0xFFFDF6E3), Color(0xFFF9D9D5)]),
  '酒炙': (foreground: Color(0xFF7C4A2A), bg: null, gradient: [Color(0xFFF5EDE4), Color(0xFFF9D9D5)]),
  '醋炙': (foreground: Color(0xFF2F6B4A), bg: null, gradient: [Color(0xFFE8F3EB), Color(0xFFF9D9D5)]),
  '盐炙': (foreground: Color(0xFF4B5563), bg: null, gradient: [Color(0xFFEEF2F6), Color(0xFFF9D9D5)]),
  '姜炙': (foreground: Color(0xFF8A521F), bg: null, gradient: [Color(0xFFFFF0D8), Color(0xFFF9D9D5)]),
  '酒蒸': (foreground: Color(0xFF6F4B35), bg: null, gradient: [Color(0xFFF5EDE4), Color(0xFFE3F0F8)]),
  '醋蒸': (foreground: Color(0xFF2F6B4A), bg: null, gradient: [Color(0xFFE8F3EB), Color(0xFFE3F0F8)]),
  '黑豆蒸': (foreground: Color(0xFF394150), bg: null, gradient: [Color(0xFFE7E8EC), Color(0xFFD6EAF5)]),
  '酒制': (foreground: Color(0xFF6F4B35), bg: null, gradient: [Color(0xFFF5EDE4), Color(0xFFE8EDF8)]),
  '醋制': (foreground: Color(0xFF2F6B4A), bg: null, gradient: [Color(0xFFE8F3EB), Color(0xFFE8EDF8)]),
  '盐制': (foreground: Color(0xFF4B5563), bg: null, gradient: [Color(0xFFEEF2F6), Color(0xFFE8EDF8)]),
  '姜制': (foreground: Color(0xFF8A521F), bg: null, gradient: [Color(0xFFFFF0D8), Color(0xFFE8EDF8)]),
  '蜜制': (foreground: Color(0xFF8B6914), bg: null, gradient: [Color(0xFFFDF6E3), Color(0xFFE8EDF8)]),
  '矾制': (foreground: Color(0xFF4B5563), bg: null, gradient: [Color(0xFFEEF2F6), Color(0xFFE8EDF8)]),
  '胆制': (foreground: Color(0xFF2E6173), bg: null, gradient: [Color(0xFFE8F1F5), Color(0xFFE8EDF8)]),
  '煅淬': (foreground: Color(0xFF3D4852), bg: null, gradient: [Color(0xFFE4E8EC), Color(0xFFD0D5DB)]),
  '清炒': (foreground: Color(0xFFB42318), bg: null, gradient: [Color(0xFFFDF2F1), Color(0xFFFCE8E6)]),
  '砂炒': (foreground: Color(0xFF7A5232), bg: null, gradient: [Color(0xFFEFE3D3), Color(0xFFFCE8E6)]),
  '砂烫': (foreground: Color(0xFF7A5232), bg: null, gradient: [Color(0xFFEFE3D3), Color(0xFFF3E4D8)]),
  '蛤粉炒': (foreground: Color(0xFF4B5563), bg: null, gradient: [Color(0xFFEEF2F6), Color(0xFFFCE8E6)]),
  '滑石粉炒': (foreground: Color(0xFF4B5563), bg: null, gradient: [Color(0xFFEEF2F6), Color(0xFFFCE8E6)]),
  '蒲黄炒': (foreground: Color(0xFF8B6914), bg: null, gradient: [Color(0xFFFDF6E3), Color(0xFFFCE8E6)]),
  '麸煨': (foreground: Color(0xFF7A5C18), bg: null, gradient: [Color(0xFFF8F0D8), Color(0xFFF5E8DC)]),
  '面煨': (foreground: Color(0xFF7A5C18), bg: null, gradient: [Color(0xFFF7F2E7), Color(0xFFF5E8DC)]),
};

ZhongyiPrefixStyle zhongyiPrefixStyleOf(String prefix) => _styles[prefix] ?? _fallback;

/// 前缀标签底色：渐变项构造 135° 线性渐变，单色项直接给色值。
BoxDecoration zhongyiPrefixDecoration(ZhongyiPrefixStyle style, {BorderRadius? borderRadius, BoxBorder? border}) {
  return BoxDecoration(
    color: style.gradient == null ? style.bg : null,
    gradient: style.gradient == null
        ? null
        : LinearGradient(begin: Alignment.topLeft, end: Alignment.bottomRight, colors: style.gradient!),
    borderRadius: borderRadius,
    border: border,
  );
}
