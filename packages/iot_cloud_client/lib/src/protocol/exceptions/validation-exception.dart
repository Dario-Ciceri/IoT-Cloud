/* AUTOMATICALLY GENERATED CODE DO NOT MODIFY */
/*   To generate run: "serverpod generate"    */

// ignore_for_file: implementation_imports
// ignore_for_file: library_private_types_in_public_api
// ignore_for_file: non_constant_identifier_names
// ignore_for_file: public_member_api_docs
// ignore_for_file: type_literal_in_constant_pattern
// ignore_for_file: use_super_parameters

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:serverpod_client/serverpod_client.dart' as _i1;

abstract class ValidationException
    implements _i1.SerializableException, _i1.SerializableModel {
  ValidationException._({
    required this.message,
    this.stackTrace,
    this.errors,
  });

  factory ValidationException({
    required String message,
    String? stackTrace,
    Map<String, List<String>>? errors,
  }) = _ValidationExceptionImpl;

  factory ValidationException.fromJson(Map<String, dynamic> jsonSerialization) {
    return ValidationException(
      message: jsonSerialization['message'] as String,
      stackTrace: jsonSerialization['stackTrace'] as String?,
      errors: (jsonSerialization['errors'] as Map?)?.map((k, v) => MapEntry(
            k as String,
            (v as List).map((e) => e as String).toList(),
          )),
    );
  }

  String message;

  String? stackTrace;

  Map<String, List<String>>? errors;

  /// Returns a shallow copy of this [ValidationException]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  ValidationException copyWith({
    String? message,
    String? stackTrace,
    Map<String, List<String>>? errors,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      'message': message,
      if (stackTrace != null) 'stackTrace': stackTrace,
      if (errors != null)
        'errors': errors?.toJson(valueToJson: (v) => v.toJson()),
    };
  }

  @override
  String toString() {
    return _i1.SerializationManager.encode(this);
  }
}

class _Undefined {}

class _ValidationExceptionImpl extends ValidationException {
  _ValidationExceptionImpl({
    required String message,
    String? stackTrace,
    Map<String, List<String>>? errors,
  }) : super._(
          message: message,
          stackTrace: stackTrace,
          errors: errors,
        );

  /// Returns a shallow copy of this [ValidationException]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  @override
  ValidationException copyWith({
    String? message,
    Object? stackTrace = _Undefined,
    Object? errors = _Undefined,
  }) {
    return ValidationException(
      message: message ?? this.message,
      stackTrace: stackTrace is String? ? stackTrace : this.stackTrace,
      errors: errors is Map<String, List<String>>?
          ? errors
          : this.errors?.map((
                key0,
                value0,
              ) =>
                  MapEntry(
                    key0,
                    value0.map((e1) => e1).toList(),
                  )),
    );
  }
}
