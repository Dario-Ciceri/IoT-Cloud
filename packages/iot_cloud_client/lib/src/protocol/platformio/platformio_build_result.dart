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

abstract class PlatformioBuildResult implements _i1.SerializableModel {
  PlatformioBuildResult._({
    required this.success,
    required this.output,
    this.errorOutput,
    required this.duration,
  });

  factory PlatformioBuildResult({
    required bool success,
    required String output,
    String? errorOutput,
    required int duration,
  }) = _PlatformioBuildResultImpl;

  factory PlatformioBuildResult.fromJson(
      Map<String, dynamic> jsonSerialization) {
    return PlatformioBuildResult(
      success: jsonSerialization['success'] as bool,
      output: jsonSerialization['output'] as String,
      errorOutput: jsonSerialization['errorOutput'] as String?,
      duration: jsonSerialization['duration'] as int,
    );
  }

  bool success;

  String output;

  String? errorOutput;

  int duration;

  /// Returns a shallow copy of this [PlatformioBuildResult]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  PlatformioBuildResult copyWith({
    bool? success,
    String? output,
    String? errorOutput,
    int? duration,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      'success': success,
      'output': output,
      if (errorOutput != null) 'errorOutput': errorOutput,
      'duration': duration,
    };
  }

  @override
  String toString() {
    return _i1.SerializationManager.encode(this);
  }
}

class _Undefined {}

class _PlatformioBuildResultImpl extends PlatformioBuildResult {
  _PlatformioBuildResultImpl({
    required bool success,
    required String output,
    String? errorOutput,
    required int duration,
  }) : super._(
          success: success,
          output: output,
          errorOutput: errorOutput,
          duration: duration,
        );

  /// Returns a shallow copy of this [PlatformioBuildResult]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  @override
  PlatformioBuildResult copyWith({
    bool? success,
    String? output,
    Object? errorOutput = _Undefined,
    int? duration,
  }) {
    return PlatformioBuildResult(
      success: success ?? this.success,
      output: output ?? this.output,
      errorOutput: errorOutput is String? ? errorOutput : this.errorOutput,
      duration: duration ?? this.duration,
    );
  }
}
