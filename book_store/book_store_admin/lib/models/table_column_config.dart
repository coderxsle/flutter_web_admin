import 'package:flutter/material.dart';
import 'package:book_store_client/book_store_client.dart';

class TableColumnConfig {
  final String id;
  final String title;
  double width;
  final Widget Function(Book book, int index) builder;

  TableColumnConfig({
    required this.id,
    required this.title,
    required this.width,
    required this.builder,
  });
} 