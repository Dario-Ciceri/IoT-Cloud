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
import '../iot_device/iot_device_status.dart' as _i3;

abstract class IotDeviceState implements _i1.SerializableModel {
  IotDeviceState._({
    this.id,
    this.iotDevice,
    required this.status,
    required this.cpuLoad,
    required this.temp,
    required this.mem,
    required this.heartBeat,
    required this.createdAt,
    required this.updatedAt,
  });

  factory IotDeviceState({
    int? id,
    _i2.IotDevice? iotDevice,
    required _i3.IotDeviceStatus status,
    required int cpuLoad,
    required double temp,
    required double mem,
    required DateTime heartBeat,
    required DateTime createdAt,
    required DateTime updatedAt,
  }) = _IotDeviceStateImpl;

  factory IotDeviceState.fromJson(Map<String, dynamic> jsonSerialization) {
    return IotDeviceState(
      id: jsonSerialization['id'] as int?,
      iotDevice: jsonSerialization['iotDevice'] == null
          ? null
          : _i2.IotDevice.fromJson(
              (jsonSerialization['iotDevice'] as Map<String, dynamic>)),
      status:
          _i3.IotDeviceStatus.fromJson((jsonSerialization['status'] as int)),
      cpuLoad: jsonSerialization['cpuLoad'] as int,
      temp: (jsonSerialization['temp'] as num).toDouble(),
      mem: (jsonSerialization['mem'] as num).toDouble(),
      heartBeat:
          _i1.DateTimeJsonExtension.fromJson(jsonSerialization['heartBeat']),
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

  _i2.IotDevice? iotDevice;

  _i3.IotDeviceStatus status;

  int cpuLoad;

  double temp;

  double mem;

  DateTime heartBeat;

  DateTime createdAt;

  DateTime updatedAt;

  /// Returns a shallow copy of this [IotDeviceState]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  IotDeviceState copyWith({
    int? id,
    _i2.IotDevice? iotDevice,
    _i3.IotDeviceStatus? status,
    int? cpuLoad,
    double? temp,
    double? mem,
    DateTime? heartBeat,
    DateTime? createdAt,
    DateTime? updatedAt,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      if (id != null) 'id': id,
      if (iotDevice != null) 'iotDevice': iotDevice?.toJson(),
      'status': status.toJson(),
      'cpuLoad': cpuLoad,
      'temp': temp,
      'mem': mem,
      'heartBeat': heartBeat.toJson(),
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

class _IotDeviceStateImpl extends IotDeviceState {
  _IotDeviceStateImpl({
    int? id,
    _i2.IotDevice? iotDevice,
    required _i3.IotDeviceStatus status,
    required int cpuLoad,
    required double temp,
    required double mem,
    required DateTime heartBeat,
    required DateTime createdAt,
    required DateTime updatedAt,
  }) : super._(
          id: id,
          iotDevice: iotDevice,
          status: status,
          cpuLoad: cpuLoad,
          temp: temp,
          mem: mem,
          heartBeat: heartBeat,
          createdAt: createdAt,
          updatedAt: updatedAt,
        );

  /// Returns a shallow copy of this [IotDeviceState]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  @override
  IotDeviceState copyWith({
    Object? id = _Undefined,
    Object? iotDevice = _Undefined,
    _i3.IotDeviceStatus? status,
    int? cpuLoad,
    double? temp,
    double? mem,
    DateTime? heartBeat,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) {
    return IotDeviceState(
      id: id is int? ? id : this.id,
      iotDevice:
          iotDevice is _i2.IotDevice? ? iotDevice : this.iotDevice?.copyWith(),
      status: status ?? this.status,
      cpuLoad: cpuLoad ?? this.cpuLoad,
      temp: temp ?? this.temp,
      mem: mem ?? this.mem,
      heartBeat: heartBeat ?? this.heartBeat,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }
}
