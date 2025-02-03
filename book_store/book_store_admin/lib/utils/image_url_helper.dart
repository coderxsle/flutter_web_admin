class ImageUrlHelper {
  static String convertToLocalUrl(String originalUrl) {
    // 检查是否是 static.tanshuapi.com 的 URL
    if (originalUrl.contains('static.tanshuapi.com')) {
      return originalUrl.replaceFirst(
        'http://static.tanshuapi.com',
        'http://localhost:8080/'
      );
    }
    // 如果有其他域名需要处理，可以在这里添加更多的判断
    // 如果不需要转换，返回原始 URL
    return originalUrl;
  }
}