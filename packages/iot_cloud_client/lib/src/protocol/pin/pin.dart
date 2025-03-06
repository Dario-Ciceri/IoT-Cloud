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
import '../pin/pin_direction.dart' as _i3;
import '../pin/pin_type.dart' as _i4;
import '../pin/pin_state.dart' as _i5;

abstract class Pin implements _i1.SerializableModel {
  Pin._({
    this.id,
    required this.iotDeviceId,
    this.iotDevice,
    required this.name,
    required this.number,
    required this.direction,
    required this.properties,
    required this.stateId,
    this.state,
    required this.createdAt,
    required this.updatedAt,
  });

  factory Pin({
    int? id,
    required int iotDeviceId,
    _i2.IotDevice? iotDevice,
    required String name,
    required int number,
    required _i3.PinDirection direction,
    required List<_i4.PinProperty> properties,
    required int stateId,
    _i5.PinState? state,
    required DateTime createdAt,
    required DateTime updatedAt,
  }) = _PinImpl;

  factory Pin.fromJson(Map<String, dynamic> jsonSerialization) {
    return Pin(
      id: jsonSerialization['id'] as int?,
      iotDeviceId: jsonSerialization['iotDeviceId'] as int,
      iotDevice: jsonSerialization['iotDevice'] == null
          ? null
          : _i2.IotDevice.fromJson(
              (jsonSerialization['iotDevice'] as Map<String, dynamic>)),
      name: jsonSerialization['name'] as String,
      number: jsonSerialization['number'] as int,
      direction:
          _i3.PinDirection.fromJson((jsonSerialization['direction'] as int)),
      properties: (jsonSerialization['properties'] as List)
          .map((e) => _i4.PinProperty.fromJson((e as int)))
          .toList(),
      stateId: jsonSerialization['stateId'] as int,
      state: jsonSerialization['state'] == null
          ? null
          : _i5.PinState.fromJson(
              (jsonSerialization['state'] as Map<String, dynamic>)),
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

  String name;

  int number;

  _i3.PinDirection direction;

  List<_i4.PinProperty> properties;

  int stateId;

  _i5.PinState? state;

  DateTime createdAt;

  DateTime updatedAt;

  /// Returns a shallow copy of this [Pin]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  Pin copyWith({
    int? id,
    int? iotDeviceId,
    _i2.IotDevice? iotDevice,
    String? name,
    int? number,
    _i3.PinDirection? direction,
    List<_i4.PinProperty>? properties,
    int? stateId,
    _i5.PinState? state,
    DateTime? createdAt,
    DateTime? updatedAt,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      if (id != null) 'id': id,
      'iotDeviceId': iotDeviceId,
      if (iotDevice != null) 'iotDevice': iotDevice?.toJson(),
      'name': name,
      'number': number,
      'direction': direction.toJson(),
      'properties': properties.toJson(valueToJson: (v) => v.toJson()),
      'stateId': stateId,
      if (state != null) 'state': state?.toJson(),
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

class _PinImpl extends Pin {
  _PinImpl({
    int? id,
    required int iotDeviceId,
    _i2.IotDevice? iotDevice,
    required String name,
    required int number,
    required _i3.PinDirection direction,
    required List<_i4.PinProperty> properties,
    required int stateId,
    _i5.PinState? state,
    required DateTime createdAt,
    required DateTime updatedAt,
  }) : super._(
          id: id,
          iotDeviceId: iotDeviceId,
          iotDevice: iotDevice,
          name: name,
          number: number,
          direction: direction,
          properties: properties,
          stateId: stateId,
          state: state,
          createdAt: createdAt,
          updatedAt: updatedAt,
        );

  /// Returns a shallow copy of this [Pin]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  @override
  Pin copyWith({
    Object? id = _Undefined,
    int? iotDeviceId,
    Object? iotDevice = _Undefined,
    String? name,
    int? number,
    _i3.PinDirection? direction,
    List<_i4.PinProperty>? properties,
    int? stateId,
    Object? state = _Undefined,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) {
    return Pin(
      id: id is int? ? id : this.id,
      iotDeviceId: iotDeviceId ?? this.iotDeviceId,
      iotDevice:
          iotDevice is _i2.IotDevice? ? iotDevice : this.iotDevice?.copyWith(),
      name: name ?? this.name,
      number: number ?? this.number,
      direction: direction ?? this.direction,
      properties: properties ?? this.properties.map((e0) => e0).toList(),
      stateId: stateId ?? this.stateId,
      state: state is _i5.PinState? ? state : this.state?.copyWith(),
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }
}
