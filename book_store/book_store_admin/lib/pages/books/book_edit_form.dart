import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:book_store_client/book_store_client.dart';

class BookEditForm extends StatefulWidget {
  final Book? book;

  const BookEditForm({super.key, this.book});

  @override
  State<BookEditForm> createState() => _BookEditFormState();
}

class _BookEditFormState extends State<BookEditForm> {
  final _formKey = GlobalKey<FormState>();
  late final TextEditingController _nameController;
  late final TextEditingController _isbnController;
  late final TextEditingController _authorController;
  late final TextEditingController _publisherController;
  late final TextEditingController _keywordController;
  late final TextEditingController _imageController;
  late final TextEditingController _originalPriceController;
  late final TextEditingController _salePriceController;
  late final TextEditingController _inventoryController;

  @override
  void initState() {
    super.initState();
    final book = widget.book;
    _nameController = TextEditingController(text: book?.name ?? '');
    _isbnController = TextEditingController(text: book?.isbn ?? '');
    _authorController = TextEditingController(text: book?.author ?? '');
    _publisherController = TextEditingController(text: book?.publisher ?? '');
    _keywordController = TextEditingController(text: book?.keyword ?? '');
    _imageController = TextEditingController(text: book?.image ?? '');
    _originalPriceController = TextEditingController(
      text: book?.originalPrice?.toString() ?? '',
    );
    _salePriceController = TextEditingController(
      text: book?.salePrice?.toString() ?? '',
    );
    _inventoryController = TextEditingController(
      text: book?.inventory?.toString() ?? '0',
    );
  }

  @override
  void dispose() {
    _nameController.dispose();
    _isbnController.dispose();
    _authorController.dispose();
    _publisherController.dispose();
    _keywordController.dispose();
    _imageController.dispose();
    _originalPriceController.dispose();
    _salePriceController.dispose();
    _inventoryController.dispose();
    super.dispose();
  }

  void _submit() {
    if (_formKey.currentState!.validate()) {
      final book = Book(
        id: widget.book?.id,
        name: _nameController.text,
        isbn: _isbnController.text,
        author: _authorController.text,
        publisher: _publisherController.text,
        keyword: _keywordController.text,
        image: _imageController.text,
        originalPrice: double.tryParse(_originalPriceController.text) ?? 0,
        salePrice: double.tryParse(_salePriceController.text),
        inventory: int.tryParse(_inventoryController.text) ?? 0,
      );
      Get.back(result: book);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          TextFormField(
            controller: _nameController,
            decoration: const InputDecoration(
              labelText: '书名',
              hintText: '请输入书名',
            ),
            validator: (value) {
              if (value == null || value.isEmpty) {
                return '请输入书名';
              }
              return null;
            },
          ),
          SizedBox(height: 16.h),
          TextFormField(
            controller: _isbnController,
            decoration: const InputDecoration(
              labelText: 'ISBN',
              hintText: '请输入ISBN',
            ),
          ),
          SizedBox(height: 16.h),
          TextFormField(
            controller: _authorController,
            decoration: const InputDecoration(
              labelText: '作者',
              hintText: '请输入作者',
            ),
          ),
          SizedBox(height: 16.h),
          TextFormField(
            controller: _publisherController,
            decoration: const InputDecoration(
              labelText: '出版社',
              hintText: '请输入出版社',
            ),
          ),
          SizedBox(height: 16.h),
          TextFormField(
            controller: _keywordController,
            decoration: const InputDecoration(
              labelText: '关键词',
              hintText: '请输入关键词',
            ),
          ),
          SizedBox(height: 16.h),
          TextFormField(
            controller: _imageController,
            decoration: const InputDecoration(
              labelText: '图片URL',
              hintText: '请输入图片URL',
            ),
          ),
          SizedBox(height: 16.h),
          Row(
            children: [
              Expanded(
                child: TextFormField(
                  controller: _originalPriceController,
                  decoration: const InputDecoration(
                    labelText: '原价',
                    hintText: '请输入原价',
                  ),
                  keyboardType: TextInputType.number,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return '请输入原价';
                    }
                    if (double.tryParse(value) == null) {
                      return '请输入有效的价格';
                    }
                    return null;
                  },
                ),
              ),
              SizedBox(width: 16.w),
              Expanded(
                child: TextFormField(
                  controller: _salePriceController,
                  decoration: const InputDecoration(
                    labelText: '销售价',
                    hintText: '请输入销售价',
                  ),
                  keyboardType: TextInputType.number,
                ),
              ),
            ],
          ),
          SizedBox(height: 16.h),
          TextFormField(
            controller: _inventoryController,
            decoration: const InputDecoration(
              labelText: '库存',
              hintText: '请输入库存',
            ),
            keyboardType: TextInputType.number,
            validator: (value) {
              if (value == null || value.isEmpty) {
                return '请输入库存';
              }
              if (int.tryParse(value) == null) {
                return '请输入有效的库存数量';
              }
              return null;
            },
          ),
          SizedBox(height: 24.h),
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              TextButton(
                onPressed: () => Get.back(),
                child: const Text('取消'),
              ),
              SizedBox(width: 16.w),
              ElevatedButton(
                onPressed: _submit,
                child: const Text('确定'),
              ),
            ],
          ),
        ],
      ),
    );
  }
}