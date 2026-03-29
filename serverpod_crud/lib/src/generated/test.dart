/* AUTOMATICALLY GENERATED CODE DO NOT MODIFY */
/*   To generate run: "serverpod generate"    */

// ignore_for_file: implementation_imports
// ignore_for_file: library_private_types_in_public_api
// ignore_for_file: non_constant_identifier_names
// ignore_for_file: public_member_api_docs
// ignore_for_file: type_literal_in_constant_pattern
// ignore_for_file: use_super_parameters
// ignore_for_file: invalid_use_of_internal_member

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:serverpod_serialization/serverpod_serialization.dart' as _i1;

///
abstract class Test implements _i1.SerializableModel {
  Test._({this.description});

  factory Test({String? description}) = _TestImpl;

  factory Test.fromJson(Map<String, dynamic> jsonSerialization) {
    return Test(description: jsonSerialization['description'] as String?);
  }

  String? description;

  /// Returns a shallow copy of this [Test]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  Test copyWith({String? description});
  @override
  Map<String, dynamic> toJson() {
    return {
      '__className__': 'Test',
      if (description != null) 'description': description,
    };
  }

  @override
  String toString() {
    return _i1.SerializationManager.encode(this);
  }
}

class _Undefined {}

class _TestImpl extends Test {
  _TestImpl({String? description}) : super._(description: description);

  /// Returns a shallow copy of this [Test]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  @override
  Test copyWith({Object? description = _Undefined}) {
    return Test(
      description: description is String? ? description : this.description,
    );
  }
}
