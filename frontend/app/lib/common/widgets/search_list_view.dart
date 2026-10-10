import 'dart:async';

import 'package:auto_shop_server/app/utils/common_widget/logger.dart';
import 'package:auto_shop_server/res/assets_res.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';
import 'package:pinyin/pinyin.dart';

/// 显示一个可选择和搜索的列表视图弹窗。
///
/// `SearchListView` 类的 `show` 方法用于显示一个列表选择视图的弹出框，
/// 列表数据通过 `models` 参数传入，用户可以在其中进行选择操作。
///
/// - `title`: 弹窗的标题文本。默认为空，即显示标题：请选择，符合通用的弹窗标题。传入的字符串将作为标题显示在弹窗顶部。
/// - `keyword`: 搜索框的默认值。
/// - `models`: 必填参数，表示显示在列表中的数据模型的集合。每个数据模型必须是 `SearchListViewModel` 类型，
///   包含了展示给用户的数据（例如：图片 URL、标题和 ID）。
/// - `isSort`: 可选参数，表示是否对传入的 `models` 按 `title` 的首个汉字拼音首字母进行排序。
///   默认值为 `true`，即根据 `title` 的首个汉字拼音首字母进行升序排列。若设置为 `false`，则按传入的顺序显示数据而不进行排序。
/// - `onSelected`: 必填参数，当用户在弹出框中选择了某个项目时触发的回调函数。此回调函数将返回所选择的
///
/// # 使用示例:
///
/// ```dart
/// // 定义一些示例数据
/// List<SearchListViewModel> data = [
///   SearchListViewModel(imageUrl: 'https://example.com/logo1.png', title: 'Brand A', id: '1'),
///   SearchListViewModel(imageUrl: 'https://example.com/logo2.png', title: 'Brand B', id: '2'),
///   SearchListViewModel(imageUrl: 'https://example.com/logo3.png', title: 'Brand C', id: '3'),
/// ];
///
/// // 调用 show 方法显示弹窗
/// SearchListView.show(
///   title: '请选择品牌', // 弹窗标题
///   keyword: 'Brand', // 搜索框的默认值
///   models: data, // 显示的列表数据
///   isSort: false, // 是否进行排序
///   onSelected: (selectedModel) {
///     // 用户选择某个列表项时的处理逻辑
///     print('用户选择了: ${selectedModel.title}');
///   },
/// );
/// ```
///
/// 调用上述代码时，用户将看到一个包含 `data` 中品牌的选择列表，点击某个品牌时，会在控制台打印该品牌的名称。
///
/// # 注意事项:
/// 如果`isSort` 参数为`false`，那么将不会进行拼音检索，和排序。

class SearchListView {
  static show(BuildContext context, {String? title, required List<SearchListViewModel> models, bool? isNeedIndexBar, bool? isSort, String? keyword, required SelectedCallBack onSelected, SearchCallBack? onSearch}) {
    showCupertinoModalBottomSheet(
      // expand: true, // 弹窗高度填满整个可用屏幕高度
      // height: 300, // 自定义高度
      expand: false,
      context: context,
      barrierColor: Colors.black.withOpacity(0.7),
      builder: (context) => SizedBox(
        height: MediaQuery.of(context).size.height * 0.85,
        child: _SelectListView(title: title, models: models, isNeedIndexBar: isNeedIndexBar ?? true, isSort: isSort ?? false, keyword: keyword, onSelected: onSelected, onSearch: onSearch),
      ),
    );
  }
}

// 忽略该文件所有的拼写命名警告
// ignore_for_file: constant_identifier_names
typedef SelectedCallBack = void Function(SearchListViewModel model);
typedef SearchCallBack = Future<List<SearchListViewModel>> Function(String keyword);

const ROW_HEIGHT = 44.0;
const GROUP_HEIGHT = 30.0;
const List<String> WORDS = [
  // '🔍', '☆',
  '#', 'A', 'B', 'C', 'D', 'E', 'F', 'G', 'H', 'I', 'J', 'K', 'L', 'M', 'N',
  'O', 'P', 'Q', 'R', 'S', 'T', 'U', 'V', 'W', 'X', 'Y', 'Z'
];

// 数据模型
class SearchListViewModel {
  String? title, subTitle, imageAssets, imageUrl, indexLetter;
  int? id;
  // 用于传递数据模型(有时候需要选中的内容不仅仅只是使用 id 和 title 字段，需要更多的字段，可以直接使用原来的 model)
  dynamic model;
  SearchListViewModel({
    this.title,
    this.subTitle,
    this.id,
    this.model,
    this.imageAssets,
    this.imageUrl,
    this.indexLetter,
  });
}

