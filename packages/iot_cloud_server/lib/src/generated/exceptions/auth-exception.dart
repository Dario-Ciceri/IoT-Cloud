/* AUTOMATICALLY GENERATED CODE DO NOT MODIFY */
/*   To generate run: "serverpod generate"    */

// ignore_for_file: implementation_imports
// ignore_for_file: library_private_types_in_public_api
// ignore_for_file: non_constant_identifier_names
// ignore_for_file: public_member_api_docs
// ignore_for_file: type_literal_in_constant_pattern
// ignore_for_file: use_super_parameters

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:serverpod/serverpod.dart' as _i1;

abstract class AuthException
    implements
        _i1.SerializableException,
        _i1.SerializableModel,
        _i1.ProtocolSerialization {
  AuthException._({
    required this.message,
    this.stackTrace,
    this.statusCode,
  });

  factory AuthException({
    required String message,
    String? stackTrace,
    int? statusCode,
  }) = _AuthExceptionImpl;

  factory AuthException.fromJson(Map<String, dynamic> jsonSerialization) {
    return AuthException(
      message: jsonSerialization['message'] as String,
      stackTrace: jsonSerialization['stackTrace'] as String?,
      statusCode: jsonSerialization['statusCode'] as int?,
    );
  }

  String message;

  String? stackTrace;

  int? statusCode;

  /// Returns a shallow copy of this [AuthException]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  AuthException copyWith({
    String? message,
    String? stackTrace,
    int? statusCode,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      'message': message,
      if (stackTrace != null) 'stackTrace': stackTrace,
      if (statusCode != null) 'statusCode': statusCode,
    };
  }

  @override
  Map<String, dynamic> toJsonForProtocol() {
    return {
      'message': message,
      if (stackTrace != null) 'stackTrace': stackTrace,
      if (statusCode != null) 'statusCode': statusCode,
    };
  }

  @override
  String toString() {
    return _i1.SerializationManager.encode(this);
  }
}

class _Undefined {}

class _AuthExceptionImpl extends AuthException {
  _AuthExceptionImpl({
    required String message,
    String? stackTrace,
    int? statusCode,
  }) : super._(
          message: message,
          stackTrace: stackTrace,
          statusCode: statusCode,
        );

  /// Returns a shallow copy of this [AuthException]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  @override
  AuthException copyWith({
    String? message,
    Object? stackTrace = _Undefined,
    Object? statusCode = _Undefined,
  }) {
    return AuthException(
      message: message ?? this.message,
      stackTrace: stackTrace is String? ? stackTrace : this.stackTrace,
      statusCode: statusCode is int? ? statusCode : this.statusCode,
    );
  }
}
