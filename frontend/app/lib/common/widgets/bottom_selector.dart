import 'package:auto_shop_server/common/index.dart';
import 'package:get/get.dart';

class BottomSelectorItem {
  String icon, title, subTitle, value;
  int? index;
  dynamic model;
  bool isSelected;
  BottomSelectorItem({
    this.icon = "",
    this.title = "",
    this.subTitle = "",
    this.value = "",
    this.index,
    this.model,
    this.isSelected = false,
  });

  fromJson(Map<String, dynamic> json) {
    icon = json["icon"];
    title = json["title"];
    subTitle = json["subTitle"];
    value = json["value"];
    index = json["index"];
    model = json["model"];
    isSelected = json["isSelected"];
  }

  Map<String, dynamic> toJson() => {
        "icon": icon,
        "title": title,
        "subTitle": subTitle,
        "value": value,
        "index": index,
        "model": model,
        "isSelected": isSelected,
      };
}

class BottomSelector {
  // 单选
  static void single(String title, List<BottomSelectorItem> models, {required Function(BottomSelectorItem) onSelected}) {
    Get.bottomSheet(
      _buildSheet(title, models, false, onTap: (selectedModel) {
        onSelected(selectedModel);
        Get.back(); // 选中后关闭弹窗
      }),
    );
  }

  // 多选
  static void multiple(String title, List<BottomSelectorItem> models, {required Function(List<BottomSelectorItem>) onSelected}) {
    Get.bottomSheet(_buildSheet(title, models, true, onConfirm: () {
      final selectedItems = models.where((item) => item.isSelected).toList();
      onSelected(selectedItems);
      Get.back(); // 确认选择后关闭弹窗
    }));
  }

  // 构建底部弹窗视图
  static Widget _buildSheet(String title, List<BottomSelectorItem> models, bool isMultiSelect, {Function(BottomSelectorItem)? onTap, VoidCallback? onConfirm}) {
    return Container(
      color: Colors.grey[200],
      child: Column(
        children: [
          Container(
            height: 50,
            color: Colors.white,
            padding: EdgeInsets.fromLTRB(0, 0, 10, 0),
            child: Row(
              children: [
                Expanded(
                  // 使用 Expanded 让标题居中
                  child: Padding(
                    padding: EdgeInsets.fromLTRB(isMultiSelect ? 55 : 0, 0, 0, 0),
                    child: Center(
                      child: Text(title, style: TextStyle(fontSize: 16)),
                    ),
                  ),
                ),
                if (isMultiSelect) TextButton(onPressed: onConfirm, child: const Text('确认')),
              ],
            ),
          ),
          Divider(
            indent: 0,
            endIndent: 0,
            thickness: 0.4,
            height: 0,
            color: Colors.grey[300],
          ),
          Expanded(
            child: ListView.builder(
              itemCount: models.length,
              itemBuilder: (context, index) {
                BottomSelectorItem model = models[index];
                return StatefulBuilder(builder: (context, setState) {
                  return GestureDetector(
                    onTap: () {
                      if (!isMultiSelect) {
                        setState(() {
                          onTap!(models[index]);
                        });
                      } else {
                        setState(() {
                          models[index].isSelected = !models[index].isSelected;
                        });
                      }
                    },
                    child: Container(
                      // color: model.isSelected ? Colors.green[100] : Colors.white,
                      color: Colors.white,
                      margin: const EdgeInsets.fromLTRB(0, 0, 0, 0.5),
                      padding: const EdgeInsets.fromLTRB(32, 0, 15, 0),
                      height: 44,
                      child: Row(
                        mainAxisAlignment: model.icon.isEmpty ? MainAxisAlignment.center : MainAxisAlignment.start,
                        children: [
                          if (model.icon.startsWith("http"))
                            Padding(
                              padding: const EdgeInsets.fromLTRB(15, 0, 10, 0),
                              child: Image.network(model.icon, width: 44, height: 44, fit: BoxFit.fitHeight),
                            ),
                          if (model.icon.isNotEmpty && !model.icon.startsWith("http"))
                            Padding(
                              padding: const EdgeInsets.fromLTRB(15, 0, 10, 0),
                              child: Image.asset(model.icon, width: 44, height: 44, fit: BoxFit.fitHeight),
                            ),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(model.title, style: TextStyle(fontSize: 14)),
                                if (model.subTitle.isNotEmpty)
                                  Padding(
                                    padding: const EdgeInsets.only(top: 2),
                                    child: Text(model.subTitle, style: TextStyle(fontSize: 12)),
                                  ),
                              ],
                            ),
                          ),
                          SizedBox(
                            width: 22, // 保证占位宽度
                            child: model.isSelected ? Icon(Icons.check, color: Colors.red, size: 22) : SizedBox(), // 当未选中时使用空占位
                          ),
                        ],
                      ),
                    ),
                  );
                });
              },
            ),
          ),
        ],
      ),
    );
  }
}
