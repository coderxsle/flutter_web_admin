// ignore_for_file: constant_identifier_names
import 'dart:async';

import 'package:auto_shop_server/app/utils/common_widget/my_material_button.dart';
import 'package:auto_shop_server/app/utils/global.dart';
import 'package:auto_shop_server/res/assets_res.dart';
import 'package:flutter/material.dart';

import 'model/pay_type_model.dart';

final List<String> images = [AssetsRes.E_PAY, AssetsRes.WECHAT, AssetsRes.ALIPAY, AssetsRes.E_M_PAY];

/// 选择支付方式小组件(仅供弹窗使用) bottomSheet
class PayTypeSelectWidget extends StatelessWidget {
  final List<PayTypeModel> payTypes;
  final String? payTotal; // 需要支付的钱
  const PayTypeSelectWidget({super.key, required this.payTypes, this.payTotal});
  // 执行购物车支付方式选择 (total: 需要支付的价格)
  static Future<PayTypeModel?> doSelect(BuildContext context, List<PayTypeModel> payTypes, {String? total}) async {
    return showModalBottomSheet<PayTypeModel?>(
      context: context,
      builder: (_) {
        return PayTypeSelectWidget(
          payTypes: payTypes,
          payTotal: total,
        );
      });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          color: Colors.white,
          padding: const EdgeInsets.fromLTRB(15, 15, 0, 15),
          child: Row(
            children: [
              Text('支付金额：', style: blackStyle(font: 18)),
              Text('¥$payTotal', style: redBoldStyle(font: 24)),
            ],
          )
        ),
        Container(
          color: PageBackgroundColor,
          padding: const EdgeInsets.fromLTRB(20, 15, 0, 15),
          width: screenWidth(context),
          child: Text('请选择支付方式', textAlign: TextAlign.center, style: greyStyle(font: 16)),
        ),
        Expanded(
          child: Container(
            color: PageBackgroundColor,
            child: ListView.builder(
              itemCount: payTypes.length,
              itemBuilder: (BuildContext context, int index) {
                return Column(
                  children: [
                    MyMaterialButton(
                      padding: const EdgeInsets.fromLTRB(15, 10, 15, 10),
                      color: Colors.white,
                      onPressed: ()=> Navigator.of(context).pop(payTypes[index]),
                      child: Row(
                        children: [
                          (payTypes[index].image == null || payTypes[index].image!.isEmpty)
                            ? Image.asset(images[index], height: 32, fit: BoxFit.fitWidth)
                            : imageNetwork(payTypes[index].image??"", height: 32, fit: BoxFit.fitWidth),
                          const SizedBox(width: 10),
                          Text(payTypes[index].payName??"", style: blackStyle()),
                        ],
                      ),
                    ),
                    dividerLine(),
                  ],
                );
            },
            // separatorBuilder: (BuildContext context, int index) {
            //   return dividerLine();
            // }),
                    ),
          ),
        )],
    );
  }

}







