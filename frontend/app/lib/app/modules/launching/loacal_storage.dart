import 'package:get_storage/get_storage.dart';

GetStorage box = GetStorage();

Future<void> localStorageWrite(String key, dynamic value) async {
  await box.write(key, value);
}

T? localStorageRead<T>(String key) {
  return box.read(key);
}

localStorageRemove(String key) async {
  await box.remove(key);
}