class _SelectListView extends StatefulWidget {
  final String? title;
  //是否需要右侧的index字母索引
  final bool? isNeedIndexBar;
  final bool? isSort;
  final List<SearchListViewModel> models;
  final String? keyword;
  final SelectedCallBack onSelected;
  final SearchCallBack? onSearch;
  const _SelectListView({this.title, required this.models, this.isNeedIndexBar, this.isSort, this.keyword, required this.onSelected, this.onSearch});
  @override
  _SelectListViewState createState() => _SelectListViewState();
}

class _SelectListViewState extends State<_SelectListView> with AutomaticKeepAliveClientMixin {
  final GlobalKey<_SearchBarState> searchBarKey = GlobalKey<_SearchBarState>();

  // 字典 存放item和高度对应的数据
  final Map _groupOffsetMap = {
    WORDS[0]: 0.0,
    WORDS[1]: 0.0,
  };

  final List<SearchListViewModel> _headerData = [
    // SelectListModel(imageAssets: 'images/新的朋友.png', name: '新的朋友'),
    // SelectListModel(imageAssets: 'images/群聊.png', name: '群聊'),
    // SelectListModel(imageAssets: 'images/标签.png', name: '标签'),
    // SelectListModel(imageAssets: 'images/公众号.png', name: '公众号'),
  ];
  String searchText = "";
  final List<SearchListViewModel> searchData = [];
  final ScrollController _scrollController = ScrollController();
  
  // 添加防抖计时器
  Timer? _debounceTimer;

  @override
  // TODO: implement wantKeepAlive
  bool get wantKeepAlive => true;

  @override
  void initState() {
    super.initState();
    analyzing();

    WidgetsBinding.instance.addPostFrameCallback((_) {
      searchText = widget.keyword ?? "";
      logger.i("==============================");
      logger.i(searchText);
      logger.i("==============================");
      searchBarKey.currentState?.updateText(searchText);
      searchBarOnChange(searchText);
    });
  }
  
  @override
  void dispose() {
    _debounceTimer?.cancel();
    super.dispose();
  }

  Future<void> searchBarOnChange(String value) async {
    // 取消之前的计时器
    if (_debounceTimer?.isActive ?? false) {
      _debounceTimer!.cancel();
    }
    
    // 设置新的计时器，500毫秒后执行搜索
    _debounceTimer = Timer(const Duration(milliseconds: 500), () async {
      searchText = value;
      // 如果有输入，过滤数据；否则清空搜索结果
      if (searchText.isNotEmpty) {
        // 使用过滤器筛选不包含 '#' 并且标题包含搜索文本的数据
        if (widget.onSearch != null) {
          final result = await widget.onSearch!(searchText);
          // searchData
            // ..clear()
            // ..addAll(result.where((item) => !(item.indexLetter?.contains("#") ?? false) && (item.title?.contains(searchText) ?? false)));
            searchData.clear();
            searchData.addAll(result);
        } else {
          searchData
            ..clear()
            ..addAll(widget.models.where((item) => !(item.indexLetter?.contains("#") ?? false) && (item.title?.contains(searchText) ?? false)));
        }
      } else {
        searchData.clear();
      }
      
      if (mounted) {
        setState(() {});
      }
    });
  }

  void analyzing() {
    /// TODO: 是否自动排序（按拼音首字母）
    if (widget.isSort == true) {
      sort();
    }
    var groupOffset = ROW_HEIGHT * _headerData.length;
    // 循环计算每一个头的位置，存入字典
    for (int i = 0; i < widget.models.length; i++) {
      if (i < 1) {
        // 第一个cell一定有头
        _groupOffsetMap.addAll({widget.models[i].indexLetter: groupOffset});
        groupOffset += ROW_HEIGHT + GROUP_HEIGHT;
      } else if (widget.models[i].indexLetter == widget.models[i - 1].indexLetter) {
        // 不同存，只需要加cell的高度
        groupOffset += ROW_HEIGHT;
      } else {
        _groupOffsetMap.addAll({widget.models[i].indexLetter: groupOffset});
        groupOffset += ROW_HEIGHT + GROUP_HEIGHT;
      }
    }
  }

