import 'dart:io';
import 'package:auto_shop_server/app/utils/common_widget/logger.dart';
import 'package:auto_shop_server/app/utils/common_widget/pdf_preview_screen_view.dart';
import 'package:auto_shop_server/app/utils/global.dart';
import 'package:auto_shop_server/common/widgets/show_camera_photo_file.dart';
import 'package:common_utils/common_utils.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:reorderable_grid_view/reorderable_grid_view.dart';
import 'package:syncfusion_flutter_pdfviewer/pdfviewer.dart';
import '../../../base/image_browser/simple_pics_wiper.dart';

const String http = 'http';

// 添加图片路径前缀
// 服务器返回的图片路径有时候不是全路径，需要拼接 url 的前缀
// 有时候是一个用逗号‘,’拼接的字符串的不带http头的半路径,
// 需要转成数组，并且每个图片路径都加上http头
// imagePaths 只允许 String 或 List<String> 类型
List<String> addUrlPrefix(dynamic imagePaths, String urlPrefix) {
  if (imagePaths == null) return [];
  List<String> imageList;
  if (imagePaths is String && imagePaths.isNotEmpty) {
    imageList = imagePaths.split(',');
  } else if (imagePaths is List<String>) {
    imageList = imagePaths;
  } else {
    // 如果类型不匹配，则返回空列表并记录日志
    logger.w("Unsupported type for imagePaths. Expected String or List<String>.");
    return [];
  }
  // 为每个路径添加前缀（如果需要）
  return imageList.map((img) {
    return img.startsWith(http) ? img : "$urlPrefix$img";
  }).toList();
}

class ImageGridView extends StatefulWidget {
  final String? title;
  final TextStyle? titleStyle;
  final int max;
  final bool? readOnly;  // 是否可上传图片
  final bool? canDelete; // 是否可以删除
  final bool? hasUpLoadAnnex; // 是否需要上传附件，有的要传递，有的不传递
  final bool? jumpAlbum; // 默认直接-跳转到相册选择，不弹窗选择
  final Widget? loadingOutSet;//外部设置图片加载圈圈
  List<String>? images; // 可以是路径、也可以是url
  final List<String>? fileNames; // 文件名称
  //打开添加图片之前在界面上做的事情
  final VoidCallback? callbackBefore;
  final void Function(List<String>)? addCallback;
  final void Function(List<String>, dynamic)? deleteCallback;
  ImageGridView({
    super.key,
    this.title,
    this.titleStyle,
    this.max = 9,
    this.readOnly = false,
    this.canDelete = false,
    this.images,
    this.fileNames,
    this.addCallback,
    this.deleteCallback,
    this.hasUpLoadAnnex = false, // 默认给false，需要传附件就给true
    this.jumpAlbum = false, //默认是false,即：默认有弹窗让用户选择相机、相册。只有是true的时候才是直接跳转到相册
    this.loadingOutSet,
    this.callbackBefore,
  });
  @override
  State<ImageGridView> createState() => _ImageGridViewState();
}

class _ImageGridViewState extends State<ImageGridView> {
  List<String> imagePaths = [];
  List<String> filePaths = [];
  int? draggingIndex;

  @override
  void initState() {
    super.initState();
  }

  // 过滤去重并保持索引
  filterImagePaths() {
    widget.images = widget.images ?? [];
    if (widget.images == null || widget.images!.isEmpty) {
      filePaths.clear();
      imagePaths.clear();
    }
    for (var path in widget.images!) {
      if (RegExp(r'\.(png|jpe?g|gif)$', caseSensitive: false).hasMatch(path)) {
        imagePaths.add(path);
      }
      if (RegExp(r'\.(pdf|docx?|xlsx?)$', caseSensitive: false).hasMatch(path)) {
        filePaths.add(path);
      }
    }
    imagePaths = imagePaths.toSet().toList();
    filePaths = filePaths.toSet().toList();
  }

