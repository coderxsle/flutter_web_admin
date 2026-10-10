import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

// 重写系统 SearchBar
class MySearchBar extends StatefulWidget {
  final Color? color;
  final String? image;
  final String hintText;
  final EdgeInsetsGeometry? padding;
  final EdgeInsetsGeometry? margin;
  final ValueChanged<String> onChanged;
  const MySearchBar({super.key, required this.onChanged, this.hintText = "搜索", this.image, this.padding, this.margin, this.color});

  @override
  State<MySearchBar> createState() => _MySearchBarState();
}

class _MySearchBarState extends State<MySearchBar> {
  final TextEditingController _controller = TextEditingController();
  bool _showClear = false;
  void _onChange(String text) {
    if (text.isEmpty) {
      widget.onChanged(text);
    }
    setState(() {
      _showClear = (text.isNotEmpty);
    });
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 40.h,
      child: Container(
        //height: 38,
        // margin: const EdgeInsets.only(top: 0, left: 2, right: 2).r,
        margin: widget.margin,
        padding: widget.padding ?? const EdgeInsets.fromLTRB(10, 5, 10, 5).r,
        decoration: BoxDecoration(
          color: widget.color ?? Colors.white,
          borderRadius: const BorderRadius.all(Radius.circular(6)),
          shape: BoxShape.rectangle,
          boxShadow: [
            BoxShadow(
              //color: Colors.black12,
              color: const Color.fromARGB(255, 220, 213, 213),
              offset: const Offset(0, 0), // 设置阴影偏移量
              blurRadius: 0, // 设置阴影模糊程度 
              spreadRadius: 0.5, // 设置阴影扩散程度 
            ),
          ],
        ),
        child: Row( 
          children: [
            if (widget.image != null)
              Image(
                  image: AssetImage(widget.image!),
                  width: 20.h,
                  color: Colors.grey)
            else
              Icon(Icons.search, size: 20.w, color: Colors.grey),
            _setupTextField(),
            if (_showClear)
              GestureDetector(
                onTap: () {
                  setState(() {
                    _onChange('');
                    _controller.clear();
                  });
                },
                child: Icon(Icons.cancel, size: 20.h, color: Colors.grey),
              )
          ],
        ),
      ),
    );
  }

  Widget _setupTextField() {
    return Expanded(
      child: Container(
        constraints: BoxConstraints(minHeight: 44.h),
        padding: const EdgeInsets.fromLTRB(0, 0, 20, 0).r,
        alignment: Alignment.center, // 确保父容器内部居中
        child: TextField(
          controller: _controller,
          onChanged: (value) => _onChange(value),
          onSubmitted: (value) => widget.onChanged(value), // 提交（搜索）操作回调函数,
          autofocus: false,
          scrollPhysics: const NeverScrollableScrollPhysics(), // 禁止滚动
          style: TextStyle(fontSize: 14.sp, color: Colors.black, fontWeight: FontWeight.w300),
          textAlign: TextAlign.start,
          textAlignVertical: TextAlignVertical.center,
          decoration: InputDecoration(
            isDense: true,
            border: InputBorder.none,
            hintText: widget.hintText ?? "",
            // hintStyle: TextStyle(fontSize: 12, color: Colors.grey),
            contentPadding: EdgeInsets.symmetric(vertical: 0), // 垂直居中
          ),
        ),
      ),
    );
  }


}

