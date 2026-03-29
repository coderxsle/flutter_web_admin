import 'package:serverpod/serverpod.dart';

/// 单个校验错误。
class ValidationError implements SerializableModel {
  const ValidationError({required this.field, required this.message, this.code});

  final String field;
  final String message;
  final String? code;
  
  @override
  Map<String, dynamic> toJson() {
    return {
      'field': field,
      'message': message,
      'code': code,
    };
  }
}

/// 校验结果对象。
class ValidationResult implements SerializableModel{
  const ValidationResult._(this.errors);

  final List<ValidationError> errors;

  bool get isValid => errors.isEmpty;

  static ValidationResult success() => const ValidationResult._(<ValidationError>[]);

  static ValidationResult failure(List<ValidationError> errors) => ValidationResult._(errors);
  
  @override
  Map<String, dynamic> toJson() {
    return {
      'errors': errors.map((e) => e.toJson()).toList(),
    };
  }
}
