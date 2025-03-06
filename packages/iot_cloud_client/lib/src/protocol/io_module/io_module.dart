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
import '../iot_device/iot_device.dart' as _i2;
import '../io_module/io_module_state.dart' as _i3;
import '../io_module/io_module_type.dart' as _i4;
import '../io_module/io_module_subtype.dart' as _i5;

abstract class IoModule implements _i1.SerializableModel {
  IoModule._({
    this.id,
    required this.iotDeviceId,
    this.iotDevice,
    required this.stateId,
    this.state,
    required this.serialId,
    required this.name,
    required this.type,
    required this.subtype,
    required this.createdAt,
    required this.updatedAt,
  });

  factory IoModule({
    int? id,
    required int iotDeviceId,
    _i2.IotDevice? iotDevice,
    required int stateId,
    _i3.IoModuleState? state,
    required String serialId,
    required String name,
    required _i4.IoModuleType type,
    required _i5.IoModuleSubType subtype,
    required DateTime createdAt,
    required DateTime updatedAt,
  }) = _IoModuleImpl;

  factory IoModule.fromJson(Map<String, dynamic> jsonSerialization) {
    return IoModule(
      id: jsonSerialization['id'] as int?,
      iotDeviceId: jsonSerialization['iotDeviceId'] as int,
      iotDevice: jsonSerialization['iotDevice'] == null
          ? null
          : _i2.IotDevice.fromJson(
              (jsonSerialization['iotDevice'] as Map<String, dynamic>)),
      stateId: jsonSerialization['stateId'] as int,
      state: jsonSerialization['state'] == null
          ? null
          : _i3.IoModuleState.fromJson(
              (jsonSerialization['state'] as Map<String, dynamic>)),
      serialId: jsonSerialization['serialId'] as String,
      name: jsonSerialization['name'] as String,
      type: _i4.IoModuleType.fromJson((jsonSerialization['type'] as int)),
      subtype:
          _i5.IoModuleSubType.fromJson((jsonSerialization['subtype'] as int)),
      createdAt:
          _i1.DateTimeJsonExtension.fromJson(jsonSerialization['createdAt']),
      updatedAt:
          _i1.DateTimeJsonExtension.fromJson(jsonSerialization['updatedAt']),
    );
  }

  /// The database id, set if the object has been inserted into the
  /// database or if it has been fetched from the database. Otherwise,
  /// the id will be null.
  int? id;

  int iotDeviceId;

  _i2.IotDevice? iotDevice;

  int stateId;

  _i3.IoModuleState? state;

  String serialId;

  String name;

  _i4.IoModuleType type;

  _i5.IoModuleSubType subtype;

  DateTime createdAt;

  DateTime updatedAt;

  /// Returns a shallow copy of this [IoModule]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  IoModule copyWith({
    int? id,
    int? iotDeviceId,
    _i2.IotDevice? iotDevice,
    int? stateId,
    _i3.IoModuleState? state,
    String? serialId,
    String? name,
    _i4.IoModuleType? type,
    _i5.IoModuleSubType? subtype,
    DateTime? createdAt,
    DateTime? updatedAt,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      if (id != null) 'id': id,
      'iotDeviceId': iotDeviceId,
      if (iotDevice != null) 'iotDevice': iotDevice?.toJson(),
      'stateId': stateId,
      if (state != null) 'state': state?.toJson(),
      'serialId': serialId,
      'name': name,
      'type': type.toJson(),
      'subtype': subtype.toJson(),
      'createdAt': createdAt.toJson(),
      'updatedAt': updatedAt.toJson(),
    };
  }

  @override
  String toString() {
    return _i1.SerializationManager.encode(this);
  }
}

class _Undefined {}

class _IoModuleImpl extends IoModule {
  _IoModuleImpl({
    int? id,
    required int iotDeviceId,
    _i2.IotDevice? iotDevice,
    required int stateId,
    _i3.IoModuleState? state,
    required String serialId,
    required String name,
    required _i4.IoModuleType type,
    required _i5.IoModuleSubType subtype,
    required DateTime createdAt,
    required DateTime updatedAt,
  }) : super._(
          id: id,
          iotDeviceId: iotDeviceId,
          iotDevice: iotDevice,
          stateId: stateId,
          state: state,
          serialId: serialId,
          name: name,
          type: type,
          subtype: subtype,
          createdAt: createdAt,
          updatedAt: updatedAt,
        );

  /// Returns a shallow copy of this [IoModule]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  @override
  IoModule copyWith({
    Object? id = _Undefined,
    int? iotDeviceId,
    Object? iotDevice = _Undefined,
    int? stateId,
    Object? state = _Undefined,
    String? serialId,
    String? name,
    _i4.IoModuleType? type,
    _i5.IoModuleSubType? subtype,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) {
    return IoModule(
      id: id is int? ? id : this.id,
      iotDeviceId: iotDeviceId ?? this.iotDeviceId,
      iotDevice:
          iotDevice is _i2.IotDevice? ? iotDevice : this.iotDevice?.copyWith(),
      stateId: stateId ?? this.stateId,
      state: state is _i3.IoModuleState? ? state : this.state?.copyWith(),
      serialId: serialId ?? this.serialId,
      name: name ?? this.name,
      type: type ?? this.type,
      subtype: subtype ?? this.subtype,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }
}
