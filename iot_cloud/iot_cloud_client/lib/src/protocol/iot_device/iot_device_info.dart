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

abstract class IotDeviceInfo implements _i1.SerializableModel {
  IotDeviceInfo._({
    required this.serialId,
    required this.type,
    required this.name,
    required this.fwVersion,
    required this.heartBeat,
  });

  factory IotDeviceInfo({
    required String serialId,
    required _i2.IotDeviceType type,
    required String name,
    required String fwVersion,
    required DateTime heartBeat,
  }) = _IotDeviceInfoImpl;

  factory IotDeviceInfo.fromJson(Map<String, dynamic> jsonSerialization) {
    return IotDeviceInfo(
      serialId: jsonSerialization['serialId'] as String,
      type: _i2.IotDeviceType.fromJson((jsonSerialization['type'] as int)),
      name: jsonSerialization['name'] as String,
      fwVersion: jsonSerialization['fwVersion'] as String,
      heartBeat:
          _i1.DateTimeJsonExtension.fromJson(jsonSerialization['heartBeat']),
    );
  }

  String serialId;

  _i2.IotDeviceType type;

  String name;

  String fwVersion;

  DateTime heartBeat;

  IotDeviceInfo copyWith({
    String? serialId,
    _i2.IotDeviceType? type,
    String? name,
    String? fwVersion,
    DateTime? heartBeat,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      'serialId': serialId,
      'type': type.toJson(),
      'name': name,
      'fwVersion': fwVersion,
      'heartBeat': heartBeat.toJson(),
    };
  }

  @override
  String toString() {
    return _i1.SerializationManager.encode(this);
  }
}

class _IotDeviceInfoImpl extends IotDeviceInfo {
  _IotDeviceInfoImpl({
    required String serialId,
    required _i2.IotDeviceType type,
    required String name,
    required String fwVersion,
    required DateTime heartBeat,
  }) : super._(
          serialId: serialId,
          type: type,
          name: name,
          fwVersion: fwVersion,
          heartBeat: heartBeat,
        );

  @override
  IotDeviceInfo copyWith({
    String? serialId,
    _i2.IotDeviceType? type,
    String? name,
    String? fwVersion,
    DateTime? heartBeat,
  }) {
    return IotDeviceInfo(
      serialId: serialId ?? this.serialId,
      type: type ?? this.type,
      name: name ?? this.name,
      fwVersion: fwVersion ?? this.fwVersion,
      heartBeat: heartBeat ?? this.heartBeat,
    );
  }
}
