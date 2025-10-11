import 'package:flutter/material.dart';
import 'package:flutter_web_admin/components/gi_arco.dart';
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
  late final List<DemoMenuItem> menuList;
  late final List<DemoMenuItem> leafItems;

  @override
  void initState() {
    super.initState();
    menuList = _buildMenuTree();
    leafItems = _flattenLeaves(menuList);
    _tabController = TabController(length: leafItems.length, vsync: this);
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
    return Row(
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
            child: ListView(
              padding: const EdgeInsets.symmetric(vertical: 8),
              children: _buildNestedMenu(menuList),
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
        children: leafItems
            .map((item) => item.builder?.call(context) ?? _buildPlaceholderPage(item.name))
            .toList(),
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
                  leafItems[selectedIndex].icon,
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

  List<DemoMenuItem> _flattenLeaves(List<DemoMenuItem> nodes) {
    final result = <DemoMenuItem>[];
    void dfs(List<DemoMenuItem> items) {
      for (final item in items) {
        if (item.isLeaf) {
          result.add(item);
        } else {
          dfs(item.children);
        }
      }
    }
    dfs(nodes);
    return result;
  }

  List<Widget> _buildNestedMenu(List<DemoMenuItem> nodes, {double indent = 0}) {
    return nodes.map((item) {
      if (item.isLeaf) {
        final leafIndex = leafItems.indexOf(item);
        final isSelected = selectedIndex == leafIndex;
        return Container(
          margin: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
          child: Material(
            color: isSelected ? Theme.of(context).primaryColor.withOpacity(0.08) : Colors.transparent,
            borderRadius: BorderRadius.circular(8),
            child: InkWell(
              borderRadius: BorderRadius.circular(8),
              onTap: () {
                setState(() {
                  selectedIndex = leafIndex;
                  _tabController.animateTo(leafIndex);
                });
              },
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                child: Row(
                  children: [
                    Icon(
                      item.icon,
                      size: 18,
                      color: isSelected ? Theme.of(context).primaryColor : Theme.of(context).iconTheme.color,
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: Text(
                        item.name,
                        style: TextStyle(
                          fontSize: 14,
                          color: isSelected ? Theme.of(context).primaryColor : Theme.of(context).textTheme.bodyMedium?.color,
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
      } else {
        return Theme(
          data: Theme.of(context).copyWith(dividerColor: Colors.transparent),
          child: Container(
            margin: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
            child: ExpansionTile(
              leading: Icon(item.icon, size: 18),
              title: Text(
                item.name,
                style: const TextStyle(fontSize: 14, fontWeight: FontWeight.w600),
              ),
              tilePadding: const EdgeInsets.symmetric(horizontal: 12),
              childrenPadding: const EdgeInsets.only(left: 12),
              children: _buildNestedMenu(item.children, indent: indent + 16),
            ),
          ),
        );
      }
    }).toList();
  }

  List<DemoMenuItem> _buildMenuTree() {
    return [
      DemoMenuItem(
        name: '示例',
        icon: Icons.apps,
        children: [
          DemoMenuItem(
            name: '接口测试',
            icon: Icons.api,
            builder: (ctx) => _buildApiTestPage(),
          ),
        ],
      ),
      DemoMenuItem(
        name: '组件',
        icon: Icons.widgets,
        children: [
          DemoMenuItem(
            name: '基础组件',
            icon: Icons.category,
            children: [
              DemoMenuItem(
                name: '按钮',
                icon: Icons.smart_button,
                builder: (ctx) => _buildPageContainer(
                  title: '按钮',
                  child: const GiArcoButtonDemoPage(title: '按钮', ),
                ),
              ),
              DemoMenuItem(
                name: 'GiTag',
                icon: Icons.label,
                builder: (ctx) => _buildPageContainer(
                  title: 'GiTag',
                  child: const GiTagDemoPage(title: 'GiTag'),
                ),
              ),
              DemoMenuItem(
                name: 'GiSpace',
                icon: Icons.space_bar,
                builder: (ctx) => _buildSpacePage(),
              ),
              DemoMenuItem(
                name: 'GiIconBox',
                icon: Icons.inbox,
                builder: (ctx) => _buildIconBoxPage(),
              ),
              DemoMenuItem(
                name: 'GiDot',
                icon: Icons.circle,
                builder: (ctx) => _buildDotPage(),
              ),
            ],
          ),
          DemoMenuItem(
            name: '选择器',
            icon: Icons.select_all,
            children: [
              DemoMenuItem(
                name: 'GiIconSelector',
                icon: Icons.select_all,
                builder: (ctx) => _buildIconSelectorPage(),
              ),
              DemoMenuItem(
                name: '函数调用模态框',
                icon: Icons.call_to_action,
                builder: (ctx) => _buildModalPage(),
              ),
            ],
          ),
        ],
      ),
      DemoMenuItem(
        name: '数据展示',
        icon: Icons.table_view,
        children: [
          DemoMenuItem(
            name: '横向树表格',
            icon: Icons.table_rows,
            builder: (ctx) => _buildTablePage(),
          ),
        ],
      ),
      DemoMenuItem(
        name: '表单',
        icon: Icons.assignment,
        children: [
          DemoMenuItem(
            name: '省市区',
            icon: Icons.location_on,
            builder: (ctx) => _buildAreaPage(),
          ),
        ],
      ),
      DemoMenuItem(
        name: '扩展',
        icon: Icons.extension,
        children: [
          DemoMenuItem(
            name: '富文本',
            icon: Icons.text_fields,
            builder: (ctx) => _buildEditorPage(),
          ),
          DemoMenuItem(
            name: '地图',
            icon: Icons.map,
            builder: (ctx) => _buildMapPage(),
          ),
          DemoMenuItem(
            name: 'Mitt中央通信',
            icon: Icons.connect_without_contact,
            builder: (ctx) => _buildMittPage(),
          ),
          DemoMenuItem(
            name: '函数式组件',
            icon: Icons.functions,
            builder: (ctx) => _buildFnComponentPage(),
          ),
        ],
      ),
    ];
  }
}

/// Demo 菜单项模型
class DemoMenuItem {
  final String name;
  final IconData icon;
  final List<DemoMenuItem> children;
  final WidgetBuilder? builder;

  const DemoMenuItem({
    required this.name,
    required this.icon,
    this.children = const [],
    this.builder,
  });

  bool get isLeaf => children.isEmpty;
}
