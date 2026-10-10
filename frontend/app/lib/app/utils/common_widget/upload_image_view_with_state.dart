import 'package:auto_shop_server/common/index.dart';
import 'package:auto_shop_server/app/utils/common_widget/pdf_preview_screen_view.dart';
import 'package:auto_shop_server/app/utils/global.dart';
import 'package:auto_shop_server/res/assets_res.dart';
import 'package:auto_shop_server/common/widgets/dot_widget.dart';
import 'package:get/get.dart';
import 'package:reorderable_grid_view/reorderable_grid_view.dart';

import '../../../base/image_browser/simple_pics_wiper.dart';

// const String http = 'http';

// 添加图片路径前缀
// 服务器返回的图片路径有时候不是全路径，需要拼接 url 的前缀
// 有时候是一个用逗号‘,’拼接的字符串的不带http头的半路径,
// 需要转成数组，并且每个图片路径都加上http头
// imagePaths 只允许 String 或 List<String> 类型
List<String> addUrlPrefix(dynamic imagePaths, String urlPrefix) {
  List<String> imageList;
  if (imagePaths is String && imagePaths.isNotEmpty) {
    imageList = imagePaths.split(',');
  } else if (imagePaths is List<String>) {
    imageList = imagePaths;
  } else {
    // 如果类型不匹配，则返回空列表并记录日志
    //debugPrint("Warning: Unsupported type for imagePaths. Expected String or List<String>.");
    logger.d("Warning: Unsupported type for imagePaths. Expected String or List<String>.");
    return [];
  }
  // 为每个路径添加前缀（如果需要）
  return imageList.map((img) {
    return img.startsWith(httpStartWithPrefix) ? img : "$urlPrefix$img";
  }).toList();
}

//【选中】这张图片的监听:index 是当前索引，imagePath 是图片路径，selectState 是选中状态，selectYesList是最新已经选中状态的数据列表
typedef SelectLastTimeCallback = void Function({
  required int index,
  required String imagePath,
  required bool selectState,
  required List<ImageOrFileWithState>? selectLastTimeList,
});

class ImageGridViewWithState extends StatefulWidget {
  final String? title;
  final TextStyle? titleStyle;
  //限制上传的数量:例如：最多只能上传9张图
  final int maxCanUpLoad;
  //限制只能选中几张图片
  final int limitSelectMaxNumber;
  final bool? readOnly;
  // 是否需要上传附件，有的要传递，有的不传递
  final bool? hasUpLoadAnnex;
  // 默认直接-跳转到相册选择，不弹窗选择
  final bool? jumpAlbum;
  // 可以是路径、也可以是url
  final List<ImageOrFileWithState>? imagesOrPdfs;
  // 文件名称
  final List<String>? fileNames;
  final void Function(List<String>)? addCallback;
  final void Function(List<String>, dynamic)? deleteCallback;
  //[选中]或者[未选中]这张图片的监听器，永远都是给最新状态的值传递出去
  final SelectLastTimeCallback? selectLastTimeCallback;
  //未选中这张图片的监听器
  // final SelectNoCallback? selectNoCallback;
  //原始图片池子，用来做比对的
  // final List<ImageOrPdfWithState>? imagesOriginalPool;
  const ImageGridViewWithState({
    super.key,
    this.title,
    this.titleStyle,
    this.maxCanUpLoad = 9, //默认是9，也可以自定义限制上传N张图
    this.readOnly = false,
    this.imagesOrPdfs,
    this.fileNames,
    this.addCallback,
    this.deleteCallback,
    this.hasUpLoadAnnex = false, // 默认给false，需要传附件就给true
    this.jumpAlbum = false,
    this.selectLastTimeCallback, //选中的监听
    required this.limitSelectMaxNumber,
    // this.selectLastTimeCallback, //未选中的监听
    // this.imagesOriginalPool, //原始的携带状态的图片池
  });
  @override
  State<ImageGridViewWithState> createState() => _ImageGridViewState2();
}

class _ImageGridViewState2 extends State<ImageGridViewWithState> {
  List<ImageOrFileWithState>? mSelectYesList = [];
  //被选中的对象位置和对象的对应关系
  List<Map<String, ImageOrFileWithState>>? mapTempList = [];
  // List<Map<int, int>>? mapTempList = [];
  List<String> filePaths = [];
  int? draggingIndex;

