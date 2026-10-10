import 'package:auto_shop_server/common/index.dart';
import 'package:auto_shop_server/res/assets_res.dart';
import 'package:auto_shop_server/common/widgets/button_search_widget.dart';
import 'package:auto_shop_server/common/widgets/row_key_value_text.dart';
import 'package:get/get.dart';

//搜索框在弹窗列表内部--一个用来做预览的搜索栏，目的是为了跳转到其他页面
class SearchInDialogPreviewWidget extends StatefulWidget {
  // final ValueChanged<String> onChanged;
  //如果输入框内没东西，那么执行
  // final ValueChanged<String> callbackNull;
  final VoidCallback? callbackSearchPage;

  const SearchInDialogPreviewWidget({
    super.key,
    required this.callbackSearchPage,
  });

  @override
  State<SearchInDialogPreviewWidget> createState() => SearchInDialogPreviewWidgetState();
}

class SearchInDialogPreviewWidgetState extends State<SearchInDialogPreviewWidget> {
  //外侧嵌套包裹，为了监听点击事件
  // FocusNode focusNodeSearch = FocusNode();
  //搜索框的点击
  TextEditingController tecControllerSearch = TextEditingController();
  // bool _showClear = false;

  //暂时用来变化右侧叉好
  /*void _onChange(String text) {
    if (text.isNotEmpty) {
      logger.i("text--text-text$text");
      widget.onChanged(text);
    } else {
      //showMessageBottomLikeAndroid(please_input_keyWords, isLong: false);
      logger.i("text--text-null le ");
      widget.callbackNull(text);
    }
    // setState(() {
    //   _showClear = (text.isNotEmpty);
    // });
  }*/

  /*@override
  void initState() {
    super.initState();
    focusNodeSearch.addListener(() {
      _onFocusChange();
    });
  }*/

  /*void _onFocusChange() {
    if (focusNodeSearch.hasFocus) {
      logger.d('TextField 被点击了');
      // 在这里可以添加你想要执行的逻辑
    }
  }*/

  /*@override
  void dispose() {
    focusNodeSearch.removeListener(_onFocusChange);
    focusNodeSearch.dispose();
    super.dispose();
  }*/

  @override
  Widget build(BuildContext context) {
    tecControllerSearch.text = "请点击搜索";
    //这一整块的点击？
    return GestureDetector(
      onTap: () {
        logger.d("GestureDetector--onTap");
        if (!ObjectUtil.isEmpty(widget.callbackSearchPage)) {
          widget.callbackSearchPage?.call();
        }
      },
      child: Container(
        height: 36,
        color: Colors.transparent,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Expanded(
                child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const Image(
                  image: AssetImage(AssetsRes.SEARCH_WHITE),
                  width: 20,
                  color: Colors.grey,
                ),
                SizedBox(
                  width: Get.width * 0.7,
                  child: RowKeyValueTextWidget(textLeft: "请点击搜索", rightBlank: 100, padding: const EdgeInsets.only(left: 6)),
                ),
                //搜索按钮？
                Container(
                  padding: const EdgeInsets.fromLTRB(0, 4, 0, 4),
                  margin: const EdgeInsets.only(right: 2),
                  //child: const Icon(Icons.check_circle, size: 25, color: Colors.red),
                  child: ButtonSearchWidget(
                    text: "搜索",
                    onPressed: () {
                      logger.d("点击了搜索--用预览的");
                      if (!ObjectUtil.isEmpty(widget.callbackSearchPage)) {
                        widget.callbackSearchPage?.call();
                      }
                    },
                  ),
                  // child: ButtonSearchWidget(
                  //   text: "搜索",
                  //   onPressed: () {
                  //     logger.d("点击了搜索--用预览的");
                  //   },
                  // ),
                ),
                //筛选条件的小图标
                // const SizedBox(width: 6),
              ],
            )),
          ],
        ),
      ),
    );
  }
}
