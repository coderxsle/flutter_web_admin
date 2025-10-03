import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class OrderListController extends GetxController {
  final orders = <Map<String, dynamic>>[].obs;
  final isLoading = false.obs;

  @override
  void onInit() {
    super.onInit();
    fetchOrders();
  }

  Future<void> fetchOrders() async {
    isLoading.value = true;
    try {
      // TODO: 实现获取订单列表的逻辑
      await Future.delayed(const Duration(seconds: 1));
      orders.value = [
        {
          'id': 1,
          'orderNo': 'ORD20240127001',
          'customerName': '张三',
          'totalAmount': 149.9,
          'status': 1,
          'createTime': '2024-01-27 10:00:00',
        },
        {
          'id': 2,
          'orderNo': 'ORD20240127002',
          'customerName': '李四',
          'totalAmount': 249.9,
          'status': 2,
          'createTime': '2024-01-27 11:00:00',
        },
      ];
    } finally {
      isLoading.value = false;
    }
  }

  String getStatusText(int status) {
    switch (status) {
      case 0:
        return '待付款';
      case 1:
        return '待发货';
      case 2:
        return '已发货';
      case 3:
        return '已完成';
      case 4:
        return '已取消';
      default:
        return '未知';
    }
  }

  Color getStatusColor(int status) {
    switch (status) {
      case 0:
        return Colors.orange;
      case 1:
        return Colors.blue;
      case 2:
        return Colors.green;
      case 3:
        return Colors.grey;
      case 4:
        return Colors.red;
      default:
        return Colors.grey;
    }
  }

  void viewOrderDetail(Map<String, dynamic> order) {
    // TODO: 实现查看订单详情的逻辑
  }

  void updateOrderStatus(int orderId, int status) {
    // TODO: 实现更新订单状态的逻辑
  }
}

class OrderListPage extends StatelessWidget {
  const OrderListPage({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(OrderListController());

    return Scaffold(
      appBar: AppBar(
        title: const Text('订单管理'),
      ),
      body: Obx(
        () => controller.isLoading.value
            ? const Center(child: CircularProgressIndicator())
            : ListView.builder(
                itemCount: controller.orders.length,
                itemBuilder: (context, index) {
                  final order = controller.orders[index];
                  return Card(
                    margin: EdgeInsets.symmetric(
                      horizontal: 16.w,
                      vertical: 8.h,
                    ),
                    child: ListTile(
                      title: Row(
                        children: [
                          Text(order['orderNo']),
                          SizedBox(width: 16.w),
                          Chip(
                            label: Text(
                              controller.getStatusText(order['status']),
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 12.sp,
                              ),
                            ),
                            backgroundColor: controller.getStatusColor(order['status']),
                          ),
                        ],
                      ),
                      subtitle: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text('客户：${order['customerName']}'),
                          Text('金额：¥${order['totalAmount']}'),
                          Text('时间：${order['createTime']}'),
                        ],
                      ),
                      trailing: TextButton(
                        onPressed: () => controller.viewOrderDetail(order),
                        child: const Text('查看详情'),
                      ),
                      onTap: () => controller.viewOrderDetail(order),
                    ),
                  );
                },
              ),
      ),
    );
  }
} 