  @override
  void initState() {
    super.initState();
    logger.d("initState--initState--initState--initState");

    //首先创建一个只有9个长度的集合，内部存放的是空对象。
    _resetSelectYesList();

  }

  //写成固定的9个标签内容。
  funKeyValue9() {
    for (int position = 0; position < widget.imagesOrPdfs!.length; ++position) {
      //
      ImageOrFileWithState element = widget.imagesOrPdfs![position];
      //对象的id
      num? accessoryId = element.accessoryId;
      bool? currentSelectValue = element.selectState;
      //
      Map<String, ImageOrFileWithState> mapTemp = {};
      //
      if (!ObjectUtil.isEmpty(currentSelectValue)) {
        if (currentSelectValue!) {
          //筛选【被选中】的集合携带到外侧列表，
          if (!ObjectUtil.isEmpty(accessoryId)) {
            //第一种方式:
            //mapTemp.putIfAbsent(position, () => element);
            //第二种方式:
            //先赋值勾中的位置
            element.clickCheckedTruePosition = position;
            //
            if (!ObjectUtil.isEmpty(accessoryId)) {
              String accessoryIdKey = accessoryId!.toString();
              mapTemp[accessoryIdKey] = element;
            }
            //填充map
            //如果集合长度小于9，那么就继续添加
            if (mapTempList!.length < imageGridViewLengthShare) {
              mapTempList?.add(mapTemp);
            } else {
              logger.d("mapTempList-mapTempList-长度超过9位");
            }
            //
          }
        }
      }
    }
    //
    testMap();
  }

  //这种思想暂时不用
  funKeyValue() {
    //维护位置和对象对应关系。
    /*for (int position = 0; position < widget.imagesOrPdfs!.length; ++position) {
      //
      ImageOrFileWithState element = widget.imagesOrPdfs![position];
      //对象的id
      num? accessoryId = element.accessoryId;
      bool? currentSelectValue = element.selectState;
      //
      Map<String, ImageOrFileWithState> mapTemp = {};
      if (!ObjectUtil.isEmpty(currentSelectValue)) {
        if (currentSelectValue!) {
          //筛选【被选中】的集合携带到外侧列表，
          if (!ObjectUtil.isEmpty(accessoryId)) {
            //第一种方式:
            //mapTemp.putIfAbsent(position, () => element);
            //第二种方式:
            element.clickCheckedTruePosition = position;
            //
            if (!ObjectUtil.isEmpty(accessoryId)) {
              String accessoryIdKey = accessoryId!.toString();
              mapTemp[accessoryIdKey] = element;
            }
            //填充map
            //如果集合长度小于9，那么就继续添加
            if (mapTempList!.length < imageGridViewLengthShare) {
              mapTempList?.add(mapTemp);
            } else {
              logger.d("mapTempList-mapTempList-长度超过9位");
            }
            //
          }
        }
      }
    }
    testMap();*/
    //--------------------------------------------------
    //如果遍历完毕，发现不够9位，那么需要补充
    /*if (mapTempList!.length < imageGridViewLengthShare) {
      //
      Map<num, ImageOrFileWithState> mapTemp = {};
      //第一种写法
      //mapTemp[imageGridViewLengthShare-mapTempList!.length] = ImageOrFileWithState();
      //第二种写法
      mapTemp.putIfAbsent(, () => ImageOrFileWithState());
      //
      mapTempList!.add(mapTemp);
      //
    } else {
      logger.d("mapTempList-长度是不小于9位的");
    }*/

    // logger.d("mapTempList-提取选中的位置对应关系=>$mapTempList");
  }

  testMap() {
    //测试放开
    if ((mapTempList != null) && (mapTempList!.isNotEmpty)) {
      for (var index = 0; index < mapTempList!.length; ++index) {
        var mapElement = mapTempList![index];
        logger.d("mapTempList-提取选中的位置对应关系=>'\n'位置=$index${CommonTools.prettyJsonStringSimple(mapElement)}");
      }
    }
  }

