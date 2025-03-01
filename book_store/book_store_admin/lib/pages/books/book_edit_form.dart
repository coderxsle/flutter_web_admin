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
    _imageController = TextEditingController(text: book?.image ?? '');
    _originalPriceController = TextEditingController(
      text: book?.originalPrice.toString() ?? '',
    );
    _salePriceController = TextEditingController(
      text: book?.originalPrice.toString() ?? '',
    );
    _inventoryController = TextEditingController(
      // text: book?.inventory.toString() ?? '0',
      text: '0', // 临时
    );
  }

  void _submit() {
    if (_formKey.currentState!.validate()) {
      final book = Book(
        id: widget.book?.id,
        name: _nameController.text,
        isbn: _isbnController.text,
        author: _authorController.text,
        publisher: _publisherController.text,
        image: _imageController.text,
        originalPrice: double.tryParse(_originalPriceController.text) ?? 0,
        // salePrice: double.tryParse(_salePriceController.text),
        // salePrice: 0, // 临时
        // inventory: int.tryParse(_inventoryController.text) ?? 0,
        // inventory: 0, // 临时
      );
      Get.back(result: book);
    }
  }

  Widget _buildFormField({
    required String label,
    required TextEditingController controller,
    String? Function(String?)? validator,
    TextInputType? keyboardType,
    bool required = false,
  }) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        SizedBox(
          width: 80,  // 固定标签宽度
          child: Row(
            children: [
              Text(
                label,
                style: const TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w500,
                ),
              ),
              if (required)
                const Text(
                  ' *',
                  style: TextStyle(
                    color: Colors.red,
                    fontSize: 14,
                  ),
                ),
            ],
          ),
        ),
        const SizedBox(width: 12),
        Expanded(
          child: TextFormField(
            controller: controller,
            keyboardType: keyboardType,
            validator: validator,
            decoration: InputDecoration(
              contentPadding: const EdgeInsets.symmetric(
                horizontal: 12,
                vertical: 8,
              ),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(4),
                borderSide: BorderSide(color: Colors.grey[300]!),
              ),
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(4),
                borderSide: BorderSide(color: Colors.grey[300]!),
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(4),
                borderSide: const BorderSide(color: Colors.blue),
              ),
              filled: true,
              fillColor: Colors.white,
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildNumberField({
    required String label,
    required TextEditingController controller,
    bool required = false,
  }) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        SizedBox(
          width: 80,  // 固定标签宽度
          child: Row(
            children: [
              Text(
                label,
                style: const TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w500,
                ),
              ),
              if (required)
                const Text(
                  ' *',
                  style: TextStyle(
                    color: Colors.red,
                    fontSize: 14,
                  ),
                ),
            ],
          ),
        ),
        const SizedBox(width: 12),
        SizedBox(
          width: 160,  // 数字输入框的宽度
          child: Container(
            decoration: BoxDecoration(
              border: Border.all(color: Colors.grey[300]!),
              borderRadius: BorderRadius.circular(4),
            ),
            child: Row(
              children: [
                IconButton(
                  icon: const Icon(Icons.remove, size: 20),
                  onPressed: () {
                    final value = int.tryParse(controller.text) ?? 0;
                    if (value > 0) {
                      controller.text = (value - 1).toString();
                    }
                  },
                ),
                Expanded(
                  child: TextFormField(
                    controller: controller,
                    keyboardType: TextInputType.number,
                    textAlign: TextAlign.center,
                    decoration: const InputDecoration(
                      border: InputBorder.none,
                      contentPadding: EdgeInsets.zero,
                    ),
                    validator: (value) {
                      if (required && (value == null || value.isEmpty)) {
                        return '此字段不能为空';
                      }
                      if (value != null && double.tryParse(value) == null) {
                        return '请输入有效的数字';
                      }
                      return null;
                    },
                  ),
                ),
                IconButton(
                  icon: const Icon(Icons.add, size: 20),
                  onPressed: () {
                    final value = int.tryParse(controller.text) ?? 0;
                    controller.text = (value + 1).toString();
                  },
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildFormField(
            label: '书名',
            controller: _nameController,
            required: true,
            validator: (value) {
              if (value == null || value.isEmpty) {
                return '请输入书名';
              }
              return null;
            },
          ),
          const SizedBox(height: 16),
          _buildFormField(
            label: '书号',
            controller: _isbnController,
            required: true,
          ),
          const SizedBox(height: 16),
          _buildFormField(
            label: '作者',
            controller: _authorController,
            required: true,
          ),
          const SizedBox(height: 16),
          _buildFormField(
            label: '出版社',
            controller: _publisherController,
            required: true,
          ),
          const SizedBox(height: 16),
          _buildFormField(
            label: '封面',
            controller: _imageController,
            required: true,
          ),
          const SizedBox(height: 16),
          _buildNumberField(
            label: '进货价',
            controller: _originalPriceController,
            required: true,
          ),
          const SizedBox(height: 16),
          _buildNumberField(
            label: '销售价',
            controller: _salePriceController,
            required: true,
          ),
          const SizedBox(height: 16),
          _buildNumberField(
            label: '库存',
            controller: _inventoryController,
            required: true,
          ),
          const SizedBox(height: 24),
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              TextButton(
                onPressed: () => Get.back(),
                style: TextButton.styleFrom(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 24,
                    vertical: 12,
                  ),
                ),
                child: const Text('取消'),
              ),
              const SizedBox(width: 12),
              ElevatedButton(
                onPressed: _submit,
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.blue,
                  foregroundColor: Colors.white,
                  padding: const EdgeInsets.symmetric(
                    horizontal: 24,
                    vertical: 12,
                  ),
                ),
                child: const Text('修改'),
              ),
            ],
          ),
        ],
      ),
    );
  }

  @override
  void dispose() {
    _nameController.dispose();
    _isbnController.dispose();
    _authorController.dispose();
    _publisherController.dispose();
    _originalPriceController.dispose();
    _salePriceController.dispose();
    _inventoryController.dispose();
    super.dispose();
  }
}