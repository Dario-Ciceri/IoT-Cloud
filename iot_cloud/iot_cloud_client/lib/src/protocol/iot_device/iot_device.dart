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
import '../iot_device/iot_device_info.dart' as _i2;
import '../iot_device/iot_device_state.dart' as _i3;
import '../io_module/io_module.dart' as _i4;

abstract class IotDevice implements _i1.SerializableModel {
  IotDevice._({
    this.id,
    required this.info,
    required this.state,
    required this.attachedModules,
  });

  factory IotDevice({
    int? id,
    required _i2.IotDeviceInfo info,
    required _i3.IotDeviceState state,
    required List<_i4.IoModule> attachedModules,
  }) = _IotDeviceImpl;

  factory IotDevice.fromJson(Map<String, dynamic> jsonSerialization) {
    return IotDevice(
      id: jsonSerialization['id'] as int?,
      info: _i2.IotDeviceInfo.fromJson(
          (jsonSerialization['info'] as Map<String, dynamic>)),
      state: _i3.IotDeviceState.fromJson(
          (jsonSerialization['state'] as Map<String, dynamic>)),
      attachedModules: (jsonSerialization['attachedModules'] as List)
          .map((e) => _i4.IoModule.fromJson((e as Map<String, dynamic>)))
          .toList(),
    );
  }

  /// The database id, set if the object has been inserted into the
  /// database or if it has been fetched from the database. Otherwise,
  /// the id will be null.
  int? id;

  _i2.IotDeviceInfo info;

  _i3.IotDeviceState state;

  List<_i4.IoModule> attachedModules;

  IotDevice copyWith({
    int? id,
    _i2.IotDeviceInfo? info,
    _i3.IotDeviceState? state,
    List<_i4.IoModule>? attachedModules,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      if (id != null) 'id': id,
      'info': info.toJson(),
      'state': state.toJson(),
      'attachedModules': attachedModules.toJson(valueToJson: (v) => v.toJson()),
    };
  }

  @override
  String toString() {
    return _i1.SerializationManager.encode(this);
  }
}

class _Undefined {}

class _IotDeviceImpl extends IotDevice {
  _IotDeviceImpl({
    int? id,
    required _i2.IotDeviceInfo info,
    required _i3.IotDeviceState state,
    required List<_i4.IoModule> attachedModules,
  }) : super._(
          id: id,
          info: info,
          state: state,
          attachedModules: attachedModules,
        );

  @override
  IotDevice copyWith({
    Object? id = _Undefined,
    _i2.IotDeviceInfo? info,
    _i3.IotDeviceState? state,
    List<_i4.IoModule>? attachedModules,
  }) {
    return IotDevice(
      id: id is int? ? id : this.id,
      info: info ?? this.info.copyWith(),
      state: state ?? this.state.copyWith(),
      attachedModules: attachedModules ??
          this.attachedModules.map((e0) => e0.copyWith()).toList(),
    );
  }
}
