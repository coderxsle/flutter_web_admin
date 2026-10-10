import 'package:flutter/material.dart';

import '../../theme/app_colors.dart';

class RadioBox extends StatelessWidget {
  final String? title;
  final String? item1, item2;
  final String? selectedValue;
  final bool valueRequired;
  final Function(String) onChanged;

  const RadioBox({
    super.key, this.title, this.item1, this.item2,
    this.selectedValue,
    this.valueRequired=false,
    required this.onChanged});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      child: Row(
        children: [
          Padding(
            padding: const EdgeInsets.fromLTRB(0, 4, 2, 0),
            child: Text(
              valueRequired ? "*" : "  ",
              style: const TextStyle(color: Colors.red, fontWeight: FontWeight.bold),
            ),
          ),
          Text(title??"", style: const TextStyle(color: Colors.black)),
          const SizedBox(width: 5),
          Expanded(
            child: Row(
              children: [
                Row(
                  children: [
                    Checkbox(
                      shape: const CircleBorder(),
                      side: const BorderSide(width: 1, color: Color.fromRGBO(151, 151, 151, 1)),
                      value: selectedValue == item1,
                      activeColor: ThemeColor, // 使用你的主题颜色
                      onChanged: (bool? value) {
                        if (value == true) {
                          onChanged(item1??"");
                        }
                      },
                    ),
                    Text(item1??"", style: const TextStyle(color: Colors.black)),
                  ],
                ),
                const SizedBox(width: 25),
                if (item2 != null)
                  Row(
                    children: [
                      Checkbox(
                        shape: const CircleBorder(),
                        side: const BorderSide(width: 1, color: Color.fromRGBO(151, 151, 151, 1)),
                        value: selectedValue == item2,
                        activeColor: ThemeColor, // 使用你的主题颜色
                        onChanged: (bool? value) {
                          if (value == true) {
                            onChanged(item2??"");
                          }
                        },
                      ),
                      Text(item2??"", style: const TextStyle(color: Colors.black)),
                    ],
                  ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}






