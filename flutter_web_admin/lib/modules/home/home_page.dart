import 'dart:math' as math;
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/state_manager.dart';
import 'package:flutter_web_admin/modules/home/home_controller.dart';
import 'package:flutter_web_admin/components/gi_arco.dart';
import 'package:flutter_web_admin/theme/extensions/theme_extension.dart';
import 'package:url_launcher/url_launcher.dart';

class HomePage extends GetView<HomeController> {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder(init: HomeController(), builder: (controller) {
      return Scaffold(
        body: SingleChildScrollView(
          child: Column(
            children: [
              _buildHeroSection(context),
              _buildTechStackSection(context),
              _buildFeaturesSection(context),
              _buildComparisonSection(context),
              _buildQuickStartSection(context),
              _buildCoreModulesSection(context),
              _buildUseCasesSection(context),
              _buildCommunitySection(context),
              _buildFooter(context),
            ],
          ),
        ),
      );
    });
  }

  // 1. Hero 区域
  Widget _buildHeroSection(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 80, horizontal: 40),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            const Color(0xFF165DFF).withValues(alpha: 0.05),
            const Color(0xFF00B42A).withValues(alpha: 0.05),
          ],
        ),
      ),
      child: Center(
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 1200),
          child: Column(
            children: [
              // 标题
              Text(
                '⚡ 使用 Serverpod + Flutter 构建下一代 Web Admin 系统',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 48,
                  fontWeight: FontWeight.bold,
                  height: 1.2,
                  color: context.themeColors.textPrimary,
                ),
              ),
              const SizedBox(height: 24),
              // 副标题
              Text(
                '性能卓越 · 全栈类型安全 · 开箱即用 · 现代化设计',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 20,
                  color: Colors.grey[700],
                  height: 1.5,
                ),
              ),
              const SizedBox(height: 40),
              // 徽章
              Wrap(
                spacing: 12,
                runSpacing: 12,
                alignment: WrapAlignment.center,
                children: [
                  _buildBadge('Serverpod', Colors.blue),
                  _buildBadge('Flutter', const Color(0xFF02569B)),
                  _buildBadge('Dart', const Color(0xFF0175C2)),
                  _buildBadge('PostgreSQL', const Color(0xFF336791)),
                  _buildBadge('MIT License', Colors.green),
                ],
              ),
              const SizedBox(height: 40),
              // 按钮组
              Wrap(
                spacing: 16,
                runSpacing: 16,
                alignment: WrapAlignment.center,
                children: [
                  GiArcoButton(
                    type: GiArcoButtonType.primary,
                    size: GiArcoButtonSize.large,
                    text: '🚀 快速开始',
                    onPressed: () {},
                  ),
                  GiArcoButton(
                    type: GiArcoButtonType.outline,
                    size: GiArcoButtonSize.large,
                    text: '📖 查看文档',
                    onPressed: () {},
                  ),
                  GiArcoButton(
                    type: GiArcoButtonType.outline,
                    size: GiArcoButtonSize.large,
                    text: '🎨 在线 Demo',
                    onPressed: () {},
                  ),
                  GiArcoButton(
                    type: GiArcoButtonType.normal,
                    size: GiArcoButtonSize.large,
                    icon: Icons.star_border,
                    text: 'GitHub Star',
                    onPressed: () {},
                  ),
                ],
              ),
              const SizedBox(height: 60),
              // 项目统计
              Wrap(
                spacing: 40,
                runSpacing: 20,
                alignment: WrapAlignment.center,
                children: [
                  _buildStatItem('⭐', '1.2K', 'Stars'),
                  _buildStatItem('🔱', '234', 'Forks'),
                  _buildStatItem('👥', '45', 'Contributors'),
                  _buildStatItem('📝', '1.5K+', 'Commits'),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  // 2. 技术栈展示
  Widget _buildTechStackSection(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 60, horizontal: 40),
      child: Center(
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 1200),
          child: Column(
            children: [
              const Text(
                '🛠️ 技术栈',
                style: TextStyle(
                  fontSize: 36,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 40),
              Wrap(
                spacing: 24,
                runSpacing: 24,
                alignment: WrapAlignment.center,
                children: [
                  _buildTechCard('Serverpod', '高性能后端框架', 'serverpod.png'),
                  _buildTechCard('Flutter', '跨平台前端', 'flutter.png'),
                  _buildTechCard('Dart', '全栈统一语言', 'dart.png'),
                  _buildTechCard('PostgreSQL', '强大的数据库', 'postgresql.png'),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  // 3. 功能亮点
  Widget _buildFeaturesSection(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 60, horizontal: 40),
      child: Center(
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 1200),
          child: Column(
            children: [
              const Text(
                '✨ 核心特性',
                style: TextStyle(
                  fontSize: 36,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 40),
              Wrap(
                spacing: 24,
                runSpacing: 24,
                children: [
                  _buildFeatureCard(
                    '🌐',
                    '跨平台',
                    'Flutter Web Admin，一套代码多端可用（Web、Desktop、Mobile）',
                  ),
                  _buildFeatureCard(
                    '🚀',
                    '高性能后端',
                    'Serverpod + PostgreSQL，支持实时通信、自动 API 生成、类型安全',
                  ),
                  _buildFeatureCard(
                    '📦',
                    '开箱即用',
                    '内置用户管理、权限系统、菜单管理、角色管理等核心功能模块',
                  ),
                  _buildFeatureCard(
                    '🎨',
                    '现代 UI',
                    '丰富的自定义组件，支持深色模式、响应式布局',
                  ),
                  _buildFeatureCard(
                    '🔧',
                    '模块化设计',
                    '可扩展性强，方便二次开发',
                  ),
                  _buildFeatureCard(
                    '🔐',
                    '全栈类型安全',
                    '从数据库到 UI，完整的类型检查',
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  // 4. 对比优势表格
  Widget _buildComparisonSection(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 60, horizontal: 40),
      child: Center(
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 1200),
          child: Column(
            children: [
              const Text(
                '🏆 对比优势',
                style: TextStyle(
                  fontSize: 36,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 40),
              _buildComparisonTable(context),
            ],
          ),
        ),
      ),
    );
  }

  // 5. 快速上手
  Widget _buildQuickStartSection(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 60, horizontal: 40),
      child: Center(
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 1200),
          child: Column(
            children: [
              const Text(
                '🚀 快速开始',
                style: TextStyle(
                  fontSize: 36,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 40),
              _buildQuickStartSteps(),
            ],
          ),
        ),
      ),
    );
  }

  // 6. 核心功能预览
  Widget _buildCoreModulesSection(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 60, horizontal: 40),
      child: Center(
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 1200),
          child: Column(
            children: [
              const Text(
                '📦 核心功能',
                style: TextStyle(
                  fontSize: 36,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 40),
              Wrap(
                spacing: 24,
                runSpacing: 24,
                children: [
                  _buildModuleCard('🔐', '权限管理', '角色/菜单\n细粒度控制'),
                  _buildModuleCard('📊', '数据看板', '实时图表\n数据可视化'),
                  _buildModuleCard('🎨', '主题切换', '深色/浅色\n自定义主题'),
                  _buildModuleCard('📝', '表单系统', '验证/布局\n动态表单'),
                  _buildModuleCard('📋', '表格组件', '排序/筛选\n分页/导出'),
                  _buildModuleCard('🌍', '国际化', '多语言支持\n动态切换'),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  // 7. 使用场景
  Widget _buildUseCasesSection(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 60, horizontal: 40),
      child: Center(
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 1200),
          child: Column(
            children: [
              const Text(
                '💼 使用场景',
                style: TextStyle(
                  fontSize: 36,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 40),
              Wrap(
                spacing: 24,
                runSpacing: 24,
                children: [
                  _buildUseCaseCard('🏢', '企业内部管理系统', 'OA、ERP、CRM 等'),
                  _buildUseCaseCard('💼', 'SaaS 后台管理', '多租户管理平台'),
                  _buildUseCaseCard('📈', '数据可视化平台', 'BI 报表、监控面板'),
                  _buildUseCaseCard('🚀', '个人项目脚手架', '快速启动全栈项目'),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  // 8. 社区与贡献
  Widget _buildCommunitySection(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 60, horizontal: 40),
      child: Center(
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 1200),
          child: Column(
            children: [
              const Text(
                '👥 社区与贡献',
                style: TextStyle(
                  fontSize: 36,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 40),
              Wrap(
                spacing: 24,
                runSpacing: 24,
                alignment: WrapAlignment.center,
                children: [
                  _buildCommunityCard('💬', 'GitHub Discussions', '技术讨论'),
                  _buildCommunityCard('🐛', 'Issue Tracker', '问题反馈'),
                  _buildCommunityCard('🤝', 'Contributing', '贡献指南'),
                  _buildCommunityCard('📚', 'Documentation', '完整文档'),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  // 9. Footer
  Widget _buildFooter(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 40, horizontal: 40),
      color: const Color(0xFF1D2129),
      child: Center(
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 1200),
          child: Column(
            children: [
              Wrap(
                spacing: 40,
                runSpacing: 20,
                alignment: WrapAlignment.center,
                children: [
                  _buildFooterLink('Serverpod 官网', 'https://serverpod.dev'),
                  _buildFooterLink('Flutter 官网', 'https://flutter.dev'),
                  _buildFooterLink('Dart 官网', 'https://dart.dev'),
                  _buildFooterLink('项目文档', '#'),
                ],
              ),
              const SizedBox(height: 30),
              const Divider(color: Colors.white24),
              const SizedBox(height: 30),
              Text(
                '© 2025 Serverpod + Flutter Admin. Released under MIT License.',
                style: TextStyle(
                  color: Colors.grey[400],
                  fontSize: 14,
                ),
              ),
              const SizedBox(height: 10),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'Made with ',
                    style: TextStyle(color: Colors.grey[400]),
                  ),
                  const Icon(Icons.favorite, color: Colors.red, size: 16),
                  Text(
                    ' by Open Source Community',
                    style: TextStyle(color: Colors.grey[400]),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  // ========== 辅助组件 ==========

  Widget _buildBadge(String text, Color color) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      decoration: BoxDecoration(
        color: color.withValues(alpha: 0.1),
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: color.withValues(alpha: 0.3)),
      ),
      child: Text(
        text,
        style: TextStyle(
          color: color,
          fontWeight: FontWeight.w600,
          fontSize: 14,
        ),
      ),
    );
  }

  Widget _buildStatItem(String icon, String value, String label) {
    return Column(
      children: [
        Text(
          icon,
          style: const TextStyle(fontSize: 32),
        ),
        const SizedBox(height: 8),
        Text(
          value,
          style: const TextStyle(
            fontSize: 28,
            fontWeight: FontWeight.bold,
            color: Color(0xFF165DFF),
          ),
        ),
        const SizedBox(height: 4),
        Text(
          label,
          style: TextStyle(
            fontSize: 14,
            color: Colors.grey[600],
          ),
        ),
      ],
    );
  }

  Widget _buildTechCard(String title, String subtitle, String image) {
    return _AnimatedGradientCard(
      width: 260,
      child: Column(
        children: [
          // Icon(icon, size: 48, color: const Color(0xFF165DFF)),
          Image.asset('assets/images/$image', width: 48, height: 48),
          const SizedBox(height: 16),
          Text(
            title,
            style: const TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            subtitle,
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 14,
              color: Colors.grey[600],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildFeatureCard(String icon, String title, String description) {
    return _AnimatedGradientCard(
      width: 360,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            icon,
            style: const TextStyle(fontSize: 32),
          ),
          const SizedBox(height: 12),
          Text(
            title,
            style: const TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            description,
            style: TextStyle(
              fontSize: 14,
              color: Colors.grey[600],
              height: 1.5,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildComparisonTable(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: context.themeColors.bgContainer,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: context.themeColors.borderLight),
      ),
      child: Table(
        border: TableBorder.symmetric(
          inside: BorderSide(color: context.themeColors.borderLight),
        ),
        columnWidths: const {
          0: FlexColumnWidth(2),
          1: FlexColumnWidth(3),
          2: FlexColumnWidth(3),
        },
        children: [
          _buildTableRow(context, '特性', '传统方案', '本项目', isHeader: true),
          _buildTableRow(context, '后端语言', 'Node.js/Java/Python', '✅Dart（全栈统一）'),
          _buildTableRow(context, '前端框架', 'React/Vue/Angular', '✅Flutter Web'),
          _buildTableRow(context, '类型安全', '部分支持', '✅ 全栈类型安全'),
          _buildTableRow(context, '学习曲线', '需要学习多种技术栈', '✅一种语言搞定'),
          _buildTableRow(context, '移动端支持', '需要单独开发', '✅ 一套代码多端'),
          _buildTableRow(context, 'API 生成', '需要手动编写', '✅ 自动生成'),
          _buildTableRow(context, '实时通信', '需要额外配置', '✅ 内置支持'),
        ],
      ),
    );
  }

  TableRow _buildTableRow(BuildContext context, String col1, String col2, String col3, {bool isHeader = false}) {
    final textStyle = TextStyle(
      fontSize: 14,
      fontWeight: isHeader ? FontWeight.bold : FontWeight.normal,
      color: isHeader ? context.themeColors.textPrimary : context.themeColors.textSecondary,
    );

    return TableRow(
      decoration: BoxDecoration(
        color: isHeader ? context.themeColors.bgContainer : context.themeColors.bgLayout,
      ),
      children: [
        Padding(
          padding: const EdgeInsets.all(16),
          child: Text(col1, style: textStyle),
        ),
        Padding(
          padding: const EdgeInsets.all(16),
          child: Text(col2, style: textStyle),
        ),
        Padding(
          padding: const EdgeInsets.all(16),
          child: Text(col3, style: textStyle),
        ),
      ],
    );
  }

  Widget _buildQuickStartSteps() {
    const codeExample = '''# 克隆项目
git clone https://github.com/your-repo/project-name.git

# 启动后端
cd server
dart pub get
dart run bin/main.dart

# 启动前端
cd ../client
flutter pub get
flutter run -d chrome''';

    return Container(
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        color: const Color(0xFF1D2129),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              const Icon(Icons.code, color: Colors.white),
              const SizedBox(width: 8),
              const Text(
                '5分钟本地运行',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const Spacer(),
              GiArcoButton(
                type: GiArcoButtonType.primary,
                size: GiArcoButtonSize.small,
                icon: Icons.copy,
                text: '复制',
                onPressed: () {
                  Clipboard.setData(const ClipboardData(text: codeExample));
                },
              ),
            ],
          ),
          const SizedBox(height: 16),
          SelectableText(
            codeExample,
            style: TextStyle(
              color: Colors.grey[300],
              fontSize: 14,
              fontFamily: 'monospace',
              height: 1.6,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildModuleCard(String icon, String title, String description) {
    return _AnimatedGradientCard(
      width: 180,
      child: Column(
        children: [
          Text(icon, style: const TextStyle(fontSize: 40)),
          const SizedBox(height: 12),
          Text(
            title,
            style: const TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            description,
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 12,
              color: Colors.grey[600],
              height: 1.4,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildUseCaseCard(String icon, String title, String description) {
    return _AnimatedGradientCard(
      width: 280,
      child: Column(
        children: [
          Text(icon, style: const TextStyle(fontSize: 48)),
          const SizedBox(height: 16),
          Text(
            title,
            textAlign: TextAlign.center,
            style: const TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            description,
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 14,
              color: Colors.grey[600],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildCommunityCard(String icon, String title, String description) {
    return _AnimatedGradientCard(
      width: 260,
      child: Column(
        children: [
          Text(icon, style: const TextStyle(fontSize: 40)),
          const SizedBox(height: 12),
          Text(
            title,
            style: const TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            description,
            style: TextStyle(
              fontSize: 14,
              color: Colors.grey[600],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildFooterLink(String text, String url) {
    return MouseRegion(
      cursor: SystemMouseCursors.click,
      child: GestureDetector(
        onTap: () async {
          final uri = Uri.parse(url);
          if (await canLaunchUrl(uri)) {
            await launchUrl(uri);
          }
        },
        child: Text(
          text,
          style: TextStyle(
            color: Colors.grey[400],
            fontSize: 14,
            decoration: TextDecoration.underline,
          ),
        ),
      ),
    );
  }
}

// 带渐变旋转边框和悬停动画的卡片组件
class _AnimatedGradientCard extends StatefulWidget {
  final Widget child;
  final double? width;

  const _AnimatedGradientCard({
    required this.child,
    this.width,
  });

  @override
  State<_AnimatedGradientCard> createState() => _AnimatedGradientCardState();
}

class _AnimatedGradientCardState extends State<_AnimatedGradientCard>
    with SingleTickerProviderStateMixin {
  bool _isHovered = false;
  late AnimationController _rotationController;

  @override
  void initState() {
    super.initState();
    _rotationController = AnimationController(
      // 追光动画从3秒改为1.5秒，速度加快一倍
      duration: const Duration(milliseconds: 2000), 
      vsync: this,
    );
    // 不再自动启动，只在悬停时启动
  }

  @override
  void dispose() {
    _rotationController.dispose();
    super.dispose();
  }

  void _onHoverEnter() {
    setState(() => _isHovered = true);
    _rotationController.repeat(); // 悬停时才启动动画
  }

  void _onHoverExit() {
    setState(() => _isHovered = false);
    _rotationController.stop(); // 离开时立即停止
  }

  @override
  Widget build(BuildContext context) {
    return RepaintBoundary(
      child: MouseRegion(
        onEnter: (_) => _onHoverEnter(),
        onExit: (_) => _onHoverExit(),
        child: AnimatedContainer(
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeOutCubic,
        transform: Matrix4.identity()
          ..translate(0.0, _isHovered ? -8.0 : 0.0)
          ..scale(_isHovered ? 1.02 : 1.0),
        child: Container(
          width: widget.width,
          decoration: BoxDecoration(
            color: context.themeColors.bgContainer,
            borderRadius: BorderRadius.circular(12),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withValues(alpha: _isHovered ? 0.15 : 0.05),
                blurRadius: _isHovered ? 20 : 10,
                offset: Offset(0, _isHovered ? 10 : 2),
              ),
            ],
          ),
          child: AnimatedBuilder(
            animation: _rotationController,
            builder: (context, child) {
              return CustomPaint(
                painter: _isHovered
                    ? _GradientBorderPainter(
                        rotation: _rotationController.value * 2 * math.pi,
                        gradientColors: const [
                          Color.fromARGB(255, 238, 10, 10),
                          Color.fromARGB(255, 240, 244, 3),
                          Color.fromARGB(255, 20, 222, 67),
                          Color.fromARGB(255, 34, 97, 243),
                          Color.fromARGB(255, 20, 222, 67),
                          Color.fromARGB(255, 240, 244, 3),
                          Color.fromARGB(255, 238, 10, 10),
                          Color.fromARGB(255, 20, 222, 67),
                        ],
                      )
                    : null,
                child: Container(
                  padding: const EdgeInsets.all(24),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(12),
                    border: _isHovered
                        ? null
                        : Border.all(color: context.themeColors.borderLight),
                  ),
                  child: widget.child,
                ),
              );
            },
          ),
        ),
      ),
    ));
  }
}

// 渐变边框绘制器 - 追光效果
class _GradientBorderPainter extends CustomPainter {
  final double rotation;
  final List<Color> gradientColors;

  _GradientBorderPainter({
    required this.rotation,
    required this.gradientColors,
  });

  // 复用 Paint 对象池，减少内存分配
  static final _reusablePaint = Paint()
    ..style = PaintingStyle.stroke
    ..strokeCap = StrokeCap.round
    ..strokeJoin = StrokeJoin.round;

  @override
  void paint(Canvas canvas, Size size) {
    final rect = Offset.zero & size;
    final borderRadius = 12.0;
    final rrect = RRect.fromRectAndRadius(rect, Radius.circular(borderRadius));

    // 创建路径
    final path = Path()..addRRect(rrect);
    final pathMetrics = path.computeMetrics().first;
    final totalLength = pathMetrics.length;

    // 计算当前偏移量（0.0 到 1.0）
    final progress = rotation / (2 * math.pi);

    // 将路径分成多个小段，每段绘制不同颜色
    const segments = 60; // 优化：从200减少到60，降低绘制开销

    for (int layer = 0; layer < 3; layer++) {
      // 从2.5改为1.5,线条更细
      final layerWidth = 2 - layer * 0.3;
      final layerOpacity = 1.0 - layer * 0.15;

      for (int i = 0; i < segments; i++) {
        final segmentStart = i / segments;
        final segmentEnd = (i + 1) / segments;

        // 计算当前段的颜色（加上进度偏移，使用 1.0 - progress 实现顺时针）
        final colorPosition = (segmentStart - progress) % 1.0;
        final colorIndex = (colorPosition * (gradientColors.length - 1)).floor();
        final nextColorIndex = math.min(colorIndex + 1, gradientColors.length - 1);
        final colorProgress = colorPosition * (gradientColors.length - 1) - colorIndex;

        final segmentColor = Color.lerp(
          gradientColors[colorIndex],
          gradientColors[nextColorIndex],
          colorProgress,
        )!;

        // 提取路径段
        final startDistance = segmentStart * totalLength;
        final endDistance = segmentEnd * totalLength;
        final segmentPath = pathMetrics.extractPath(startDistance, endDistance);

        // 复用 Paint 对象，只更新颜色和宽度
        _reusablePaint
          ..color = segmentColor.withValues(alpha: layerOpacity)
          ..strokeWidth = layerWidth;

        canvas.drawPath(segmentPath, _reusablePaint);
      }
    }
  }

  @override
  bool shouldRepaint(_GradientBorderPainter oldDelegate) {
    return oldDelegate.rotation != rotation;
  }
}