  //@timeLast 2025/3/31 原始代码，能用，但是有点小问题
  /*_resetSelectYesList() {
    //清空是必要的
    if (mSelectYesList!.isNotEmpty) {
      mSelectYesList!.clear();
    }
    //第一种循环方式好像不适合
    //这里首选需要确定选中了几个的列表，单独装载,目的是为了小红点数字
    for (ImageOrFileWithState element in widget.imagesOrPdfs!) {
      bool? currentSelect = element.selectState;
      if (!ObjectUtil.isEmpty(currentSelect)) {
        if (currentSelect!) {
          //筛选【被选中】的集合携带到外侧列表，
          mSelectYesList?.add(element);
        }
      }
    }
  }*/

  //重置选中的九宫格-预备改造成：以顺序点击123456789.不自动排数字。
  _resetSelectYesList() {
    //清空是必要的
    if (mSelectYesList!.isNotEmpty) {
      mSelectYesList!.clear();
    }
    //第一种循环方式好像不适合
    //这里首选需要确定选中了几个的列表，单独装载,目的是为了小红点数字
    for (ImageOrFileWithState element in widget.imagesOrPdfs!) {
      bool? currentSelect = element.selectState;
      if (!ObjectUtil.isEmpty(currentSelect)) {
        if (currentSelect!) {
          //筛选【被选中】的集合携带到外侧列表，
          mSelectYesList?.add(element);
        }
      }
    }
    //第二种遍历方式：如果需要记录index用这种
    //
    logger.d("mSelectYesList-最终被选中的=>${CommonTools.prettyJsonStringSimple(mSelectYesList)}");

    /*for (int position = 0; position < widget.imagesOrPdfs!.length; ++position) {
      ImageOrFileWithState element = widget.imagesOrPdfs![position];
      bool? currentSelect = element.selectState;
      if (!ObjectUtil.isEmpty(currentSelect)) {
        if (currentSelect!) {
          //筛选【被选中】的集合携带到外侧列表，
          mSelectYesList?.add(element);
          //填充map
        }
      }
      //
    }*/
  }

  // 点击图片进入预览界面
  void _previewImage(int index) {
    Navigator.of(context).push(
      PageRouteBuilder(
        opaque: false,
        barrierColor: Colors.transparent,
        pageBuilder: (BuildContext context, _, __) {
          List<String> list = [];
          if (!ObjectUtil.isEmptyList(widget.imagesOrPdfs)) {
            List<String> list = widget.imagesOrPdfs!.map((e) => e.imagePath!).toList();
            return SimplePicsWiper(url: list[index], images: list);
          } else {
            //已经是空了,打开没东西
            return SimplePicsWiper(url: list[index], images: list);
          }
        },
      ),
    );
  }

  _setupTitle() {
    return Container(
      alignment: Alignment.centerLeft,
      padding: const EdgeInsets.fromLTRB(0, 0, 0, 10),
      child: Text(widget.title ?? "", style: widget.titleStyle ?? const TextStyle(fontSize: 14, color: Colors.black)),
    );
  }

  @override
  Widget build(BuildContext context) {
    logger.d("build--build--build--build--build---build---build");
    // filterImagePaths();
    return Column(
      children: [
        if (widget.title != null) _setupTitle(),
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
                            child: Text(
                                widget.fileNames != null &&
                                        widget.fileNames!.isNotEmpty && //
                                        index < widget.fileNames!.length
                                    ? widget.fileNames![index]
                                    : (index < filePaths.length ? filePaths[index].split('/').last : ''), //
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
                                      widget.imagesOrPdfs?.remove(delete);
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
          // onReorder: _onReorder,
          crossAxisCount: 3,
          crossAxisSpacing: 4,
          mainAxisSpacing: 4,
          shrinkWrap: true, // 根据内容大小而变
          physics: const NeverScrollableScrollPhysics(),
          padding: const EdgeInsets.fromLTRB(2, 2, 2, 2),
          children: _setupItemsTwo(),
          dragWidgetBuilder: (int index, Widget child) {
            return Transform.scale(
              scale: 1.1,
              child: Material(
                elevation: 10.0,
                child: child,
              ),
            );
          },
          onReorder: (int oldIndex, int newIndex) {},
        )
      ],
    );
  }

