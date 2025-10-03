// import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:getx_go_main/components/gi_arco.dart';


/// ArcoDesign 风格的按钮展示页面 - 完全还原 Vue demo
class ApiTestPage extends StatelessWidget {
  final String title;
  const ApiTestPage({super.key, required this.title});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // 页面标题
          Row(
            children: [
              Icon(
                Icons.smart_button,
                size: 26,
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
          // 页面内容
          SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.fromLTRB(0, 20, 0, 20),
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
              ]),
            ),
          ),
        ],
      ),
    );
  }
}
