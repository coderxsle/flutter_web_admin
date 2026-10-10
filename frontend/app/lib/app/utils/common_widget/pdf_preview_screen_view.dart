
import 'package:auto_shop_server/app/utils/global.dart';
import 'package:auto_shop_server/common/index.dart';
import 'package:get/get.dart';
import 'package:syncfusion_flutter_pdfviewer/pdfviewer.dart';

// SfPdfViewer.memory(bytes));
// SfPdfViewer.asset('assets/flutter-succinctly.pdf'));
// SfPdfViewer.file(File('storage/emulated/0/Download/flutter-succinctly.pdf')));
// SfPdfViewer.network('https://cdn.syncfusion.com/content/PDFViewer/encrypted.pdf', password: 'syncfusion')));
class PdfPreviewScreen extends StatelessWidget {
//2025年05月06日，在JavaScriptApi之中使用Get.to跳转页面报错。
// class PdfPreviewScreen extends GetView {
  final String filePath;
  const PdfPreviewScreen({super.key, required this.filePath});

  @override
  Widget build(BuildContext context) {
    // 判断 filePath 的类型
    Widget pdfViewer;
    if (filePath.startsWith('http') || filePath.startsWith('https')) {
      pdfViewer = SfPdfViewer.network(filePath);
    } else if (filePath.startsWith('assets/')) {
      pdfViewer = SfPdfViewer.asset(filePath);
    } else {
      pdfViewer = SfPdfViewer.file(File(filePath));
    }
    return Scaffold(
      //@lastTime 2025/2/13原始代码文字大，箭头和其他不统一
      //appBar: AppBar(title: Text('PDF预览')),
      //@updateTime 2025/2/13保持和其他页面统一
      appBar: AppBar(
        title: NavigatorTitle("PDF预览"),
        leading: IconButton(onPressed: () => Get.back(), icon: const Icon(Icons.arrow_back_ios, color: BGColor_white_255)),
      ),
      body: pdfViewer,
    );
  }
}