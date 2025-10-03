import 'package:get_storage/get_storage.dart';

GetStorage _localStorage = GetStorage();

Future<void> localStorageWrite(String key, dynamic value) async {
  await _localStorage.write(key, value);
}

T? localStorageRead<T>(String key) {
  return _localStorage.read(key);
}

Future<void> localStorageRemove(String key) async {
  await _localStorage.remove(key);
}
