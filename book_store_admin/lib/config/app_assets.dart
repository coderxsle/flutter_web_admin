/// 应用资源管理类
/// 集中管理所有应用资源路径，避免硬编码字符串
class AppAssets {
  // 防止实例化
  AppAssets._();

  // 字体资源
  static const fonts = _Fonts();
  static const images = _Images();
  static const icons = _Icons();
  static const others = _Others();
  
  // 获取所有需要预加载的Web资源
  static List<String> get preloadWebAssets => [
    ...fonts.preloadFonts,
    // 添加其他需要预加载的资源
  ];
}

/// 字体资源管理类
class _Fonts {
  const _Fonts();
  
  // 字体名称
  String get notoSansSC => "NotoSansSC";
  String get sourceHanSansSC => "SourceHanSansSC";

  // 字体文件路径（与pubspec.yaml中保持一致）
  String get notoSansSCRegular => "web/assets/fonts/NotoSansSC-Regular.otf";
  String get notoSansSCMedium => "web/assets/fonts/NotoSansSC-Medium.otf";
  String get notoSansSCBold => "web/assets/fonts/NotoSansSC-Bold.otf";

  // Web优化字体 - 用于动态加载
  String get sourceHanSansSCRegularCommon => "web/assets/fonts/SourceHanSansSC-Regular-Common.woff2";
  String get sourceHanSansSCRegularLatin => "web/assets/fonts/SourceHanSansSC-Regular-Latin.woff2";

  // 获取所有预加载字体资源
  List<String> get preloadFonts => [
    sourceHanSansSCRegularCommon,
    sourceHanSansSCRegularLatin,
    notoSansSCRegular,
    notoSansSCMedium,
    notoSansSCBold,
  ];
}

/// 图片资源管理类
class _Images {
  const _Images();
  
  String get logo => "assets/images/logo.png";
  String get placeholder => "assets/images/placeholder.png";

  // 根据需要添加更多图片资源
}

/// 图标资源管理类
class _Icons {
  const _Icons();
  
  String get appIcon => "assets/icons/app_icon.png";
  // 根据需要添加更多图标资源
}

/// 其他资源管理类
class _Others {
  const _Others();
  
  // 可添加其他资源类型
} 