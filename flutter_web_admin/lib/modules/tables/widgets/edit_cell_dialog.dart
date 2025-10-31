import 'package:flutter/material.dart';
import 'package:flutter_web_admin/api/client.dart';
import 'package:flutter_web_admin/components/feedback/gi_acro_message.dart';
import 'package:flutter_web_client/client.dart';

/// 编辑单元格对话框
class EditCellDialog extends StatefulWidget {
  final AirTableRows row;
  final AirTableFieldsSummary field;
  final String currentValue;
  final AirTableItems? currentItem;
  final Function({
    required String value,
    int? tiedItemId,
    int? tiedFieldId,
    int? tiedTableId,
  }) onSave;
  final VoidCallback? onRemoveRelation;

  const EditCellDialog({
    super.key,
    required this.row,
    required this.field,
    required this.currentValue,
    this.currentItem,
    required this.onSave,
    this.onRemoveRelation,
  });

  @override
  State<EditCellDialog> createState() => _EditCellDialogState();
}

class _EditCellDialogState extends State<EditCellDialog> {
  late TextEditingController _valueController;
  
  // 关联相关的状态
  AirTables? _selectedTable;
  AirTableFields? _selectedField;
  AirTableItems? _selectedItem;
  
  List<AirTables> _tables = [];
  List<AirTableFields> _fields = [];
  List<AirTableItems> _searchResults = [];
  
  bool _searching = false;

  @override
  void initState() {
    super.initState();
    _valueController = TextEditingController(text: widget.currentValue);
    
    // 如果当前有关联，加载关联信息
    if (widget.currentItem?.item?.id != null) {
      _loadCurrentRelation();
    }
  }

  @override
  void dispose() {
    _valueController.dispose();
    super.dispose();
  }

  /// 加载当前关联信息
  Future<void> _loadCurrentRelation() async {
    // 这里可以根据需要加载关联的表格、字段、数据信息
    // 暂时简单显示已有的关联信息
  }

  /// 加载所有表格
  Future<void> _loadTables() async {
    if (_tables.isNotEmpty) return;
    
    try {
      final response = await client.tables.getTables(
        Pagination(
          page: 1,
          pageSize: 100,
        ),
      );
      setState(() => _tables = response.data as List<AirTables>);
    } catch (e) {
      // GiArcoMessage.error('加载表格失败: $e');
    }
  }

  /// 加载选中表格的字段
  Future<void> _loadFields(int tableId) async {
    try {
      final fields = await client.airTableFields.getAirTableFields(tableId);
      setState(() => _fields = fields.data as List<AirTableFields>);
    } catch (e) {
      GiArcoMessage.error('加载字段失败: $e');
    }
  }

  /// 搜索可关联的数据
  Future<void> _searchRelationItems(String keyword) async {
    if (_selectedTable == null || _selectedField == null) return;
    
    setState(() => _searching = true);
    try {
      final results = await client.tableItemRelations.searchTableItems(
        _selectedTable!.id!,
        fieldId: _selectedField!.id!,
        Pagination(
          page: 1,
          pageSize: 100,
          keyword: keyword,
        ),
      );
      setState(() => _searchResults = results.data as List<AirTableItems>);
    } catch (e) {
      GiArcoMessage.error('搜索可关联的数据失败: $e');
    } finally {
      setState(() => _searching = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Row(
        children: [
          const Icon(Icons.edit),
          const SizedBox(width: 12),
          Text('编辑单元格 - ${widget.field.field}'),
        ],
      ),
      content: SizedBox(
        width: 500,
        child: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // 值编辑
              const Text(
                '值',
                style: TextStyle(
                  fontWeight: FontWeight.w500,
                  fontSize: 14,
                ),
              ),
              const SizedBox(height: 8),
              TextField(
                controller: _valueController,
                autofocus: true,
                decoration: const InputDecoration(
                  hintText: '请输入值',
                  border: OutlineInputBorder(),
                  contentPadding: EdgeInsets.symmetric(
                    horizontal: 12,
                    vertical: 12,
                  ),
                ),
                maxLines: 3,
              ),
              const SizedBox(height: 24),
              
              // 关联设置
              Row(
                children: [
                  const Icon(Icons.link, size: 20),
                  const SizedBox(width: 8),
                  const Text(
                    '关联设置',
                    style: TextStyle(
                      fontWeight: FontWeight.w500,
                      fontSize: 16,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 16),
              
              // 选择关联表格
              _buildTableSelector(),
              const SizedBox(height: 12),
              
              // 选择关联字段
              if (_selectedTable != null) ...[
                _buildFieldSelector(),
                const SizedBox(height: 12),
              ],
              
              // 搜索和选择关联数据
              if (_selectedField != null) ...[
                _buildItemSelector(),
                const SizedBox(height: 12),
              ],
              
              // 当前关联信息
              if (widget.currentItem?.item?.id != null) ...[
                const SizedBox(height: 16),
                _buildCurrentRelation(),
              ],
            ],
          ),
        ),
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.pop(context),
          child: const Text('取消'),
        ),
        ElevatedButton(
          onPressed: _onSave,
          child: const Text('保存'),
        ),
      ],
    );
  }

