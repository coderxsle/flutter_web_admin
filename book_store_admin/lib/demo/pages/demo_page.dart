import 'package:book_store_admin/components/button/gi_arco_button.dart';
import 'package:book_store_admin/components/common/gi_space.dart';
import 'package:book_store_admin/components/feedback/gi_message.dart';
import 'package:flutter/material.dart';
import 'gi_arco_button_page.dart';
import 'gi_tag_page.dart';

/// Demo 展示页面 - 仿照 Vue demo 的左右布局结构
class DemoPage extends StatefulWidget {
  const DemoPage({super.key});

  @override
  State<DemoPage> createState() => _DemoPageState();
}

class _DemoPageState extends State<DemoPage> with SingleTickerProviderStateMixin {
  int selectedIndex = 0;
  late TabController _tabController;

  // 菜单列表
  final List<DemoMenuItem> menuList = [
    DemoMenuItem(name: '接口测试', icon: Icons.api),
    DemoMenuItem(name: '按钮', icon: Icons.smart_button),
    DemoMenuItem(name: 'GiTag', icon: Icons.label),
    DemoMenuItem(name: 'GiSpace', icon: Icons.space_bar),
    DemoMenuItem(name: 'GiIconBox', icon: Icons.widgets),
    DemoMenuItem(name: 'GiDot', icon: Icons.circle),
    DemoMenuItem(name: 'GiIconSelector', icon: Icons.select_all),
    DemoMenuItem(name: '函数调用模态框', icon: Icons.call_to_action),
    DemoMenuItem(name: '横向树表格', icon: Icons.table_view),
    DemoMenuItem(name: '省市区', icon: Icons.location_on),
    DemoMenuItem(name: '富文本', icon: Icons.text_fields),
    DemoMenuItem(name: '地图', icon: Icons.map),
    DemoMenuItem(name: 'Mitt中央通信', icon: Icons.connect_without_contact),
    DemoMenuItem(name: '函数式组件', icon: Icons.functions),
  ];

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: menuList.length, vsync: this);
    _tabController.addListener(() {
      if (_tabController.indexIsChanging) {
        setState(() {
          selectedIndex = _tabController.index;
        });
      }
    });
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Gi Flutter Admin - 组件展示'),
      ),
      body: Row(
        children: [
          // 左侧菜单栏
          _buildLeftMenu(context),
          // 分割线
          Container(
            width: 1,
            color: Theme.of(context).dividerColor,
          ),
          // 右侧内容区域
          Expanded(
            child: _buildRightContent(context),
          ),
        ],
      ),
    );
  }

  /// 构建左侧菜单栏
  Widget _buildLeftMenu(BuildContext context) {
    return Container(
      width: 200,
      color: Theme.of(context).cardColor,
      child: Column(
        children: [
          // 菜单标题
          Container(
            padding: const EdgeInsets.all(16),
            child: Text(
              '组件展示',
              style: Theme.of(context).textTheme.titleMedium?.copyWith(
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          const Divider(height: 1),
          // 菜单列表
          Expanded(
            child: ListView.builder(
              padding: const EdgeInsets.symmetric(vertical: 8),
              itemCount: menuList.length,
              itemBuilder: (context, index) {
                final item = menuList[index];
                final isSelected = selectedIndex == index;
                
                return Container(
                  margin: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                  child: Material(
                    color: isSelected 
                        ? Theme.of(context).primaryColor.withOpacity(0.08)
                        : Colors.transparent,
                    borderRadius: BorderRadius.circular(8),
                    child: InkWell(
                      borderRadius: BorderRadius.circular(8),
                      onTap: () {
                        setState(() {
                          selectedIndex = index;
                          _tabController.animateTo(index);
                        });
                      },
                      child: Container(
                        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                        child: Row(
                          children: [
                            Icon(
                              item.icon,
                              size: 18,
                              color: isSelected
                                  ? Theme.of(context).primaryColor
                                  : Theme.of(context).iconTheme.color,
                            ),
                            const SizedBox(width: 12),
                            Expanded(
                              child: Text(
                                item.name,
                                style: TextStyle(
                                  fontSize: 14,
                                  color: isSelected
                                      ? Theme.of(context).primaryColor
                                      : Theme.of(context).textTheme.bodyMedium?.color,
                                  fontWeight: isSelected ? FontWeight.w600 : FontWeight.normal,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  /// 构建右侧内容区域
  Widget _buildRightContent(BuildContext context) {
    return Container(
      color: Theme.of(context).scaffoldBackgroundColor,
      child: TabBarView(
        controller: _tabController,
        children: [
          _buildApiTestPage(),
          const GiArcoButtonDemoPage(),
          const GiTagDemoPage(),
          _buildSpacePage(),
          _buildIconBoxPage(),
          _buildDotPage(),
          _buildIconSelectorPage(),
          _buildModalPage(),
          _buildTablePage(),
          _buildAreaPage(),
          _buildEditorPage(),
          _buildMapPage(),
          _buildMittPage(),
          _buildFnComponentPage(),
        ],
      ),
    );
  }

  /// API 测试页面
  Widget _buildApiTestPage() {
    return _buildPageContainer(
      title: '接口测试',
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Card(
            child: Padding(
              padding: const EdgeInsets.all(24),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    '🌐 API 接口测试',
                    style: Theme.of(context).textTheme.titleLarge,
                  ),
                  const SizedBox(height: 16),
                  const Text('这里可以测试各种 API 接口调用功能'),
                  const SizedBox(height: 16),
                  GiSpace(
                    children: [
                      GiArcoButton(
                        text: 'GET 请求',
                        onPressed: () => GiArcoMessage.info('请求成功啦，哈哈~'),
                        
                      ),
                      GiArcoButton(
                        text: 'POST 请求',
                        onPressed: () => GiArcoMessage.success('请求成功啦，哈哈~'),
                      ),
                      GiArcoButton(
                        text: 'PUT 请求',
                        onPressed: () => GiArcoMessage.warning('请求成功啦，哈哈~'),
                      ),
                      GiArcoButton(
                        text: 'DELETE 请求',
                        onPressed: () => GiArcoMessage.error('请求成功啦，哈哈~'),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }


  // 其他页面的占位符实现
  Widget _buildSpacePage() => _buildPlaceholderPage('GiSpace 间距组件');
  Widget _buildIconBoxPage() => _buildPlaceholderPage('GiIconBox 图标盒子组件');
  Widget _buildDotPage() => _buildPlaceholderPage('GiDot 圆点组件');
  Widget _buildIconSelectorPage() => _buildPlaceholderPage('GiIconSelector 图标选择器');
  Widget _buildModalPage() => _buildPlaceholderPage('函数调用模态框');
  Widget _buildTablePage() => _buildPlaceholderPage('横向树表格');
  Widget _buildAreaPage() => _buildPlaceholderPage('省市区选择器');
  Widget _buildEditorPage() => _buildPlaceholderPage('富文本编辑器');
  Widget _buildMapPage() => _buildPlaceholderPage('地图组件');
  Widget _buildMittPage() => _buildPlaceholderPage('Mitt中央通信');
  Widget _buildFnComponentPage() => _buildPlaceholderPage('函数式组件');

  /// 占位符页面
  Widget _buildPlaceholderPage(String title) {
    return _buildPageContainer(
      title: title,
      child: Card(
        child: Padding(
          padding: const EdgeInsets.all(48),
          child: Center(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Icon(
                  Icons.construction,
                  size: 64,
                  color: Colors.grey[400],
                ),
                const SizedBox(height: 16),
                Text(
                  '$title 开发中...',
                  style: Theme.of(context).textTheme.titleLarge?.copyWith(
                    color: Colors.grey[600],
                  ),
                ),
                const SizedBox(height: 8),
                Text(
                  '敬请期待',
                  style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                    color: Colors.grey[500],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  /// 页面容器
  Widget _buildPageContainer({
    required String title,
    required Widget child,
  }) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // 页面标题
          Container(
            padding: const EdgeInsets.only(bottom: 16),
            child: Row(
              children: [
                Icon(
                  menuList[selectedIndex].icon,
                  size: 24,
                  color: Theme.of(context).primaryColor,
                ),
                const SizedBox(width: 12),
                Text(
                  title,
                  style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                    fontWeight: FontWeight.bold,
                    color: Theme.of(context).primaryColor,
                  ),
                ),
              ],
            ),
          ),
          // 页面内容
          child,
        ],
      ),
    );
  }
}

/// Demo 菜单项模型
class DemoMenuItem {
  final String name;
  final IconData icon;

  DemoMenuItem({
    required this.name,
    required this.icon,
  });
}
