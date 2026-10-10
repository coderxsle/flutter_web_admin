import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../zhouyi/algorithm/qimen_calculator.dart';
import '../../zhouyi/algorithm/qimen_tables.dart';
import '../../zhouyi/algorithm/zhouyi_models.dart';
import 'qimen_grid_cell.dart';

/// 九宫格盘面。数据落宫顺序与安卓 NineGridAdapter 完全一致：
///
/// ```
/// 宫4  宫9  宫2
/// 宫3  宫5  宫7
/// 宫8  宫1  宫6
/// ```
class QiMenGridPanel extends StatelessWidget {
  const QiMenGridPanel({
    super.key,
    required this.model,
    this.method = QimenMethod.chaibu,
    this.showAnGan = false,
    this.showDiBaShen = false,
  });

  /// 安卓 NineGridAdapter.dataIndex
  static const List<int> _dataIndex = [3, 8, 1, 2, 4, 6, 7, 0, 5];

  final ZYHourQimenModel model;
  final QimenMethod method;
  final bool showAnGan;
  final bool showDiBaShen;

  /// 安卓 setkongWangText：由旬首得到需要显示空亡「○」的宫位下标
  ///
  /// 安卓原版 甲戌己 只点亮了坤 2 宫（申），漏掉兑 7 宫（酉），这里由
  /// 旬空地支表推导，六旬一律两支。
  static Set<int> kongWangIndices(String xunShou) =>
      QimenTables.xunKongIndexOf(xunShou);

  @override
  Widget build(BuildContext context) {
    // 外边框走这一层；格子之间的井字线由 _buildCell 的 right / bottom 提供
    return Container(
      decoration: BoxDecoration(
        border: Border.all(color: _lineColor, width: 0.5),
      ),
      child: Column(
        children: [
          for (var row = 0; row < 3; row++)
            SizedBox(
              height: 100.h,
              child: Row(
                children: [
                  for (var col = 0; col < 3; col++)
                    Expanded(child: _buildCell(row * 3 + col)),
                ],
              ),
            ),
        ],
      ),
    );
  }

  /// 九宫格分割线；#DDDDDD 在浅色底上偏淡，取 #C9C9C9
  static const Color _lineColor = Color(0xFFC9C9C9);

  Widget _buildCell(int position) {
    final index = _dataIndex[position];
    final head = model.head;
    final isLastCol = position % 3 == 2;
    final isLastRow = position >= 6;

    return Container(
      decoration: BoxDecoration(
        border: Border(
          right: isLastCol
              ? BorderSide.none
              : const BorderSide(color: _lineColor, width: 0.5),
          bottom: isLastRow
              ? BorderSide.none
              : const BorderSide(color: _lineColor, width: 0.5),
        ),
      ),
      child: QiMenGridCell(
        diGan: _at(model.diPanQiyi, index),
        star: _at(model.jiuXing, index),
        tianGan: _at(model.tianPanQiyi, index),
        door: _at(model.baMen, index),
        god: _at(model.baShen, index),
        diGod: showDiBaShen ? _at(model.diBaShen, index) : '',
        anGan: showAnGan ? _anGanFeiZhi(index) : '',
        riGan: _first(head.dayGanzhi),
        shiGan: _first(head.hourGanzhi),
        showKongWang: kongWangIndices(head.hourXunShou).contains(index),
        showMaXing: index < model.maXing.length && model.maXing[index] == 1,
        methodName: position == 4
            ? (method == QimenMethod.chaibu ? '拆补' : '置闰')
            : null,
      ),
    );
  }

  /// 暗干 + 飞支；值符宫两字交叉排列（安卓 NineGridAdapter 同款处理）
  String _anGanFeiZhi(int index) {
    final gan = _at(model.anGan, index);
    final zhi = _at(model.feiZhi, index);
    if (index == model.diPanZhiFuIndex && gan.length >= 2 && zhi.length >= 2) {
      return '${gan[1]}${zhi[1]}${gan[0]}${zhi[0]}';
    }
    return '$gan$zhi';
  }

  static String _at(List<String> list, int index) =>
      index >= 0 && index < list.length ? list[index] : '';

  static String _first(String value) =>
      value.isEmpty ? '' : value.substring(0, 1);
}
