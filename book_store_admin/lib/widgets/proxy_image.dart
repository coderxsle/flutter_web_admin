import 'package:flutter/material.dart';
import 'package:book_store_shared/book_store_shared.dart';

class ProxyImage extends StatelessWidget {
  final String url;
  final double? width;
  final double? height;
  final BoxFit? fit;

  const ProxyImage({
    super.key,
    required this.url,
    this.width,
    this.height,
    this.fit,
  });

  String _getProxyUrl() {
    if (url.isEmpty) return '';
    try {
      final uri = Uri.parse(url);
      if (!uri.hasScheme) {
        logger.w('图片URL缺少协议: $url');
        return '';
      }
      return 'http://localhost/proxyLoadPicture-pro/${url.split('/isbn/')[1]}';
    } catch (e) {
      logger.e('解析图片URL失败: $url', error: e);
      return '';
    }
  }

  @override
  Widget build(BuildContext context) {
    if (url.isEmpty) {
      return _buildPlaceholder(Icons.image_not_supported);
    }

    final proxyUrl = _getProxyUrl();
    if (proxyUrl.isEmpty) {
      return _buildPlaceholder(Icons.broken_image);
    }

    return Image.network(
      proxyUrl,
      width: width,
      height: height,
      fit: fit,
      errorBuilder: (context, error, stackTrace) {
        logger.e('图片加载错误', error: error, stackTrace: stackTrace);
        return _buildPlaceholder(Icons.broken_image);
      },
      loadingBuilder: (context, child, loadingProgress) {
        if (loadingProgress == null) return child;
        return _buildLoadingPlaceholder(loadingProgress);
      },
    );
  }

  Widget _buildPlaceholder(IconData icon) {
    return Container(
      width: width,
      height: height,
      color: Colors.grey[200],
      child: Icon(icon),
    );
  }

  Widget _buildLoadingPlaceholder(ImageChunkEvent loadingProgress) {
    return Container(
      width: width,
      height: height,
      color: Colors.grey[200],
      child: Center(
        child: CircularProgressIndicator(
          value: loadingProgress.expectedTotalBytes != null
              ? loadingProgress.cumulativeBytesLoaded / 
                loadingProgress.expectedTotalBytes!
              : null,
        ),
      ),
    );
  }
} 