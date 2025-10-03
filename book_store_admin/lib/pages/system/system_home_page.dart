import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class SystemHomePage extends StatelessWidget {
  const SystemHomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: EdgeInsets.all(16.w),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              '系统管理',
              style: TextStyle(
                fontSize: 24.sp,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 16.h),
            Expanded(
              child: GridView.count(
                crossAxisCount: 3,
                mainAxisSpacing: 20.h,
                crossAxisSpacing: 20.w,
                childAspectRatio: 1.5,
                children: [
                  _buildModuleCard(
                    title: '用户管理',
                    icon: Icons.people,
                    color: Colors.blue,
                    onTap: () => Get.toNamed('/system/users'),
                  ),
                  _buildModuleCard(
                    title: '角色管理',
                    icon: Icons.security,
                    color: Colors.orange,
                    onTap: () => Get.toNamed('/system/roles'),
                  ),
                  _buildModuleCard(
                    title: '资源管理',
                    icon: Icons.menu,
                    color: Colors.green,
                    onTap: () => Get.toNamed('/system/resources'),
                  ),
                  _buildModuleCard(
                    title: '操作日志',
                    icon: Icons.history,
                    color: Colors.purple,
                    onTap: () => Get.toNamed('/system/logs'),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildModuleCard({
    required String title,
    required IconData icon,
    required Color color,
    required VoidCallback onTap,
  }) {
    return Card(
      elevation: 2,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.r)),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(10.r),
        child: Padding(
          padding: EdgeInsets.all(16.w),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                icon,
                size: 50.r,
                color: color,
              ),
              SizedBox(height: 16.h),
              Text(
                title,
                style: TextStyle(
                  fontSize: 18.sp,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
} 