  // 自动排序（按拼音首字母）
  sort() {
    RegExp chineseCharReg = RegExp(r"[\u4e00-\u9fa5]");
    RegExp numberReg = RegExp(r"\d"); // 用于匹配数字
    for (var model in widget.models) {
      if (model.indexLetter == null || model.indexLetter!.isEmpty) {
        String first = "A"; // 默认值
        if (model.title != null && model.title!.isNotEmpty) {
          String firstChar = model.title![0];

          if (chineseCharReg.hasMatch(firstChar)) {
            // 如果第一个字符是汉字，取拼音首字母
            first = PinyinHelper.getFirstWordPinyin(firstChar);
          } else if (numberReg.hasMatch(firstChar)) {
            // 如果第一个字符是数字，使用 '#' 作为索引（也可以使用 firstChar 作为索引）
            first = "#";
          } else if (RegExp(r'[A-Za-z]').hasMatch(firstChar)) {
            // 如果第一个字符是字母，直接取大写
            first = firstChar.toUpperCase();
          } else {
            // 其他情况（符号等），使用默认值（或指定其他符号）
            first = "@"; // 例如可以用 @ 作为特殊符号的索引
          }
          if (first.isNotEmpty) {
            first = first.substring(0, 1).toUpperCase();
          }
        }
        model.indexLetter = first;
      }
    }
    widget.models.sort((a, b) => a.indexLetter!.compareTo(b.indexLetter!));
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 65,
        leading: IconButton(
          icon: const Icon(Icons.close, color: Colors.black),
          onPressed: () => Get.back(),
        ),
        title: Text(widget.title ?? '请选择', style: const TextStyle(color: Colors.black, fontSize: 16)),
        backgroundColor: Colors.white,
      ),
      body: Column(
        children: [
          const SizedBox(height: 1),
          Container(
            color: Colors.white,
            padding: const EdgeInsets.fromLTRB(10, 10, 10, 10),
            // _SearchBar 调用时的 onChanged 回调
            child: _SearchBar(key: searchBarKey, color: Colors.grey[200], onChanged: searchBarOnChange),
          ),
          Expanded(
            child: Stack(
              children: [
                if (searchText.isNotEmpty && searchData.isEmpty)
                  // 搜索内容为空时显示的提示组件
                  const Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(Icons.search_off, size: 50, color: Colors.grey),
                        SizedBox(height: 10),
                        Text(
                          '搜索内容为空',
                          style: TextStyle(fontSize: 16, color: Colors.grey),
                        ),
                      ],
                    ),
                  )
                else
                  ListView.builder(
                    padding: EdgeInsets.fromLTRB(0, 10, 0, 10),
                      itemCount: (searchText.isNotEmpty && searchData.isNotEmpty) ? searchData.length + _headerData.length : widget.models.length + _headerData.length,
                      controller: _scrollController,
                      itemBuilder: (BuildContext context, int index) {
                        // 显示头部4个cell
                        if (index < _headerData.length) {
                          return _SelectListViewCell(
                            model: _headerData[index],
                            showLine: true,
                            onTap: (value) {},
                          );
                        }
                        int headerIndex = index - _headerData.length;
                        // 检查索引是否有效
                        if ((searchText.isNotEmpty && searchData.isNotEmpty && headerIndex >= searchData.length) ||
                            (searchText.isEmpty && headerIndex >= widget.models.length)) {
                          return const SizedBox.shrink();
                        }
                        
                        bool showLine = true; // 默认显示分割线
                        if ((searchText.isNotEmpty && searchData.isNotEmpty && index == searchData.length + _headerData.length - 1) ||
                            (searchText.isEmpty && index == widget.models.length + _headerData.length - 1)) {
                          showLine = false; // 最后一项不显示分割线
                        }
                        
                        // 安全获取正确的模型数据
                        final model = (searchText.isNotEmpty && searchData.isNotEmpty) 
                            ? searchData[headerIndex] 
                            : widget.models[headerIndex];
                            
                        // 检查索引是否有效，再决定是否隐藏组标题
                        bool hiddenGroupTitle = false;
                        if (headerIndex > 0) {
                          if (searchText.isNotEmpty && searchData.isNotEmpty) {
                            if (headerIndex < searchData.length) {
                              hiddenGroupTitle = searchData[headerIndex].indexLetter == searchData[headerIndex - 1].indexLetter;
                            }
                          } else {
                            if (headerIndex < widget.models.length) {
                              hiddenGroupTitle = widget.models[headerIndex].indexLetter == widget.models[headerIndex - 1].indexLetter;
                            }
                          }
                        }
                        
                        return _SelectListViewCell(
                          model: model,
                          groupTitle: hiddenGroupTitle ? null : model.indexLetter,
                          showLine: showLine,
                          onTap: (model) => widget.onSelected(model),
                        );
                      }),
                if (widget.isNeedIndexBar ?? true)
                  _IndexBar(indexBarCallBack: (String str) {
                    if (_groupOffsetMap[str] != null) {
                      WidgetsBinding.instance.addPostFrameCallback((_) {
                        _scrollController.animateTo(
                          _groupOffsetMap[str],
                          duration: const Duration(milliseconds: 10),
                          curve: Curves.easeIn,
                        );
                      });
                    }
                  }),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

// 内部类
class _SelectListViewCell extends StatelessWidget {
  final SearchListViewModel? model;
  final String? groupTitle;
  final bool? showLine;
  final SelectedCallBack onTap;
  const _SelectListViewCell({this.model, this.groupTitle, this.showLine, required this.onTap});
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        // cell 头部
        Container(
          margin: const EdgeInsets.only(left: 15),
          alignment: Alignment.centerLeft,
          height: groupTitle != null ? 30 : 0,
          child: groupTitle != null ? Text(groupTitle ?? "") : null,
        ),
        Container(
          color: Colors.white,
          child: Material(
            child: InkWell(
              splashColor: Colors.grey[300],
              onTap: () => onTap(model!),
              child: Row(children: [
                // 头像
                if (model?.imageUrl != null || model?.imageAssets != null)
                  Container(
                    margin: const EdgeInsets.fromLTRB(20, 0, 0, 0),
                    width: 34,
                    height: ROW_HEIGHT,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(6),
                        image: DecorationImage(
                          image: model?.imageUrl != null ? NetworkImage(model?.imageUrl ?? "") as ImageProvider : AssetImage(model?.imageAssets ?? ""),
                        )),
                  ),
                // 昵称+下划线
                Container(
                  height: ROW_HEIGHT,
                  margin: const EdgeInsets.fromLTRB(20, 0, 10, 0),
                  alignment: Alignment.centerLeft,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        model?.title ?? "", 
                        style: const TextStyle(fontSize: 15),
                        overflow: TextOverflow.ellipsis,
                        maxLines: 1,
                      ),
                      if (model?.subTitle != null) 
                        Text(
                          model?.subTitle ?? "", 
                          style: const TextStyle(fontSize: 12, color: Colors.black54),
                          overflow: TextOverflow.ellipsis,
                          maxLines: 1,
                        ),
                    ],
                  ),
                ),
              ]),
            ),
          ),
        ),
        if (showLine == true) Container(height: 0.5, color: Colors.grey[300])
      ],
    );
  }
}

