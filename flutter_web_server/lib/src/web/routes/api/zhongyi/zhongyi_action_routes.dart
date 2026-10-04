import 'package:flutter_web_server/src/web/routes/api/zhongyi/billing_routes.dart';
import 'package:flutter_web_server/src/web/routes/api/zhongyi/directory_routes.dart';
import 'package:flutter_web_server/src/web/routes/api/zhongyi/medicine_inventory_routes.dart';
import 'package:flutter_web_server/src/web/routes/api/zhongyi/zhongyi_patient_template_routes.dart';
import 'package:serverpod/serverpod.dart';
import 'package:serverpod_crud/serverpod_crud.dart';

/// 汇总中医业务 REST 动作路由，避免各模块漏挂载或互相覆盖路径。
Map<String, ActionRoute> zhongyiActionRoutes() {
  final routes = <String, ActionRoute>{};
  final groups = [
    zhongyiMedicineInventoryRoutes(),
    zhongyiDirectoryActionRoutes(),
    patientActionRoutes(),
    prescriptionTemplateActionRoutes(),
    zhongyiBillingActionRoutes(),
  ];

  for (final group in groups) {
    for (final entry in group.entries) {
      if (routes.containsKey(entry.key)) {
        throw StateError('中医 REST 路由重复：${entry.key}');
      }
      routes[entry.key] = entry.value;
    }
  }

  return Map.unmodifiable(routes);
}

/// 注册所有中医业务接口到 Serverpod Web Server。
void registerZhongyiActionRoutes(Serverpod pod) {
  for (final entry in zhongyiActionRoutes().entries) {
    pod.webServer.addRoute(entry.value, entry.key);
  }
}