  // 删除按钮的点击事件
  void _removeImage(int index) {
    if (index < 0 || index >= imagePaths.length) {
      return;
    }
    final delete = imagePaths[index];
    setState(() {
      imagePaths.remove(delete);
      widget.images?.remove(delete);
      if (widget.deleteCallback != null) {
        widget.deleteCallback!(imagePaths, delete);
      }
    });
  }

  // 点击图片进入预览界面
  void _previewImage(int index) {
    Navigator.of(context).push(
      PageRouteBuilder(
        opaque: false,
        barrierColor: Colors.transparent,
        pageBuilder: (BuildContext context, _, __) {
          var list = imagePaths;
          return SimplePicsWiper(url: list[index], images: list);
        },
      ),
    );
  }

  // 点击了添加图片的按钮
  Future<void> _addButtonPressed() async {
    // FocusScope.of(context).requestFocus(FocusNode());
    if ((widget.callbackBefore) != null) {
      widget.callbackBefore?.call();
    }

    if (widget.jumpAlbum ?? false) {
      //如果默认是：直接跳转到相册选择，不弹窗让用户选择
      ShowCameraPhotoFile.defaultOpenToAlbum(context, max: widget.max - imagePaths.length, complete: (data) => callBackComplete.call(data));
    } else {
      //isDefaultToAlbum默认是false,意思是：大多数默认情况是让用户弹窗选择的
      if (!ObjectUtil.isEmpty(widget.hasUpLoadAnnex ?? false)) {
        if (widget.hasUpLoadAnnex!) {
          ShowCameraPhotoFile.all(
            context,
            max: widget.max - imagePaths.length,
            complete: (data) => callBackComplete.call(data),
          );
        } else {
          ShowCameraPhotoFile.cameraPhoto(
            context,
            max: widget.max - imagePaths.length,
            complete: (data) => callBackComplete.call(data),
          );
        }
      } else {
        ShowCameraPhotoFile.all(
          context,
          max: widget.max - imagePaths.length,
          complete: (data) => callBackComplete.call(data),
        );
      }
    }
  }

  callBackComplete(data) {
    for (var path in data) {
      if (RegExp(r'\.(png|jpe?g|gif)$', caseSensitive: false).hasMatch(path)) {
        widget.images?.add(path);
      }
      if (RegExp(r'\.(pdf|docx?|xlsx?)$', caseSensitive: false).hasMatch(path)) {
        filePaths.add(path);
      }
    }
    // 图片数组、文件数组
    List<String> list = [...widget.images ?? [], ...filePaths];
    widget.addCallback!(list);
    setState(() {});
  }

  void _onReorder(int oldIndex, int newIndex) {
    // 如果拖拽的是最后一个元素，即加号按钮，直接返回
    if (oldIndex == imagePaths.length) return;

    // 如果新索引大于当前图片数量，修正新索引到最后一个图片的位置
    if (newIndex >= imagePaths.length) {
      newIndex = imagePaths.length - 1;
    }
    setState(() {
      final item = imagePaths.removeAt(oldIndex);
      imagePaths.insert(newIndex, item);
    });
  }

  setupTitle() {
    return Container(
      alignment: Alignment.centerLeft,
      padding: const EdgeInsets.fromLTRB(0, 0, 0, 10),
      child: Text(widget.title ?? "", style: widget.titleStyle ?? const TextStyle(fontSize: 14, color: Colors.black)),
    );
  }