  /// 表格选择器
  Widget _buildTableSelector() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text('关联到表格:', style: TextStyle(fontSize: 13)),
        const SizedBox(height: 4),
        DropdownButtonFormField<AirTables>(
          value: _selectedTable,
          hint: const Text('选择表格'),
          decoration: const InputDecoration(
            border: OutlineInputBorder(),
            contentPadding: EdgeInsets.symmetric(horizontal: 12, vertical: 8),
          ),
          items: _tables.map((table) {
            return DropdownMenuItem(
              value: table,
              child: Text(table.name),
            );
          }).toList(),
          onChanged: (table) {
            setState(() {
              _selectedTable = table;
              _selectedField = null;
              _selectedItem = null;
              _fields = [];
              _searchResults = [];
            });
            if (table != null) {
              _loadFields(table.id!);
            }
          },
          onTap: _loadTables,
        ),
      ],
    );
  }

  /// 字段选择器
  Widget _buildFieldSelector() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text('关联到字段:', style: TextStyle(fontSize: 13)),
        const SizedBox(height: 4),
        DropdownButtonFormField<AirTableFields>(
          value: _selectedField,
          hint: const Text('选择字段'),
          decoration: const InputDecoration(
            border: OutlineInputBorder(),
            contentPadding: EdgeInsets.symmetric(horizontal: 12, vertical: 8),
          ),
          items: _fields.map((field) {
            return DropdownMenuItem(
              value: field,
              child: Text(field.field),
            );
          }).toList(),
          onChanged: (field) {
            setState(() {
              _selectedField = field;
              _selectedItem = null;
              _searchResults = [];
            });
            if (field != null) {
              _searchRelationItems('');
            }
          },
        ),
      ],
    );
  }

  /// 数据选择器
  Widget _buildItemSelector() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text('关联到数据:', style: TextStyle(fontSize: 13)),
        const SizedBox(height: 4),
        TextField(
          decoration: const InputDecoration(
            hintText: '搜索数据...',
            border: OutlineInputBorder(),
            prefixIcon: Icon(Icons.search),
            contentPadding: EdgeInsets.symmetric(horizontal: 12, vertical: 8),
          ),
          onChanged: _searchRelationItems,
        ),
        const SizedBox(height: 8),
        if (_searching)
          const Center(child: CircularProgressIndicator())
        else if (_searchResults.isNotEmpty)
          Container(
            height: 150,
            decoration: BoxDecoration(
              border: Border.all(color: Colors.grey[300]!),
              borderRadius: BorderRadius.circular(4),
            ),
            child: ListView.builder(
              itemCount: _searchResults.length,
              itemBuilder: (context, index) {
                final item = _searchResults[index];
                return RadioListTile<AirTableItems>(
                  value: item,
                  groupValue: _selectedItem,
                  title: Text(item.value),
                  dense: true,
                  onChanged: (value) {
                    setState(() => _selectedItem = value);
                  },
                );
              },
            ),
          ),
      ],
    );
  }

  /// 显示当前关联
  Widget _buildCurrentRelation() {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.blue[50],
        borderRadius: BorderRadius.circular(4),
        border: Border.all(color: Colors.blue[200]!),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Row(
            children: [
              Icon(Icons.info, size: 16, color: Colors.blue),
              SizedBox(width: 8),
              Text(
                '当前关联:',
                style: TextStyle(
                  fontWeight: FontWeight.w500,
                  color: Colors.blue,
                ),
              ),
            ],
          ),
          const SizedBox(height: 8),
          Text('表格 ID: ${widget.currentItem!.item?.id}'),
          Text('字段 ID: ${widget.currentItem!.item?.fieldId}'),
          Text('数据 ID: ${widget.currentItem!.item?.id}'),
          const SizedBox(height: 8),
          if (widget.onRemoveRelation != null)
            TextButton.icon(
              icon: const Icon(Icons.link_off, size: 16),
              label: const Text('移除关联'),
              style: TextButton.styleFrom(
                foregroundColor: Colors.red,
              ),
              onPressed: () {
                widget.onRemoveRelation?.call();
                Navigator.pop(context);
              },
            ),
        ],
      ),
    );
  }

  /// 保存
  void _onSave() {
    final value = _valueController.text.trim();
    
    widget.onSave(
      value: value,
      tiedItemId: _selectedItem?.id,
      tiedFieldId: _selectedField?.id,
      tiedTableId: _selectedTable?.id,
    );
    
    Navigator.pop(context);
  }
}

