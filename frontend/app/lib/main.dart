import 'package:auto_shop_server/app/modules/launching/app_launching.dart';
import 'package:flutter/material.dart';
import 'package:get_storage/get_storage.dart';

import 'my_app.dart';

// flutter run --dart-define=IS_SIMULATOR=true
// flutter run --dart-define=IS_SIMULATOR=false

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await GetStorage.init();
  // if (kDebugMode) httpManager.setProxy(host: "192.168.0.121", port: "8888");
  await AppLaunching.launching();
  runApp(const MyApp());
}
