import 'package:auto_shop_server/app/theme/app_theme.dart';
import 'package:auto_shop_server/app/theme/app_text_theme.dart';
import 'package:auto_shop_server/app/utils/common_widget/base_item.dart';
import 'package:flutter/material.dart';

import '../../app/utils/common_widget/common_widget.dart';

class SectionHeader extends StatelessWidget {
  final String? title;
  final TextStyle? style;
  final String? edit;
  final Color? color;
  final EdgeInsetsGeometry? margin;
  final EdgeInsetsGeometry? padding;
  final GestureTapCallback? onTap;
  final Widget? child;
  const SectionHeader(this.title, {super.key, this.edit, this.color, this.margin, this.padding, this.onTap, this.child, this.style});

  @override
  Widget build(BuildContext context) {
    return ShapeRadiusContainer(
        margin: margin ?? const EdgeInsets.fromLTRB(10, 0, 10, 10),
        child: Column(
            children: [
              Container(
                padding: padding ?? const EdgeInsets.fromLTRB(10, 10, 10, 10),
                decoration: BoxDecorationRadius.topRadius(color: color??TdColors.brand),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(title??"", style: style ?? whiteBoldStyle()),
                    GestureDetector(
                      onTap: onTap,
                      child: Text(edit??"", style: whiteStyle())
                    ),
                  ],
                ),
              ),
              if (child != null) child!
            ]
        )
    );
  }
}

