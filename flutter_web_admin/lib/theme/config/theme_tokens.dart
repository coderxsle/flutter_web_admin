/// 设计令牌 (Design Tokens)
/// 定义了间距、字号、圆角、阴影等基础设计规范
class ThemeTokens {
  ThemeTokens._();

  // ================================================
  // 间距系统 (Spacing) - 基数 4px
  // ================================================
  static const double spacingXs = 4.0;    // 超小间距
  static const double spacingSm = 8.0;    // 小间距
  static const double spacingMd = 12.0;   // 中等间距
  static const double spacingLg = 16.0;   // 大间距
  static const double spacingXl = 20.0;   // 超大间距
  static const double spacing2Xl = 24.0;  // 2倍超大间距
  static const double spacing3Xl = 32.0;  // 3倍超大间距
  static const double spacing4Xl = 40.0;  // 4倍超大间距
  static const double spacing5Xl = 48.0;  // 5倍超大间距

  // ================================================
  // 字号系统 (Font Size)
  // ================================================
  static const double fontSizeXs = 12.0;   // 超小字号
  static const double fontSizeSm = 14.0;   // 小字号
  static const double fontSizeMd = 16.0;   // 中等字号 (正文)
  static const double fontSizeLg = 18.0;   // 大字号
  static const double fontSizeXl = 20.0;   // 超大字号
  static const double fontSize2Xl = 24.0;  // 2倍超大字号
  static const double fontSize3Xl = 28.0;  // 3倍超大字号
  static const double fontSize4Xl = 32.0;  // 4倍超大字号
  static const double fontSize5Xl = 36.0;  // 5倍超大字号

  // ================================================
  // 字重系统 (Font Weight)
  // ================================================
  static const int fontWeightLight = 300;   // 细体
  static const int fontWeightRegular = 400; // 常规
  static const int fontWeightMedium = 500;  // 中等
  static const int fontWeightSemiBold = 600;// 半粗
  static const int fontWeightBold = 700;    // 粗体

  // ================================================
  // 行高系统 (Line Height)
  // ================================================
  static const double lineHeightTight = 1.2;   // 紧凑行高
  static const double lineHeightNormal = 1.5;  // 标准行高
  static const double lineHeightRelaxed = 1.75;// 宽松行高
  static const double lineHeightLoose = 2.0;   // 超宽松行高

  // ================================================
  // 圆角系统 (Border Radius)
  // ================================================
  static const double radiusNone = 0.0;    // 无圆角
  static const double radiusXs = 2.0;      // 超小圆角
  static const double radiusSm = 4.0;      // 小圆角
  static const double radiusMd = 8.0;      // 中等圆角
  static const double radiusLg = 12.0;     // 大圆角
  static const double radiusXl = 16.0;     // 超大圆角
  static const double radius2Xl = 20.0;    // 2倍超大圆角
  static const double radiusFull = 9999.0; // 完全圆角

  // ================================================
  // 边框宽度 (Border Width)
  // ================================================
  static const double borderWidthNone = 0.0;  // 无边框
  static const double borderWidthThin = 1.0;  // 细边框
  static const double borderWidthMedium = 2.0;// 中等边框
  static const double borderWidthThick = 4.0; // 粗边框

  // ================================================
  // 阴影系统 (Elevation/Shadow)
  // ================================================
  static const double elevationNone = 0.0;   // 无阴影
  static const double elevationXs = 1.0;     // 超小阴影
  static const double elevationSm = 2.0;     // 小阴影
  static const double elevationMd = 4.0;     // 中等阴影
  static const double elevationLg = 8.0;     // 大阴影
  static const double elevationXl = 12.0;    // 超大阴影
  static const double elevation2Xl = 16.0;   // 2倍超大阴影
  static const double elevation3Xl = 24.0;   // 3倍超大阴影

  // ================================================
  // 透明度 (Opacity)
  // ================================================
  static const double opacityDisabled = 0.4;  // 禁用状态透明度
  static const double opacityHover = 0.8;     // 悬停状态透明度
  static const double opacityPressed = 0.6;   // 按下状态透明度
  static const double opacityMask = 0.5;      // 遮罩透明度

  // ================================================
  // 动画时长 (Duration)
  // ================================================
  static const int durationFast = 100;     // 快速动画 (ms)
  static const int durationNormal = 200;   // 标准动画 (ms)
  static const int durationSlow = 300;     // 慢速动画 (ms)
  static const int durationSlower = 500;   // 更慢动画 (ms)

  // ================================================
  // 图标尺寸 (Icon Size)
  // ================================================
  static const double iconSizeXs = 12.0;   // 超小图标
  static const double iconSizeSm = 16.0;   // 小图标
  static const double iconSizeMd = 20.0;   // 中等图标
  static const double iconSizeLg = 24.0;   // 大图标
  static const double iconSizeXl = 32.0;   // 超大图标
  static const double iconSize2Xl = 40.0;  // 2倍超大图标
  static const double iconSize3Xl = 48.0;  // 3倍超大图标

  // ================================================
  // 容器尺寸 (Container Size)
  // ================================================
  static const double containerWidthXs = 320.0;   // 超小容器宽度
  static const double containerWidthSm = 640.0;   // 小容器宽度
  static const double containerWidthMd = 768.0;   // 中等容器宽度
  static const double containerWidthLg = 1024.0;  // 大容器宽度
  static const double containerWidthXl = 1280.0;  // 超大容器宽度
  static const double containerWidth2Xl = 1536.0; // 2倍超大容器宽度

  // ================================================
  // Z-Index 层级
  // ================================================
  static const int zIndexBase = 0;          // 基础层级
  static const int zIndexDropdown = 1000;   // 下拉菜单层级
  static const int zIndexSticky = 1100;     // 粘性定位层级
  static const int zIndexFixed = 1200;      // 固定定位层级
  static const int zIndexDrawer = 1300;     // 抽屉层级
  static const int zIndexModal = 1400;      // 模态框层级
  static const int zIndexPopover = 1500;    // 气泡卡片层级
  static const int zIndexTooltip = 1600;    // 工具提示层级
  static const int zIndexNotification = 1700; // 通知层级
}
