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
import '../iot_device/iot_device_type.dart' as _i2;
import '../iot_device/iot_device_state.dart' as _i3;
import '../io_module/io_module.dart' as _i4;
import '../pin/pin.dart' as _i5;

abstract class IotDevice implements _i1.SerializableModel {
  IotDevice._({
    this.id,
    required this.serialId,
    required this.type,
    required this.name,
    required this.fwVersion,
    required this.stateId,
    this.state,
    this.attachedModules,
    this.pins,
    required this.createdAt,
    required this.updatedAt,
  });

  factory IotDevice({
    int? id,
    required String serialId,
    required _i2.IotDeviceType type,
    required String name,
    required String fwVersion,
    required int stateId,
    _i3.IotDeviceState? state,
    List<_i4.IoModule>? attachedModules,
    List<_i5.Pin>? pins,
    required DateTime createdAt,
    required DateTime updatedAt,
  }) = _IotDeviceImpl;

  factory IotDevice.fromJson(Map<String, dynamic> jsonSerialization) {
    return IotDevice(
      id: jsonSerialization['id'] as int?,
      serialId: jsonSerialization['serialId'] as String,
      type: _i2.IotDeviceType.fromJson((jsonSerialization['type'] as int)),
      name: jsonSerialization['name'] as String,
      fwVersion: jsonSerialization['fwVersion'] as String,
      stateId: jsonSerialization['stateId'] as int,
      state: jsonSerialization['state'] == null
          ? null
          : _i3.IotDeviceState.fromJson(
              (jsonSerialization['state'] as Map<String, dynamic>)),
      attachedModules: (jsonSerialization['attachedModules'] as List?)
          ?.map((e) => _i4.IoModule.fromJson((e as Map<String, dynamic>)))
          .toList(),
      pins: (jsonSerialization['pins'] as List?)
          ?.map((e) => _i5.Pin.fromJson((e as Map<String, dynamic>)))
          .toList(),
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

  String serialId;

  _i2.IotDeviceType type;

  String name;

  String fwVersion;

  int stateId;

  _i3.IotDeviceState? state;

  List<_i4.IoModule>? attachedModules;

  List<_i5.Pin>? pins;

  DateTime createdAt;

  DateTime updatedAt;

  IotDevice copyWith({
    int? id,
    String? serialId,
    _i2.IotDeviceType? type,
    String? name,
    String? fwVersion,
    int? stateId,
    _i3.IotDeviceState? state,
    List<_i4.IoModule>? attachedModules,
    List<_i5.Pin>? pins,
    DateTime? createdAt,
    DateTime? updatedAt,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      if (id != null) 'id': id,
      'serialId': serialId,
      'type': type.toJson(),
      'name': name,
      'fwVersion': fwVersion,
      'stateId': stateId,
      if (state != null) 'state': state?.toJson(),
      if (attachedModules != null)
        'attachedModules':
            attachedModules?.toJson(valueToJson: (v) => v.toJson()),
      if (pins != null) 'pins': pins?.toJson(valueToJson: (v) => v.toJson()),
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

class _IotDeviceImpl extends IotDevice {
  _IotDeviceImpl({
    int? id,
    required String serialId,
    required _i2.IotDeviceType type,
    required String name,
    required String fwVersion,
    required int stateId,
    _i3.IotDeviceState? state,
    List<_i4.IoModule>? attachedModules,
    List<_i5.Pin>? pins,
    required DateTime createdAt,
    required DateTime updatedAt,
  }) : super._(
          id: id,
          serialId: serialId,
          type: type,
          name: name,
          fwVersion: fwVersion,
          stateId: stateId,
          state: state,
          attachedModules: attachedModules,
          pins: pins,
          createdAt: createdAt,
          updatedAt: updatedAt,
        );

  @override
  IotDevice copyWith({
    Object? id = _Undefined,
    String? serialId,
    _i2.IotDeviceType? type,
    String? name,
    String? fwVersion,
    int? stateId,
    Object? state = _Undefined,
    Object? attachedModules = _Undefined,
    Object? pins = _Undefined,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) {
    return IotDevice(
      id: id is int? ? id : this.id,
      serialId: serialId ?? this.serialId,
      type: type ?? this.type,
      name: name ?? this.name,
      fwVersion: fwVersion ?? this.fwVersion,
      stateId: stateId ?? this.stateId,
      state: state is _i3.IotDeviceState? ? state : this.state?.copyWith(),
      attachedModules: attachedModules is List<_i4.IoModule>?
          ? attachedModules
          : this.attachedModules?.map((e0) => e0.copyWith()).toList(),
      pins: pins is List<_i5.Pin>?
          ? pins
          : this.pins?.map((e0) => e0.copyWith()).toList(),
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }
}