// 重写系统 SearchBar
class _SearchBar extends StatefulWidget {
  final Color? color;
  final ValueChanged<String> onChanged;
  final TextEditingController controller = TextEditingController();

  _SearchBar({super.key, required this.onChanged, this.color});

  @override
  _SearchBarState createState() => _SearchBarState();
}

class _SearchBarState extends State<_SearchBar> {
  bool _showClear = false;
  late TextEditingController _controller; // 声明本地控制器

  @override
  void initState() {
    super.initState();
    _controller = widget.controller; // 使用widget的controller初始化
  }

  void _onChange(String text) {
    setState(() {
      _showClear = text.isNotEmpty;
    });
    widget.onChanged(text);
  }

  void updateText(String newText) {
    setState(() {
      _showClear = newText.isNotEmpty;
      _controller.text = newText; // 使用本地控制器
    });
    widget.onChanged(newText);
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 40,
      color: Colors.transparent,
      child: Row(
        children: [
          Expanded(
              child: Container(
            height: 38,
            margin: const EdgeInsets.only(top: 0, left: 2, right: 2),
            padding: const EdgeInsets.fromLTRB(10, 5, 5, 5),
            decoration: BoxDecoration(
              color: widget.color ?? Colors.white,
              borderRadius: BorderRadius.circular(4),
            ),
            child: Row(
              children: [
                const Image(
                  image: AssetImage(AssetsRes.SEARCH_WHITE),
                  width: 20,
                  color: Colors.grey,
                ),
                Expanded(
                    flex: 1,
                    child: TextField(
                      autofocus: false,
                      onChanged: _onChange,
                      controller: _controller, // 使用本地控制器
                      cursorColor: Colors.grey,
                      style: const TextStyle(fontSize: 14, color: Colors.black, fontWeight: FontWeight.w300),
                      decoration: const InputDecoration(
                        contentPadding: EdgeInsets.only(left: 5, top: 2, bottom: 0),
                        border: InputBorder.none,
                        hintText: "搜索",
                        // 增加了 isDense: true 属性，这个属性使 TextField 变得更紧凑，减少了默认的内部间距。
                        isDense: true,
                      ),
                    )),
                if (_showClear)
                  GestureDetector(
                    onTap: () {
                      setState(() {
                        _onChange('');
                        _controller.clear();
                      });
                    },
                    child: const Icon(Icons.cancel, size: 20, color: Colors.grey),
                  )
              ],
            ),
          )),
        ],
      ),
    );
  }

  @override
  void dispose() {
    // 不要在这里dispose controller，因为它是从widget传入的
    super.dispose();
  }
}

