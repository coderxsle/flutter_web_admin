import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:trina_grid/trina_grid.dart';
import 'gi_table_column.dart';

/// GiTable 数据适配器
/// 
/// 负责将用户友好的数据格式转换为 trina_grid 需要的格式
class GiTableAdapter {
  /// 将普通 Map 数据转换为 TrinaRow 格式
  /// 
  /// trina_grid 要求数据必须是 TrinaRow 格式,每个字段都需要包装成 TrinaCell
  static List<TrinaRow> convertToTrinaRows(List<Map<String, dynamic>> data) {
    return data.map((item) {
      final cells = <String, TrinaCell>{};
      item.forEach((key, value) {
        cells[key] = TrinaCell(value: value);
      });
      return TrinaRow(cells: cells);
    }).toList();
  }
  
  /// 将 GiTableColumn 列表转换为 TrinaColumn 列表
  static List<TrinaColumn> convertToTrinaColumns<T>(
    List<GiTableColumn<T>> columns,
  ) {
    return columns.map((col) => col.toTrinaColumn()).toList();
  }
  
  /// 列类型转换: GiColumnType → TrinaColumnType
  static TrinaColumnType convertColumnType(GiColumnType type) {
    switch (type) {
      case GiColumnType.text:
        return TrinaColumnType.text();
      case GiColumnType.number:
        return TrinaColumnType.number();
      case GiColumnType.date:
        return TrinaColumnType.date();
      case GiColumnType.time:
        return TrinaColumnType.time();
      case GiColumnType.datetime:
        return TrinaColumnType.date();
      case GiColumnType.select:
        return TrinaColumnType.text(); // select 类型使用 text
      case GiColumnType.currency:
        return TrinaColumnType.currency();
      case GiColumnType.percentage:
        return TrinaColumnType.percentage();
    }
  }
  
  /// TextAlign 转换
  static TrinaColumnTextAlign convertTextAlign(TextAlign? textAlign) {
    if (textAlign == null) return TrinaColumnTextAlign.left;
    
    switch (textAlign) {
      case TextAlign.left:
      case TextAlign.start:
        return TrinaColumnTextAlign.left;
      case TextAlign.right:
      case TextAlign.end:
        return TrinaColumnTextAlign.right;
      case TextAlign.center:
        return TrinaColumnTextAlign.center;
      default:
        return TrinaColumnTextAlign.left;
    }
  }
}

