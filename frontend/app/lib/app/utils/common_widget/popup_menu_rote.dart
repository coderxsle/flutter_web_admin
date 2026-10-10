import 'package:auto_shop_server/app/theme/app_text_theme.dart';
import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';


class PopupMenuView extends StatefulWidget {
  final String? title;
  final List<String> items;
  final double? width;
  final double? height;
  final ValueChanged onChanged;
  const PopupMenuView({super.key, this.title, required this.items, this.width=120, this.height=38, required this.onChanged});

  @override
  State<PopupMenuView> createState() => _PopupMenuViewState();
}

class _PopupMenuViewState extends State<PopupMenuView> {
  final ValueNotifier<String?> selectedValue = ValueNotifier<String?>(null);

  @override
  void dispose() {
    selectedValue.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return DropdownButtonHideUnderline(
      child: DropdownButton2<String>(
        isExpanded: true,
        barrierColor: Colors.black54,
        hint: Text(widget.title ?? "", style: blackStyle()),
        items: _addDividersAfterItems(widget.items),
        valueListenable: selectedValue,
        onChanged: (String? value) {
          selectedValue.value = value;
          widget.onChanged(value);
        },
        buttonStyleData: ButtonStyleData(
          padding: const EdgeInsets.symmetric(horizontal: 10),
          height: widget.height,
          width: widget.width,
        ),
        dropdownStyleData: const DropdownStyleData(
          maxHeight: 300,
          decoration: BoxDecoration(
            color: Colors.white,
          ),
        ),
        iconStyleData: const IconStyleData(
          openMenuIcon: Icon(Icons.arrow_drop_up),
        ),
      ),
    );
  }

  List<DropdownItem<String>> _addDividersAfterItems(List<String> items) {
    final List<DropdownItem<String>> menuItems = [];
    for (final String item in items) {
      menuItems.addAll([
        DropdownItem<String>(
          value: item,
          height: widget.height ?? 38,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 2),
            child: Text(item, style: blackStyle()),
          ),
        ),
        //最后一项后面不加分割线
        if (item != items.last)
          const DropdownItem<String>(
            enabled: false,
            height: 2,
            child: Divider(indent: 0, endIndent: 0, thickness: 0.35),
          ),
      ],
      );
    }
    return menuItems;
  }
}
