import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:yun_men_yi_pan/app/theme/app_text_theme.dart';

typedef OnChange = void Function(int index);

class SegmentedController extends StatefulWidget {
  const SegmentedController({super.key, this.onChange, required this.titleList});

  final OnChange? onChange;
  final List<String>? titleList ;

  @override
  SegmentedControllerState createState() => SegmentedControllerState();
}

class SegmentedControllerState extends State<SegmentedController> {

  late int index;

  @override
  void initState() {
    super.initState();
    index = 0;
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 44,
      child: _segmentedWidget(),
    );
  }

  Widget _segmentedWidget(){
    return Stack(
      children: [
        _segmentedTitleWidget(),
        // _indicatorWidget(),
      ],
    );
  }

  Widget _segmentedTitleWidget(){
    return Row(
      children: _getTitleWidget(),
    );
  }

  List<Widget> _getTitleWidget(){
    List<Widget> list = [];
    for(int i = 0; i < widget.titleList!.length; i++){
      Expanded title = Expanded(
        child: TextButton(
          onPressed: (){
            setState(() {
              index = i;
              if(widget.onChange != null){
                widget.onChange!(i);
              }
            });
          },
          child: Container(
            alignment: Alignment.center,
            child: Text(
              widget.titleList![i],
              style: blackStyle().copyWith(
                fontSize: (i == index ? 16 : 14).sp,
                color: i == index ? Colors.red : Colors.grey,
                fontWeight: FontWeight.w400,
              ),
            ),
          ),
        ),
      );
      list.add(title);
    }
    return list;
  }
}