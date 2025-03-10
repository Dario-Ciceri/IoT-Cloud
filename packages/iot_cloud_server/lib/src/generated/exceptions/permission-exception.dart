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

abstract class PermissionException
    implements
        _i1.SerializableException,
        _i1.SerializableModel,
        _i1.ProtocolSerialization {
  PermissionException._({
    required this.message,
    this.stackTrace,
  });

  factory PermissionException({
    required String message,
    String? stackTrace,
  }) = _PermissionExceptionImpl;

  factory PermissionException.fromJson(Map<String, dynamic> jsonSerialization) {
    return PermissionException(
      message: jsonSerialization['message'] as String,
      stackTrace: jsonSerialization['stackTrace'] as String?,
    );
  }

  String message;

  String? stackTrace;

  /// Returns a shallow copy of this [PermissionException]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  PermissionException copyWith({
    String? message,
    String? stackTrace,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      'message': message,
      if (stackTrace != null) 'stackTrace': stackTrace,
    };
  }

  @override
  Map<String, dynamic> toJsonForProtocol() {
    return {
      'message': message,
      if (stackTrace != null) 'stackTrace': stackTrace,
    };
  }

  @override
  String toString() {
    return _i1.SerializationManager.encode(this);
  }
}

class _Undefined {}

class _PermissionExceptionImpl extends PermissionException {
  _PermissionExceptionImpl({
    required String message,
    String? stackTrace,
  }) : super._(
          message: message,
          stackTrace: stackTrace,
        );

  /// Returns a shallow copy of this [PermissionException]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  @override
  PermissionException copyWith({
    String? message,
    Object? stackTrace = _Undefined,
  }) {
    return PermissionException(
      message: message ?? this.message,
      stackTrace: stackTrace is String? ? stackTrace : this.stackTrace,
    );
  }
}
