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
import '../iot_device/iot_device_status.dart' as _i2;
import '../iot_device/iot_device_hw_state.dart' as _i3;

abstract class IotDeviceState implements _i1.SerializableModel {
  IotDeviceState._({
    required this.status,
    this.hwState,
  });

  factory IotDeviceState({
    required _i2.IotDeviceStatus status,
    _i3.IotDeviceHwState? hwState,
  }) = _IotDeviceStateImpl;

  factory IotDeviceState.fromJson(Map<String, dynamic> jsonSerialization) {
    return IotDeviceState(
      status:
          _i2.IotDeviceStatus.fromJson((jsonSerialization['status'] as int)),
      hwState: jsonSerialization['hwState'] == null
          ? null
          : _i3.IotDeviceHwState.fromJson(
              (jsonSerialization['hwState'] as Map<String, dynamic>)),
    );
  }

  _i2.IotDeviceStatus status;

  _i3.IotDeviceHwState? hwState;

  IotDeviceState copyWith({
    _i2.IotDeviceStatus? status,
    _i3.IotDeviceHwState? hwState,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      'status': status.toJson(),
      if (hwState != null) 'hwState': hwState?.toJson(),
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
    required _i2.IotDeviceStatus status,
    _i3.IotDeviceHwState? hwState,
  }) : super._(
          status: status,
          hwState: hwState,
        );

  @override
  IotDeviceState copyWith({
    _i2.IotDeviceStatus? status,
    Object? hwState = _Undefined,
  }) {
    return IotDeviceState(
      status: status ?? this.status,
      hwState:
          hwState is _i3.IotDeviceHwState? ? hwState : this.hwState?.copyWith(),
    );
  }
}
