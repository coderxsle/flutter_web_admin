// import 'package:macros/macros.dart';

// class DeepCopyMacro implements ClassMacro {
//   const DeepCopyMacro();

//   @override
//   void visitClassDeclaration(
//       ClassDeclaration declaration, ClassVisitor visitor) {
//     final fields = declaration.fields;

//     // 遍历类的所有字段，并为每个字段生成复制逻辑
//     final fieldCopies = fields.map((field) {
//       if (field.type.isList) {
//         // 对 List 进行深拷贝
//         return '${field.name}: ${field.name}?.map((item) => item.copy()).toList(),';
//       } else if (field.type.isCustomClass) {
//         // 对自定义类进行深拷贝
//         return '${field.name}: ${field.name}?.copy(),';
//       } else {
//         // 对于简单类型，直接复制
//         return '${field.name}: ${field.name},';
//       }
//     }).join();

//     // 为类生成 `copy` 方法
//     final copyMethod = '''
//       ${declaration.name} copy() {
//         return ${declaration.name}(
//           $fieldCopies
//         );
//       }
//     ''';

//     // 将生成的 `copy` 方法添加到类中
//     visitor.visitMethodDeclaration(MethodDeclaration.parse(copyMethod));
//   }
// }
