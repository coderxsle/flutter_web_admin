import 'package:book_store_shared/base_url_config.dart';
import 'package:flutter/foundation.dart';

class ImageUrlHelper {
  static String convertToLocalUrl(String originalUrl) {
    // 检查是否是 static.tanshuapi.com 的 URL
    if (originalUrl.contains('static.tanshuapi.com')) {
      return originalUrl.replaceFirst(
        'http://static.tanshuapi.com',
        kReleaseMode ? BASE_URL : LOCAL_URL
      );
    }
    // 如果有其他域名需要处理，可以在这里添加更多的判断
    // 如果不需要转换，返回原始 URL
    return originalUrl;
  }
}