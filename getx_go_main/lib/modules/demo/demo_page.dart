// 示例页面组件
import 'package:flutter/material.dart';

class DashboardPage extends StatelessWidget {
  const DashboardPage({super.key});

  @override
  Widget build(BuildContext context) {
    return const Center(
      child: Text('仪表板页面', style: TextStyle(fontSize: 24)),
    );
  }
}

class UsersPage extends StatelessWidget {
  const UsersPage({super.key});

  @override
  Widget build(BuildContext context) {
    return const Center(
      child: Text('用户列表页面', style: TextStyle(fontSize: 24)),
    );
  }
}

class UserRolesPage extends StatelessWidget {
  const UserRolesPage({super.key});

  @override
  Widget build(BuildContext context) {
    return const Center(
      child: Text('用户角色页面', style: TextStyle(fontSize: 24)),
    );
  }
}

class RolePermissionsPage extends StatelessWidget {
  const RolePermissionsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return const Center(
      child: Text('角色权限页面', style: TextStyle(fontSize: 24)),
    );
  }
}

class MenuPermissionsPage extends StatelessWidget {
  const MenuPermissionsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return const Center(
      child: Text('菜单权限页面', style: TextStyle(fontSize: 24)),
    );
  }
}

class ArticlesPage extends StatelessWidget {
  const ArticlesPage({super.key});

  @override
  Widget build(BuildContext context) {
    return const Center(
      child: Text('文章管理页面', style: TextStyle(fontSize: 24)),
    );
  }
}

class ArticleCategoriesPage extends StatelessWidget {
  const ArticleCategoriesPage({super.key});

  @override
  Widget build(BuildContext context) {
    return const Center(
      child: Text('文章分类页面', style: TextStyle(fontSize: 24)),
    );
  }
}

class ProductCategoriesPage extends StatelessWidget {
  const ProductCategoriesPage({super.key});

  @override
  Widget build(BuildContext context) {
    return const Center(
      child: Text('产品分类页面', style: TextStyle(fontSize: 24)),
    );
  }
}

class BasicSettingsPage extends StatelessWidget {
  const BasicSettingsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return const Center(
      child: Text('基础设置页面', style: TextStyle(fontSize: 24)),
    );
  }
}

class SecuritySettingsPage extends StatelessWidget {
  const SecuritySettingsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return const Center(
      child: Text('安全设置页面', style: TextStyle(fontSize: 24)),
    );
  }
}
