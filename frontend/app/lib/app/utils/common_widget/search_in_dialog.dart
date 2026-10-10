import 'package:auto_shop_server/app/utils/common_widget/logger.dart';
import 'package:auto_shop_server/app/utils/common_widget/my_dialog.dart';
import 'package:auto_shop_server/app/utils/strings.dart';
import 'package:auto_shop_server/res/assets_res.dart';
import 'package:auto_shop_server/common/widgets/button_search_widget.dart';
import 'package:flutter/material.dart';

//搜索框在弹窗列表内部
class SearchInDialogWidget extends StatefulWidget {
  final ValueChanged<String> onChanged;
  //如果输入框内没东西，那么执行
  final ValueChanged<String> callbackNull;

  const SearchInDialogWidget({super.key, required this.onChanged, required this.callbackNull});

  @override
  State<SearchInDialogWidget> createState() => SearchInDialogWidgetState();
}

class SearchInDialogWidgetState extends State<SearchInDialogWidget> {
  late TextEditingController controllerSearch = TextEditingController();
  bool _showClear = false;

  //暂时用来变化右侧叉好
  void _onChange(String text) {
    if (text.isNotEmpty) {
      logger.i("text--text-text$text");
      widget.onChanged(text);
    } else {
      //showMessageBottomLikeAndroid(please_input_keyWords, isLong: false);
      logger.i("text--text-null le ");
      widget.callbackNull(text);
    }
    setState(() {
      _showClear = (text.isNotEmpty);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 36,
      color: Colors.transparent,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Expanded(
              child: Container(
            height: 36,
            margin: const EdgeInsets.only(top: 0, left: 0, right: 0),
            padding: const EdgeInsets.fromLTRB(5, 0, 0, 0),
            decoration: BoxDecoration(
              color: Colors.white, //动态值？
              borderRadius: BorderRadius.circular(4),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.center,
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
                      controller: controllerSearch,
                      cursorColor: Colors.grey,
                      style: const TextStyle(fontSize: 13, color: Colors.black, fontWeight: FontWeight.w300),
                      decoration: const InputDecoration(
                        isDense: true,
                        contentPadding: EdgeInsets.only(left: 5),
                        border: InputBorder.none,
                        hintText: please_input_keyWords, //请输入关键字
                      ),
                      textInputAction: TextInputAction.search,
                      onSubmitted: (value) {
                        widget.onChanged(value); // 提交（搜索）操作回调函数
                      },
                    )),
                if (_showClear)
                  GestureDetector(
                    onTap: () {
                      setState(() {
                        _onChange('');
                        controllerSearch.clear();
                      });
                    },
                    child: const Padding(
                      padding: EdgeInsets.fromLTRB(0, 0, 4, 0),
                      child: Icon(Icons.cancel, size: 20, color: Colors.grey),
                    ),
                  ),
                //搜索按钮？
                Container(
                  padding: const EdgeInsets.fromLTRB(0, 4, 0, 4),
                  margin: const EdgeInsets.only(right: 2),
                  //child: const Icon(Icons.check_circle, size: 25, color: Colors.red),
                  child: ButtonSearchWidget(
                      text: "搜索",
                      onPressed: () {
                        //Logger.log("$logCatTag：${"点击搜索"}");
                        _onChange(controllerSearch.text);
                        //空搜索给个提示
                        if (controllerSearch.text.isEmpty) {
                          showMessageBottomLikeAndroid(please_input_keyWords, isLong: false);
                        }
                      }),
                ),
                //筛选条件的小图标
                const SizedBox(width: 6),
              ],
            ),
          )),
        ],
      ),
    );
  }
}