class _IndexBar extends StatefulWidget {
  final void Function(String str) indexBarCallBack;
  const _IndexBar({required this.indexBarCallBack});

  @override
  _IndexBarState createState() => _IndexBarState();
}

int getIndex(BuildContext context, Offset globalPosition) {
  // 获取到点击小部件的盒子
  RenderBox box = context.findRenderObject() as RenderBox;
  // 根据盒子获取到y globalToLocal当前位置部件的原点(小部件左上角)的距离(x, y)
  double y = box.globalToLocal(globalPosition).dy;
  // 计算出字符的高度
  var itemHeight = Get.width / 1 / WORDS.length;
  // 计算出是第几个item
  int index = (y ~/ itemHeight).clamp(0, WORDS.length - 1);
  return index;
}

class _IndexBarState extends State<_IndexBar> {
  Color _bgColor = const Color.fromRGBO(1, 1, 1, 0);
  Color _textColor = Colors.black;
  double _indicatorY = 0.0;
  String _indicatorText = 'A';
  bool _indicatorHidden = true;

  @override
  Widget build(BuildContext context) {
    final List<Widget> words = [];
    for (int i = 0; i < WORDS.length; i++) {
      words.add(Expanded(
          child: Text(
        WORDS[i],
        style: TextStyle(fontSize: 12, color: _textColor, fontWeight: FontWeight.w500),
      )));
    }
    final height = MediaQuery.of(context).size.height;
    return Positioned(
      top: height / 30,
      right: 0,
      width: 110,
      height: height / 2,
      child: Row(
        children: [
          Container(
            width: 80,
            alignment: Alignment(0, _indicatorY),
            child: _indicatorHidden
                ? null
                : Stack(
                    alignment: const Alignment(-0.2, -0.1),
                    children: [
                      const Image(
                        image: AssetImage(AssetsRes.QI_PAO),
                        width: 60,
                      ),
                      Text(_indicatorText, style: const TextStyle(fontSize: 30, color: Colors.white)),
                    ],
                  ),
          ),
          GestureDetector(
            child: Container(
              width: 30,
              color: _bgColor,
              child: Column(
                children: words,
              ),
            ),
            onTap: () {
              setState(() {
                _indicatorHidden = true;
                _bgColor = const Color.fromRGBO(1, 1, 1, 0.0);
                _textColor = Colors.black;
              });
            },
            onVerticalDragUpdate: (DragUpdateDetails details) {
              int index = getIndex(context, details.globalPosition);
              widget.indexBarCallBack(WORDS[index]);
              setState(() {
                _indicatorY = 2.3 / WORDS.length * index - 1.1;
                _indicatorText = WORDS[index];
                _indicatorHidden = false;
              });
            },
            onVerticalDragDown: (DragDownDetails details) {
              int index = getIndex(context, details.globalPosition);
              widget.indexBarCallBack(WORDS[index]);
              setState(() {
                _indicatorY = 2.3 / WORDS.length * index - 1.1;
                _indicatorText = WORDS[index];
                _indicatorHidden = false;
                _bgColor = const Color.fromRGBO(1, 1, 1, 0.3);
                _textColor = Colors.white;
              });
            },
            onVerticalDragEnd: (DragEndDetails details) {
              setState(() {
                _indicatorHidden = true;
                _bgColor = const Color.fromRGBO(1, 1, 1, 0.0);
                _textColor = Colors.black;
              });
            },
          ),
        ],
      ),
    );
  }
}
