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

abstract class PlatformioStatus implements _i1.SerializableModel {
  PlatformioStatus._({
    required this.installed,
    required this.version,
    this.errorMessage,
  });

  factory PlatformioStatus({
    required bool installed,
    required String version,
    String? errorMessage,
  }) = _PlatformioStatusImpl;

  factory PlatformioStatus.fromJson(Map<String, dynamic> jsonSerialization) {
    return PlatformioStatus(
      installed: jsonSerialization['installed'] as bool,
      version: jsonSerialization['version'] as String,
      errorMessage: jsonSerialization['errorMessage'] as String?,
    );
  }

  bool installed;

  String version;

  String? errorMessage;

  /// Returns a shallow copy of this [PlatformioStatus]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  PlatformioStatus copyWith({
    bool? installed,
    String? version,
    String? errorMessage,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      'installed': installed,
      'version': version,
      if (errorMessage != null) 'errorMessage': errorMessage,
    };
  }

  @override
  String toString() {
    return _i1.SerializationManager.encode(this);
  }
}

class _Undefined {}

class _PlatformioStatusImpl extends PlatformioStatus {
  _PlatformioStatusImpl({
    required bool installed,
    required String version,
    String? errorMessage,
  }) : super._(
          installed: installed,
          version: version,
          errorMessage: errorMessage,
        );

  /// Returns a shallow copy of this [PlatformioStatus]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  @override
  PlatformioStatus copyWith({
    bool? installed,
    String? version,
    Object? errorMessage = _Undefined,
  }) {
    return PlatformioStatus(
      installed: installed ?? this.installed,
      version: version ?? this.version,
      errorMessage: errorMessage is String? ? errorMessage : this.errorMessage,
    );
  }
}