  Widget createAddButton() {
    return GestureDetector(
      key: const ValueKey('add_button'),
      onTap: _addButtonPressed,
      child: Container(
        color: Colors.grey[200],
        child: const Icon(Icons.add, size: 40),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    filterImagePaths();
    return Column(
      children: [
        if (widget.title != null) setupTitle(),
        if (filePaths.isNotEmpty)
          Row(
            key: UniqueKey(),
            children: [
              Container(
                color: Colors.transparent,
                padding: const EdgeInsets.fromLTRB(0, 0, 0, 0),
                margin: const EdgeInsets.fromLTRB(0, 0, 0, 6),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: List.generate(filePaths.length, (index) {
                    return GestureDetector(
                      onTap: () {
                        if (filePaths[index].endsWith("pdf")) {
                          Get.to(() => PdfPreviewScreen(filePath: filePaths[index]));
                        } else {
                          // 处理非 PDF 文件
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(content: Text('无法预览非 PDF 文件')),
                          );
                        }
                      },
                      child: Row(
                        children: [
                          Container(
                            width: MediaQuery.of(context).size.width * 0.70,
                            color: Colors.blue[100],
                            padding: const EdgeInsets.fromLTRB(8, 4, 8, 4),
                            child: Text(widget.fileNames != null && widget.fileNames!.isNotEmpty && index < widget.fileNames!.length ? widget.fileNames![index] : (index < filePaths.length ? filePaths[index].split('/').last : ''),
                                style: TextStyle(fontSize: 14, color: Colors.blueAccent[700])),
                          ),
                          SizedBox(
                            height: 30,
                            child: IconButton(
                                icon: const Icon(Icons.close, color: Colors.red, size: 16),
                                onPressed: () {
                                  final delete = filePaths[index];
                                  if (widget.deleteCallback != null) {
                                    widget.deleteCallback!(filePaths, delete);
                                    setState(() {
                                      filePaths.remove(delete);
                                      widget.images?.remove(delete);
                                    });
                                  }
                                }),
                          ),
                        ],
                      ),
                    );
                  }),
                ),
              ),
            ],
          ),
        ReorderableGridView.count(
          onReorder: _onReorder,
          crossAxisCount: 4,
          crossAxisSpacing: 4,
          mainAxisSpacing: 4,
          shrinkWrap: true, // 根据内容大小而变
          physics: const NeverScrollableScrollPhysics(),
          padding: const EdgeInsets.fromLTRB(2, 2, 2, 2),
          children: setupItems(),
          dragWidgetBuilder: (int index, Widget child) {
            return Transform.scale(
              scale: 1.1,
              child: Material(
                elevation: 10.0,
                child: child,
              ),
            );
          },
        )
      ],
    );
  }

  List<Widget> setupItems() {
    List<Widget> images = [];
    for (int index = 0; index < imagePaths.length; index++) {
      final item = Stack(
        // key: ValueKey(imagePaths),
        key: UniqueKey(),
        children: [
          GestureDetector(
            onTap: () => _previewImage(index),
            child: Row(
              children: [
                Expanded(
                  child: imagePaths[index].startsWith(http)
                      ? imageNetwork(
                          imagePaths[index],
                          fit: BoxFit.cover,
                          loading: widget.loadingOutSet??CupertinoActivityIndicator(),
                        )
                      : imageFile(
                          File(imagePaths[index]),
                          fit: BoxFit.cover,
                        ),
                ),
              ],
            ),
          ),
          if (widget.readOnly == false && widget.canDelete == true)
            Positioned(
              right: 0,
              top: 0,
              child: GestureDetector(
                onTap: () => _removeImage(index),
                child: Container(
                  color: Colors.black54,
                  child: const Icon(
                    Icons.close,
                    color: Colors.white,
                  ),
                ),
              ),
            ),
        ],
      );
      images.add(item);
    }
    if (widget.readOnly == false && imagePaths.length < widget.max) {
      final addButton = GestureDetector(
        key: const ValueKey('add_button'),
        onTap: _addButtonPressed,
        child: Container(
          color: Colors.grey[200],
          child: const Icon(Icons.add),
        ),
      );
      images.add(addButton);
    }
    return images;
  }
}

// SfPdfViewer.memory(bytes));
// SfPdfViewer.asset('assets/flutter-succinctly.pdf'));
// SfPdfViewer.file(File('storage/emulated/0/Download/flutter-succinctly.pdf')));
// SfPdfViewer.network('https://cdn.syncfusion.com/content/PDFViewer/encrypted.pdf', password: 'syncfusion')));
/*class PdfPreviewScreen extends StatelessWidget {
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
        leading: IconButton(onPressed: () => Get.back(), icon: const Icon(Icons.arrow_back_ios, color: TdColors.white)),
      ),
      body: pdfViewer,
    );
  }
}*/