  //timeUpdate 2025/3/31 原始代码，能用，我第二次做改造
  List<Widget> _setupItemsTwo() {
    logger.d("setupItems--setupItems--setupItems--setupItems--setupItems--setupItems");
    List<Widget> images = [];
    if (!ObjectUtil.isEmptyList(widget.imagesOrPdfs)) {
      //------------------------------------------------------
      //数字索引
      int positionNumber = 0;
      //第一种循环方式
      /*for (int index = 0; index < widget.imagesOrPdfs!.length; index++) {
        ImageOrFileWithState imageOrPdfWithState = widget.imagesOrPdfs![index];
        num? accessoryId = imageOrPdfWithState.accessoryId; //图片id
        String? imagePathItem = imageOrPdfWithState.imagePath; //当前路径
        bool? selectStateItem = imageOrPdfWithState.selectState; //当前被选中的状态
        bool? selectYes = selectStateItem; //勾中状态变化
        bool? selectNo = !selectStateItem!; //勾灭状态变化
        //logger.d("position符合条件的是-->$position");
        if (!ObjectUtil.isEmptyList(mSelectYesList)) {
          for (int curPos = 0; curPos < mSelectYesList!.length; ++curPos) {
            ImageOrFileWithState itemYes = mSelectYesList![curPos];
            if (itemYes.accessoryId == accessoryId) {
              positionNumber = curPos;
              // logger.d("发现选中相等的位置是-positionNumber=>$positionNumber");
              break;
            }
          }
        }*/
      //----------------------------------------------------------------------------------
      //遍历键值对，如果列表内已经有，原始是true,那就重置为空。如果是false，这时候选中了，就填充个值。
      for (int index = 0; index < widget.imagesOrPdfs!.length; index++) {
        ImageOrFileWithState imageOrPdfWithState = widget.imagesOrPdfs![index];
        num? accessoryId = imageOrPdfWithState.accessoryId; //图片id
        String? imagePathItem = imageOrPdfWithState.imagePath; //当前路径
        bool? selectStateItem = imageOrPdfWithState.selectState; //当前被选中的状态
        bool? selectYes = selectStateItem; //勾中状态变化
        bool? selectNo = !selectStateItem!; //勾灭状态变化

        //logger.d("position符合条件的是-->$position");

        if (!ObjectUtil.isEmptyList(mSelectYesList)) {
          for (int curPos = 0; curPos < mSelectYesList!.length; ++curPos) {
            ImageOrFileWithState itemYes = mSelectYesList![curPos];
            if (itemYes.accessoryId == accessoryId) {
              positionNumber = curPos;
              // logger.d("发现选中相等的位置是-positionNumber=>$positionNumber");
              break;
            }
          }
        }
        //------------------------------------------------------------------------------------

        if (!ObjectUtil.isEmptyString(imagePathItem)) {
          final item = Stack(
            key: UniqueKey(),
            children: [
              GestureDetector(
                onTap: () => _previewImage(index),
                child: Row(
                  children: [
                    Expanded(
                      child: imagePathItem!.startsWith(httpStartWithPrefix)
                          ? imageNetwork(
                              imagePathItem,
                              fit: BoxFit.cover,
                              loading: CircularProgressIndicator(),
                            )
                          : imageFile(
                              File(imagePathItem),
                              fit: BoxFit.cover,
                            ),
                    )
                  ],
                ),
              ),
              if (widget.readOnly == false)
                Positioned(
                  right: 0,
                  top: 0,
                  child: GestureDetector(
                    // onTap: () => _removeImage(index),
                    child: Container(
                      color: Colors.black54,
                      child: const Icon(
                        Icons.close,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
              Positioned(
                //选中之后-显示数字的圈圈
                //携带图片的序号1、2、3、4
                left: 7.0,
                top: 7.0,
                child: Visibility(
                  visible: selectYes ?? false,
                  child: InkWell(
                    onTap: () {
                      setState(() {
                        //@bugTime 2025/3/30发现这里有bug，数字应该是第几次选中点击，位置顺序就是第几次。
                        for (int position = 0; position < widget.imagesOrPdfs!.length; ++position) {
                          String? path = widget.imagesOrPdfs![position].imagePath;
                          bool? selectState = widget.imagesOrPdfs![position].selectState;
                          if (path == widget.imagesOrPdfs![index].imagePath && (selectState!)) {
                            //如果被选中了就勾灭
                            widget.imagesOrPdfs![position].selectState = false;
                            _resetSelectYesList();
                            if (!ObjectUtil.isEmpty(widget.selectLastTimeCallback)) {
                              widget.selectLastTimeCallback!(
                                index: index,
                                imagePath: widget.imagesOrPdfs![index].imagePath!,
                                selectState: true,
                                selectLastTimeList: mSelectYesList,
                              );
                            }
                            break;
                          }
                        }
                        //查看图片的状态信息
                        //logger.d("imagesOriginalPool变更之后的状态是->${CommonTools.prettyJsonStringSimple(widget.imagesOriginalPool)}");
                      });
                    },
                    child: DotWidget(
                      textNumber: (positionNumber + 1).toString(),
                      height: 24,
                      width: 24,
                      borderRadius: BorderRadius.circular(14),
                      fontSize: 14.0,
                      padding: EdgeInsets.fromLTRB(4, 2, 4, 4),
                    ),
                  ),
                ),
              ),
              Positioned(
                  //未选中之后:是一个空心对钩，做点击操作。
                  left: 6.0,
                  top: 6.0,
                  child: Visibility(
                    visible: selectNo ?? false,
                    child: InkWell(
                        onTap: () {
                          if (!ObjectUtil.isEmptyList(mSelectYesList)) {
                            if (mSelectYesList!.length >= widget.limitSelectMaxNumber) {
                              showAlertMessage("最多只能选择${widget.limitSelectMaxNumber}张图片");
                              return;
                            }
                          }

                          setState(() {
                            for (int position = 0; position < widget.imagesOrPdfs!.length; ++position) {
                              String? path = widget.imagesOrPdfs![position].imagePath;
                              bool? selectState = widget.imagesOrPdfs![position].selectState;
                              if (path == widget.imagesOrPdfs![index].imagePath && !(selectState!)) {
                                //如果是勾灭的，就勾中。
                                widget.imagesOrPdfs![position].selectState = true;
                                _resetSelectYesList();
                                if (!ObjectUtil.isEmpty(widget.selectLastTimeCallback)) {
                                  widget.selectLastTimeCallback!(
                                    index: index,
                                    imagePath: widget.imagesOrPdfs![index].imagePath!,
                                    selectState: false,
                                    selectLastTimeList: mSelectYesList,
                                  );
                                }
                                break;
                              }
                            }
                            //查看图片的状态信息
                            //logger.d("imagesOriginalPool变更之后的状态是->${CommonTools.prettyJsonStringSimple(widget.imagesOriginalPool)}");
                          });
                        },
                        child: imageAsset(AssetsRes.MULTIPIC_NINEPHOTO_DISABLE, width: 26)),
                  )),
            ],
          );
          images.add(item);
        }
      }
    }

    if (!ObjectUtil.isEmptyList(widget.imagesOrPdfs)) {
      if (widget.readOnly == false && widget.imagesOrPdfs!.length < widget.maxCanUpLoad) {
        final addButton = GestureDetector(
          key: const ValueKey('add_button'),
          // onTap: _addButtonPressed,
          child: Container(
            color: Colors.grey[200],
            child: const Icon(Icons.add),
          ),
        );
        images.add(addButton);
      }
    }
    return images;
  }
}

/*List<Widget> _setupItems() {

    logger.d("setupItems--setupItems--setupItems--setupItems--setupItems--setupItems");

    List<Widget> images = [];
    if (!ObjectUtil.isEmptyList(widget.imagesOrPdfs)) {
      //------------------------------------------------------
      //数字索引
      int positionNumber = 0;
      for (int index = 0; index < widget.imagesOrPdfs!.length; index++) {
        ImageOrFileWithState imageOrPdfWithState = widget.imagesOrPdfs![index];
        num? accessoryId = imageOrPdfWithState.accessoryId; //图片id
        String? imagePathItem = imageOrPdfWithState.imagePath; //当前路径
        bool? selectStateItem = imageOrPdfWithState.selectState; //当前被选中的状态
        bool? selectYes = selectStateItem; //勾中状态变化
        bool? selectNo = !selectStateItem!; //勾灭状态变化
        //logger.d("position符合条件的是-->$position");
        if (!ObjectUtil.isEmptyList(mSelectYesList)) {
          for (int curPos = 0; curPos < mSelectYesList!.length; ++curPos) {
            ImageOrFileWithState itemYes = mSelectYesList![curPos];
            if (itemYes.accessoryId == accessoryId) {
              positionNumber = curPos;
              // logger.d("发现选中相等的位置是-positionNumber=>$positionNumber");
              break;
            }
          }
        }
        //------------------------------------------------------

        if (!ObjectUtil.isEmptyString(imagePathItem)) {
          final item = Stack(
            key: UniqueKey(),
            children: [
              GestureDetector(
                onTap: () => _previewImage(index),
                child: Row(
                  children: [
                    Expanded(
                      child: imagePathItem!.startsWith(httpStartWithPrefix)
                          ? imageNetwork(
                              imagePathItem,
                              fit: BoxFit.cover,
                              loading: CircularProgressIndicator(),
                            )
                          : imageFile(
                              File(imagePathItem),
                              fit: BoxFit.cover,
                            ),
                    )
                  ],
                ),
              ),
              if (widget.readOnly == false)
                Positioned(
                  right: 0,
                  top: 0,
                  child: GestureDetector(
                    // onTap: () => _removeImage(index),
                    child: Container(
                      color: Colors.black54,
                      child: const Icon(
                        Icons.close,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
              Positioned(
                //选中之后-显示数字的圈圈
                //携带图片的序号1、2、3、4
                left: 7.0,
                top: 7.0,
                child: Visibility(
                  visible: selectYes ?? false,
                  child: InkWell(
                    onTap: () {
                      setState(() {
                        //@bugTime 2025/3/30发现这里有bug，数字应该是第几次选中点击，位置顺序就是第几次。
                        for (int position = 0; position < widget.imagesOrPdfs!.length; ++position) {
                          String? path = widget.imagesOrPdfs![position].imagePath;
                          bool? selectState = widget.imagesOrPdfs![position].selectState;
                          if (path == widget.imagesOrPdfs![index].imagePath && (selectState!)) {
                            //如果被选中了就勾灭
                            widget.imagesOrPdfs![position].selectState = false;
                            _resetSelectYesList();
                            if (!ObjectUtil.isEmpty(widget.selectLastTimeCallback)) {
                              widget.selectLastTimeCallback!(
                                index: index,
                                imagePath: widget.imagesOrPdfs![index].imagePath!,
                                selectState: true,
                                selectLastTimeList: mSelectYesList,
                              );
                            }
                            break;
                          }
                        }
                        //查看图片的状态信息
                        //logger.d("imagesOriginalPool变更之后的状态是->${CommonTools.prettyJsonStringSimple(widget.imagesOriginalPool)}");
                      });
                    },
                    child: DotWidget(
                      textNumber: (positionNumber + 1).toString(),
                      height: 28,
                      width: 28,
                      borderRadius: BorderRadius.circular(14),
                      fontSize: 14.0,
                      padding: EdgeInsets.fromLTRB(4, 4, 4, 4),
                    ),
                  ),
                ),
              ),
              Positioned(
                  //未选中之后:是一个空心对钩，做点击操作。
                  left: 6.0,
                  top: 6.0,
                  child: Visibility(
                    visible: selectNo ?? false,
                    child: InkWell(
                        onTap: () {
                          if (!ObjectUtil.isEmptyList(mSelectYesList)) {
                            if (mSelectYesList!.length >= widget.limitSelectMaxNumber) {
                              showAlertMessage("最多只能选择${widget.limitSelectMaxNumber}张图片");
                              return;
                            }
                          }

                          setState(() {
                            for (int position = 0; position < widget.imagesOrPdfs!.length; ++position) {
                              String? path = widget.imagesOrPdfs![position].imagePath;
                              bool? selectState = widget.imagesOrPdfs![position].selectState;
                              if (path == widget.imagesOrPdfs![index].imagePath && !(selectState!)) {
                                //如果是勾灭的，就勾中。
                                widget.imagesOrPdfs![position].selectState = true;
                                _resetSelectYesList();
                                if (!ObjectUtil.isEmpty(widget.selectLastTimeCallback)) {
                                  widget.selectLastTimeCallback!(
                                    index: index,
                                    imagePath: widget.imagesOrPdfs![index].imagePath!,
                                    selectState: false,
                                    selectLastTimeList: mSelectYesList,
                                  );
                                }
                                break;
                              }
                            }
                            //查看图片的状态信息
                            //logger.d("imagesOriginalPool变更之后的状态是->${CommonTools.prettyJsonStringSimple(widget.imagesOriginalPool)}");
                          });
                        },
                        child: imageAsset(AssetsRes.MULTIPIC_NINEPHOTO_DISABLE, width: 32)),
                  )),
            ],
          );
          images.add(item);
        }
      }
    }

    if (!ObjectUtil.isEmptyList(widget.imagesOrPdfs)) {
      if (widget.readOnly == false && widget.imagesOrPdfs!.length < widget.maxCanUpLoad) {
        final addButton = GestureDetector(
          key: const ValueKey('add_button'),
          // onTap: _addButtonPressed,
          child: Container(
            color: Colors.grey[200],
            child: const Icon(Icons.add),
          ),
        );
        images.add(addButton);
      }
    }
    return images;
  }*/

// SfPdfViewer.memory(bytes));
// SfPdfViewer.asset('assets/flutter-succinctly.pdf'));
// SfPdfViewer.file(File('storage/emulated/0/Download/flutter-succinctly.pdf')));
// SfPdfViewer.network('https://cdn.syncfusion.com/content/PDFViewer/encrypted.pdf', password: 'syncfusion')));
/*class PdfPreviewScreen extends StatelessWidget {
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
      appBar: AppBar(title: Text('PDF预览')),
      body: pdfViewer,
    );
  }
}*/

// 过滤去重并保持索引
// filterImagePaths() {
//   widget.imagesOrPdfs = widget.imagesOrPdfs ?? [];
//   if (widget.imagesOrPdfs == null || widget.imagesOrPdfs!.isEmpty) {
//     filePaths.clear();
//     imagePaths.clear();
//   }
//   for (ImageOrPdfWithState imageItem in widget.imagesOrPdfs!) {
//     String? imagePath = imageItem.imagePath;
//     if (!ObjectUtil.isEmptyString(imagePath)) {
//       if (RegExp(r'\.(png|jpe?g|gif)$', caseSensitive: false).hasMatch(imagePath!)) {
//         imagePaths.add(imagePath);
//       }
//       if (RegExp(r'\.(pdf|docx?|xlsx?)$', caseSensitive: false).hasMatch(imagePath)) {
//         filePaths.add(imagePath);
//       }
//     }
//   }
//
//   imagePaths = imagePaths.toSet().toList();
//   filePaths = filePaths.toSet().toList();
// }

// 删除按钮的点击事件
// void _removeImage(int index) {
//   if (index < 0 || index >= imagePaths.length) {
//     return;
//   }
//   final delete = imagePaths[index];
//   setState(() {
//     imagePaths.remove(delete);
//     widget.imagesOrPdfs?.remove(delete);
//     if (widget.deleteCallback != null) {
//       widget.deleteCallback!(imagePaths, delete);
//     }
//   });
// }

/*Widget _createAddButton() {
    return GestureDetector(
      key: const ValueKey('add_button'),
      // onTap: _addButtonPressed,
      child: Container(
        color: Colors.grey[200],
        child: const Icon(Icons.add, size: 40),
      ),
    );
  }*/

// 点击了添加图片的按钮
// Future<void> _addButtonPressed() async {
//   // FocusScope.of(context).requestFocus(FocusNode());
//   if (widget.jumpAlbum ?? false) {
//     //如果默认是：直接跳转到相册选择，不弹窗让用户选择
//     ShowCameraPhotoFile.defaultOpenToAlbum(context, max: widget.max - imagePaths.length, complete: (data) => callBackComplete.call(data));
//   } else {
//     //isDefaultToAlbum默认是false,意思是：大多数默认情况是让用户弹窗选择的
//     if (!ObjectUtil.isEmpty(widget.hasUpLoadAnnex ?? false)) {
//       if (widget.hasUpLoadAnnex!) {
//         ShowCameraPhotoFile.all(context, max: widget.max - imagePaths.length, complete: (data) => callBackComplete.call(data));
//       } else {
//         ShowCameraPhotoFile.cameraPhoto(context, max: widget.max - imagePaths.length, complete: (data) => callBackComplete.call(data));
//       }
//     } else {
//       ShowCameraPhotoFile.all(context, max: widget.max - imagePaths.length, complete: (data) => callBackComplete.call(data));
//     }
//   }
// }

/*_callBackComplete(data) {
    for (var path in data) {
      if (RegExp(r'\.(png|jpe?g|gif)$', caseSensitive: false).hasMatch(path)) {
        widget.imagesOrPdfs?.add(path);
      }
      if (RegExp(r'\.(pdf|docx?|xlsx?)$', caseSensitive: false).hasMatch(path)) {
        filePaths.add(path);
      }
    }
    // 图片数组、文件数组
    //List<String> list = [...widget.images ?? [], ...filePaths];
    List<String> list = [];
    if (!ObjectUtil.isEmptyList(widget.imagesOrPdfs)) {
      for (ImageOrFileWithState element in widget.imagesOrPdfs!) {
        if (!ObjectUtil.isEmptyString(element.imagePath)) {
          list.add(element.imagePath!);
        }
      }
    }

    list.addAll(filePaths);

    widget.addCallback!(list);

    setState(() {});
  }*/

// void _onReorder(int oldIndex, int newIndex) {
//   // 如果拖拽的是最后一个元素，即加号按钮，直接返回
//   if (oldIndex == imagePaths.length) return;
//
//   // 如果新索引大于当前图片数量，修正新索引到最后一个图片的位置
//   if (newIndex >= imagePaths.length) {
//     newIndex = imagePaths.length - 1;
//   }
//   setState(() {
//     final item = imagePaths.removeAt(oldIndex);
//     imagePaths.insert(newIndex, item);
//   });
// }

///@description 携带状态的图片实体
///@updateTime 2024/11/9 20:38
class ImageOrFileWithState {
  //图片或者pdf的标志唯一id.
  num? accessoryId;
  //图片的或者pdf链接或者地址.
  String? imagePath;
  //图片的选中状态
  bool? selectState;
  //当前是选中的位置
  int? positionIsTrue;
  //被选中的 索引，其实就等于位置number
  int? clickCheckedTruePosition;

  ImageOrFileWithState({
    this.accessoryId,
    this.imagePath,
    this.selectState,
    this.positionIsTrue,
    this.clickCheckedTruePosition,
  });
  factory ImageOrFileWithState.fromJson(Map<String, dynamic> json) {
    return ImageOrFileWithState(
      accessoryId: json['accessoryId'],
      imagePath: json['imagePath'],
      selectState: json['selectState'],
      positionIsTrue: json['positionIsTrue'],
      clickCheckedTruePosition: json['clickCheckedTruePosition'],
    );
  }

  Map<String, dynamic> toJson() => {
        'accessoryId': accessoryId,
        'imagePath': imagePath,
        'selectState': selectState,
        'positionIsTrue': positionIsTrue,
        'clickCheckedTruePosition': clickCheckedTruePosition,
      };

  @override
  String toString() {
    return 'ImageOrFileWithState{accessoryId: $accessoryId, imagePath: $imagePath, selectState: $selectState, positionIsTrue: $positionIsTrue, clickCheckedTruePosition: $clickCheckedTruePosition}';
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is ImageOrFileWithState &&
          runtimeType == other.runtimeType &&
          accessoryId == other.accessoryId &&
          imagePath == other.imagePath &&
          selectState == other.selectState &&
          positionIsTrue == other.positionIsTrue &&
          clickCheckedTruePosition == other.clickCheckedTruePosition;

  // @override
  // int get hashCode => accessoryId.hashCode ^ imagePath.hashCode ^ selectState.hashCode ^ positionIsTrue.hashCode ^ clickCheckedTruePosition.hashCode;
  // @override
  // bool operator ==(Object other) => identical(this, other) || other is ImageOrFileWithState && runtimeType == other.runtimeType && accessoryId == other.accessoryId && imagePath == other.imagePath && selectState == other.selectState;

  //仅仅用两个判断即可。
  @override
  int get hashCode => accessoryId.hashCode ^ imagePath.hashCode ^ selectState.hashCode;
}
