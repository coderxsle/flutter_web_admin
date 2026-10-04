import 'package:serverpod/serverpod.dart';

import 'validation_result.dart';

/// 单条校验规则。
typedef ValidationRule<T> = ValidationError? Function(T data);

/// 校验器抽象。
abstract class Validator<T> implements SerializableModel{
  const Validator();

  ValidationResult validate(T data);
}

class RuleBasedValidator<T> extends Validator<T> implements SerializableModel {
  const RuleBasedValidator(this.rules);

  final List<ValidationRule<T>> rules;

  @override
  ValidationResult validate(T data) {
    final errors = <ValidationError>[];
    for (final rule in rules) {
      final error = rule(data);
      if (error != null) errors.add(error);
    }
    return errors.isEmpty ? ValidationResult.success() : ValidationResult.failure(errors);
  }
  
  @override
  Map<String, dynamic> toJson() {
    return {
      'rules': rules.map((_) => null).toList(),
    };
  }
}
