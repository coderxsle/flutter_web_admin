import 'package:auto_shop_server/common/index.dart';
import 'package:auto_shop_server/app/utils/common_widget/upload_image_view_with_state.dart';
import 'package:auto_shop_server/app/utils/global.dart';
import 'package:auto_shop_server/res/assets_res.dart';
import 'package:reorderable_grid_view/reorderable_grid_view.dart';

import '../../../base/image_browser/simple_pics_wiper.dart';

//【选中】这张图片的监听:index 是当前索引，imagePath 是图片路径，selectState 是选中状态，selectYesList是最新已经选中状态的数据列表
typedef SelectLastTimeSingleClickCallbackForDownLoad = void Function({
  required int index,
  required String imagePath,
  required bool selectState,
  required List<ImageOrFileWithState>? selectLastTimeList,
});

///@description 图片批量下载的图片单独九宫格
///@updateTime 2025/5/6 17:37
class ImageGridViewWithStateForDownLoad extends StatefulWidget {
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
  //[选中]或者[未选中]这张图片的监听器，永远都是给最新状态的值传递出去
  final SelectLastTimeSingleClickCallbackForDownLoad? selectLastSingleClickTimeCallback;
  //未选中这张图片的监听器
  // final SelectNoCallback? selectNoCallback;
  //原始图片池子，用来做比对的
  // final List<ImageOrPdfWithState>? imagesOriginalPool;
  const ImageGridViewWithStateForDownLoad({
    super.key,
    this.title,
    this.titleStyle,
    //默认是9，也可以自定义限制上传N张图
    this.maxCanUpLoad = 9,
    this.readOnly = false,
    this.imagesOrPdfs,
    this.fileNames,
    // 默认给false，需要传附件就给true
    this.hasUpLoadAnnex = false,
    this.jumpAlbum = false,
    //选中的监听
    this.selectLastSingleClickTimeCallback,
    required this.limitSelectMaxNumber,
  });
  @override
  State<ImageGridViewWithStateForDownLoad> createState() => _ImageGridViewStateDownLoad();
}

class _ImageGridViewStateDownLoad extends State<ImageGridViewWithStateForDownLoad> {
  List<ImageOrFileWithState>? mSelectYesList = [];
  //被选中的对象位置和对象的对应关系
  List<Map<String, ImageOrFileWithState>>? mapTempList = [];
  // List<Map<int, int>>? mapTempList = [];
  // List<String> filePaths = [];
  int? draggingIndex;

  @override
  void initState() {
    super.initState();
    logger.d("initState--initState--initState--initState");

    //首先创建一个只有9个长度的集合，内部存放的是空对象。
    _resetSelectYesList();
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
      // int positionNumber = 0;
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

        // if (!ObjectUtil.isEmptyList(mSelectYesList)) {
        //   for (int curPos = 0; curPos < mSelectYesList!.length; ++curPos) {
        //     ImageOrFileWithState itemYes = mSelectYesList![curPos];
        //     if (itemYes.accessoryId == accessoryId) {
        //       positionNumber = curPos;
        //       // logger.d("发现选中相等的位置是-positionNumber=>$positionNumber");
        //       break;
        //     }
        //   }
        // }
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
                left: 5.0,
                top: 5.0,
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
                            if (!ObjectUtil.isEmpty(widget.selectLastSingleClickTimeCallback)) {
                              widget.selectLastSingleClickTimeCallback!(
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
                    // child: DotWidget(
                    //   textNumber: (positionNumber + 1).toString(),
                    //   height: 24,
                    //   width: 24,
                    //   borderRadius: BorderRadius.circular(14),
                    //   fontSize: 14.0,
                    //   padding: EdgeInsets.fromLTRB(4, 2, 4, 4),
                    // ),
                      child: imageAsset(AssetsRes.MULTIPIC_NINEPHOTO_SELECTED, width: 24),
                  ),
                ),
              ),
              Positioned(
                  //未选中之后:是一个空心对钩，做点击操作。
                  left: 5.0,
                  top: 5.0,
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
                                if (!ObjectUtil.isEmpty(widget.selectLastSingleClickTimeCallback)) {
                                  widget.selectLastSingleClickTimeCallback!(
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
                        child: imageAsset(AssetsRes.MULTIPIC_NINEPHOTO_DISABLE, width: 24)),
                  )),
            ],
          );
          images.add(item);
        }
      }
    }

    return images;
  }
}
