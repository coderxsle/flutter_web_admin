/// 字体配置
/// 统一管理应用中的所有字体设置
class FontConfig {
  FontConfig._();

  // ================================================
  // 字体家族定义
  // ================================================
  
  /// 主要字体（英文/数字）
  static const String primaryFont = 'Roboto';
  
  /// 次要字体（用于特殊场景）
  static const String secondaryFont = 'Roboto';
  
  /// 中文字体（注意：必须与 web/index.html 中的 @font-face 名称一致）
  static const String chineseFont = 'NotoSansSC';
  
  /// 代码/等宽字体
  static const String monoFont = 'RobotoMono';

  // ================================================
  // 字体栈配置（Fallback）
  // ================================================
  
  /// 标准字体栈 - 适用于大部分场景
  /// 优先使用 Roboto，中文回退到 NotoSansSC
  static const List<String> standardFontFamily = [
    primaryFont,
    chineseFont,
  ];
  
  /// 标题字体栈 - 适用于标题、导航等
  static const List<String> headingFontFamily = [
    primaryFont,
    chineseFont,
  ];
  
  /// 正文字体栈 - 适用于正文、段落等
  static const List<String> bodyFontFamily = [
    primaryFont,
    chineseFont,
  ];
  
  /// 代码字体栈 - 适用于代码显示
  static const List<String> monoFontFamily = [
    monoFont,
    primaryFont,
  ];

  // ================================================
  // 字体权重映射
  // ================================================
  
  /// 超细体
  static const int thin = 100;
  
  /// 特细体
  static const int extraLight = 200;
  
  /// 细体
  static const int light = 300;
  
  /// 常规
  static const int regular = 400;
  
  /// 中等
  static const int medium = 500;
  
  /// 半粗
  static const int semiBold = 600;
  
  /// 粗体
  static const int bold = 700;
  
  /// 特粗
  static const int extraBold = 800;
  
  /// 黑体
  static const int black = 900;

  // ================================================
  // 辅助方法
  // ================================================
  
  /// 获取字体家族名称（用于 ThemeData.fontFamily）
  /// 注意：ThemeData.fontFamily 只接受单个字符串，不支持数组
  static String get defaultFontFamily => primaryFont;
  
  /// 获取字体家族列表（用于 TextStyle.fontFamilyFallback）
  /// 注意：首选字体应该在 TextStyle.fontFamily 中设置
  static List<String> get defaultFontFallback => [chineseFont];
  
  /// 构建完整的字体栈配置
  /// 返回格式：{fontFamily: 主字体, fontFamilyFallback: [备用字体列表]}
  static Map<String, dynamic> buildFontStack({
    String? primaryFont,
    List<String>? fallbackFonts,
  }) {
    return {
      'fontFamily': primaryFont ?? defaultFontFamily,
      'fontFamilyFallback': fallbackFonts ?? defaultFontFallback,
    };
  }
}

