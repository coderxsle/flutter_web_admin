/// Gi Flutter Admin - Flutter 版后台管理组件库
/// 
/// 基于 Vue3 的 Gi Admin Pro 项目，使用 Flutter 技术栈重新实现的企业级后台管理组件库
/// 
/// 使用示例：
/// ```dart
/// import 'package:gi_flutter_admin/gi_flutter_admin.dart';
/// 
/// // 使用按钮组件
/// GiButton(
///   type: GiButtonType.add,
///   onPressed: () => print('点击了新增按钮'),
/// )
/// 
/// // 使用间距组件
/// GiSpace(
///   children: [
///     Text('项目1'),
///     Text('项目2'),
///   ],
/// )
/// ```
library dang_gui_admin;

// ==================== 主题系统 ====================
// export 'theme/theme_config.dart';
// export 'theme/theme_controller.dart';

// ==================== 按钮组件 ====================
export 'button/gi_arco_button.dart';
export 'button/gi_button_group.dart';

// ==================== 通用组件 ====================
export 'common/gi_space.dart';
export 'feedback/gi_acro_message.dart';

// ==================== 表单组件 ====================
export 'form/gi_form.dart';
export 'form/gi_form_column.dart';
export 'form/gi_form_item.dart';

// ==================== 表格组件 ====================
// 新版 GiTable (基于 trina_grid 封装)
export 'table/index.dart';

// ==================== 布局组件 ====================
// export 'layout/gi_admin_layout.dart';
// export 'layout/gi_page_layout.dart';

// ==================== 标签组件 ====================
export 'tag/gi_tag.dart';

// ==================== 单元格组件 ====================
export 'cell/gi_cell_avatar.dart';
export 'cell/gi_cell_status.dart';
export 'cell/gi_cell_gender.dart';

// ==================== 数据模型 ====================
// export 'models/user_model.dart';
