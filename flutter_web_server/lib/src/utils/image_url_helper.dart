class ImageUrlHelper {
  // 是否使用本地代理
  static const bool useProxy = true; // 可以根据环境变量设置

  static String convertToLocalUrl(String originalUrl) {
    if (!useProxy) return originalUrl;
    
    if (originalUrl.contains('static.tanshuapi.com')) {
      final uri = Uri.parse(originalUrl);
      // 只保留路径部分
      return 'http://localhost:8080${uri.path}';
    }
    
    // 如果有其他域名需要处理，可以在这里添加更多的判断
    
    // 如果不需要转换，返回原始 URL
    return originalUrl;
  }
} 