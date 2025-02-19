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
import '../io_module/io_module_info.dart' as _i2;
import '../io_module/io_module_state.dart' as _i3;

abstract class IoModule implements _i1.SerializableModel {
  IoModule._({
    required this.info,
    required this.state,
  });

  factory IoModule({
    required _i2.IoModuleInfo info,
    required _i3.IoModuleState state,
  }) = _IoModuleImpl;

  factory IoModule.fromJson(Map<String, dynamic> jsonSerialization) {
    return IoModule(
      info: _i2.IoModuleInfo.fromJson(
          (jsonSerialization['info'] as Map<String, dynamic>)),
      state: _i3.IoModuleState.fromJson(
          (jsonSerialization['state'] as Map<String, dynamic>)),
    );
  }

  _i2.IoModuleInfo info;

  _i3.IoModuleState state;

  IoModule copyWith({
    _i2.IoModuleInfo? info,
    _i3.IoModuleState? state,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      'info': info.toJson(),
      'state': state.toJson(),
    };
  }

  @override
  String toString() {
    return _i1.SerializationManager.encode(this);
  }
}

class _IoModuleImpl extends IoModule {
  _IoModuleImpl({
    required _i2.IoModuleInfo info,
    required _i3.IoModuleState state,
  }) : super._(
          info: info,
          state: state,
        );

  @override
  IoModule copyWith({
    _i2.IoModuleInfo? info,
    _i3.IoModuleState? state,
  }) {
    return IoModule(
      info: info ?? this.info.copyWith(),
      state: state ?? this.state.copyWith(),
    );
  }
}
