import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:intl/intl.dart';

class StatisticsController extends GetxController {
  final isLoading = false.obs;
  final selectedPeriod = '本月'.obs;
  final periods = ['今日', '本周', '本月', '本年'];

  // 统计数据
  final totalSales = 0.0.obs;
  final totalOrders = 0.obs;
  final totalCustomers = 0.obs;
  final totalBooks = 0.obs;

  // 图表数据
  final salesData = <FlSpot>[].obs;
  final orderData = <FlSpot>[].obs;

  @override
  void onInit() {
    super.onInit();
    fetchStatistics();
  }

  Future<void> fetchStatistics() async {
    isLoading.value = true;
    try {
      // TODO: 实现获取统计数据的逻辑
      await Future.delayed(const Duration(seconds: 1));
      
      // 模拟数据
      totalSales.value = 12345.67;
      totalOrders.value = 89;
      totalCustomers.value = 45;
      totalBooks.value = 1234;

      // 模拟销售趋势数据
      salesData.value = List.generate(7, (index) {
        return FlSpot(index.toDouble(), (index + 1) * 1000.0);
      });

      // 模拟订单趋势数据
      orderData.value = List.generate(7, (index) {
        return FlSpot(index.toDouble(), (index + 1) * 10.0);
      });
    } finally {
      isLoading.value = false;
    }
  }

  void changePeriod(String period) {
    selectedPeriod.value = period;
    fetchStatistics();
  }
}

class StatisticsPage extends StatelessWidget {
  const StatisticsPage({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(StatisticsController());

    return Scaffold(
      appBar: AppBar(
        title: const Text('统计分析'),
        actions: [
          Obx(() => DropdownButton<String>(
                value: controller.selectedPeriod.value,
                items: controller.periods
                    .map((period) => DropdownMenuItem(
                          value: period,
                          child: Text(period),
                        ))
                    .toList(),
                onChanged: (value) {
                  if (value != null) {
                    controller.changePeriod(value);
                  }
                },
              )),
          SizedBox(width: 16.w),
        ],
      ),
      body: Obx(
        () => controller.isLoading.value
            ? const Center(child: CircularProgressIndicator())
            : SingleChildScrollView(
                padding: EdgeInsets.all(16.w),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // 概览卡片
                    Row(
                      children: [
                        _buildStatCard(
                          '总销售额',
                          '¥${controller.totalSales.value.toStringAsFixed(2)}',
                          Icons.attach_money,
                          Colors.green,
                        ),
                        SizedBox(width: 16.w),
                        _buildStatCard(
                          '订单数',
                          controller.totalOrders.value.toString(),
                          Icons.shopping_cart,
                          Colors.blue,
                        ),
                        SizedBox(width: 16.w),
                        _buildStatCard(
                          '客户数',
                          controller.totalCustomers.value.toString(),
                          Icons.people,
                          Colors.orange,
                        ),
                        SizedBox(width: 16.w),
                        _buildStatCard(
                          '图书数',
                          controller.totalBooks.value.toString(),
                          Icons.book,
                          Colors.purple,
                        ),
                      ],
                    ),
                    SizedBox(height: 24.h),

                    // 销售趋势图
                    Card(
                      child: Padding(
                        padding: EdgeInsets.all(16.w),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              '销售趋势',
                              style: TextStyle(
                                fontSize: 18.sp,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            SizedBox(height: 16.h),
                            SizedBox(
                              height: 200.h,
                              child: LineChart(
                                LineChartData(
                                  gridData: const FlGridData(show: true),
                                  titlesData: const FlTitlesData(
                                    leftTitles: AxisTitles(
                                      sideTitles: SideTitles(
                                        showTitles: true,
                                        reservedSize: 40,
                                      ),
                                    ),
                                    bottomTitles: AxisTitles(
                                      sideTitles: SideTitles(
                                        showTitles: true,
                                        reservedSize: 22,
                                      ),
                                    ),
                                  ),
                                  borderData: FlBorderData(show: true),
                                  lineBarsData: [
                                    LineChartBarData(
                                      spots: controller.salesData,
                                      isCurved: true,
                                      color: Colors.blue,
                                      barWidth: 2,
                                      dotData: const FlDotData(show: true),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    SizedBox(height: 24.h),

                    // 订单趋势图
                    Card(
                      child: Padding(
                        padding: EdgeInsets.all(16.w),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              '订单趋势',
                              style: TextStyle(
                                fontSize: 18.sp,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            SizedBox(height: 16.h),
                            SizedBox(
                              height: 200.h,
                              child: LineChart(
                                LineChartData(
                                  gridData: const FlGridData(show: true),
                                  titlesData: const FlTitlesData(
                                    leftTitles: AxisTitles(
                                      sideTitles: SideTitles(
                                        showTitles: true,
                                        reservedSize: 40,
                                      ),
                                    ),
                                    bottomTitles: AxisTitles(
                                      sideTitles: SideTitles(
                                        showTitles: true,
                                        reservedSize: 22,
                                      ),
                                    ),
                                  ),
                                  borderData: FlBorderData(show: true),
                                  lineBarsData: [
                                    LineChartBarData(
                                      spots: controller.orderData,
                                      isCurved: true,
                                      color: Colors.orange,
                                      barWidth: 2,
                                      dotData: const FlDotData(show: true),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
      ),
    );
  }

  Widget _buildStatCard(String title, String value, IconData icon, Color color) {
    return Expanded(
      child: Card(
        child: Padding(
          padding: EdgeInsets.all(16.w),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Icon(icon, color: color),
                  SizedBox(width: 8.w),
                  Text(
                    title,
                    style: TextStyle(
                      fontSize: 14.sp,
                      color: Colors.grey,
                    ),
                  ),
                ],
              ),
              SizedBox(height: 8.h),
              Text(
                value,
                style: TextStyle(
                  fontSize: 24.sp,
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