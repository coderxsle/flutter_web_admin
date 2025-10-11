import '../models/menu_item.dart';
import '../config/menu_config.dart';

/// 菜单服务类 - 负责菜单数据的获取和管理
/// 支持本地静态菜单和服务器动态菜单
class MenuService {
  /// 单例模式
  static final MenuService _instance = MenuService._internal();
  factory MenuService() => _instance;
  MenuService._internal();

  /// 缓存的菜单数据
  List<MenuItem>? _cachedMenus;

  /// 是否使用服务器菜单
  bool _useServerMenus = false;

  /// 获取菜单数据
  /// [forceRefresh] 是否强制刷新（重新从服务器获取）
  Future<List<MenuItem>> getMenus({bool forceRefresh = false}) async {
    // 如果有缓存且不强制刷新，直接返回缓存
    if (_cachedMenus != null && !forceRefresh) {
      return _cachedMenus!;
    }

    // 根据配置决定使用本地菜单还是服务器菜单
    if (_useServerMenus) {
      _cachedMenus = await _fetchMenusFromServer();
    } else {
      _cachedMenus = MenuConfig.getStaticMenus();
    }

    return _cachedMenus!;
  }

  /// 从服务器获取菜单
  Future<List<MenuItem>> _fetchMenusFromServer() async {
    try {
      // TODO: 实现从服务器获取菜单的逻辑
      // 示例：
      // final response = await http.get(Uri.parse('your-api-endpoint/menus'));
      // if (response.statusCode == 200) {
      //   final List<dynamic> data = json.decode(response.body);
      //   return MenuConfig.fromServerData(
      //     data.map((e) => e as Map<String, dynamic>).toList()
      //   );
      // }
      
      // 模拟服务器延迟
      await Future.delayed(const Duration(milliseconds: 500));
      
      // 临时返回示例数据（实际应该从服务器获取）
      return _getMockServerMenus();
    } catch (e) {
      print('获取服务器菜单失败: $e');
      // 如果服务器获取失败，降级使用本地菜单
      return MenuConfig.getStaticMenus();
    }
  }

  /// 模拟服务器返回的菜单数据
  List<MenuItem> _getMockServerMenus() {
    // 这里是模拟数据，实际使用时应该调用 MenuConfig.fromServerData
    // 将服务器返回的 JSON 转换为菜单项
    final serverData = [
      {
        'route': '/home',
        'title': '首页',
        'iconData': 'home',
        'componentName': 'HomePage',
      },
      {
        'route': '/dashboard',
        'title': '仪表板',
        'svgIcon': 'menu_chart.svg',
        'componentName': 'DashboardPage',
      },
      // 更多服务器返回的菜单...
    ];
    
    return MenuConfig.fromServerData(serverData);
  }

  /// 设置是否使用服务器菜单
  void setUseServerMenus(bool use) {
    _useServerMenus = use;
    _cachedMenus = null; // 清空缓存
  }

  /// 清空菜单缓存
  void clearCache() {
    _cachedMenus = null;
  }

  /// 刷新菜单（重新从服务器获取）
  Future<List<MenuItem>> refreshMenus() async {
    return getMenus(forceRefresh: true);
  }

  /// 更新用户权限后重新加载菜单
  Future<List<MenuItem>> reloadMenusForUser(String userId) async {
    // TODO: 根据用户ID获取对应的菜单权限
    // 示例：
    // final response = await http.get(
    //   Uri.parse('your-api-endpoint/menus?userId=$userId')
    // );
    
    return refreshMenus();
  }

  /// 根据用户权限过滤菜单
  List<MenuItem> filterMenusByPermissions(
    List<MenuItem> menus, 
    List<String> userPermissions
  ) {
    return menus.where((menu) {
      // 如果菜单项没有权限要求，或者用户有对应权限，则保留
      // TODO: 根据实际的权限逻辑实现
      return true;
    }).map((menu) {
      // 递归过滤子菜单
      if (menu.hasChildren) {
        final filteredChildren = filterMenusByPermissions(
          menu.children!, 
          userPermissions
        );
        return menu.copyWith(children: filteredChildren);
      }
      return menu;
    }).toList();
  }
}


