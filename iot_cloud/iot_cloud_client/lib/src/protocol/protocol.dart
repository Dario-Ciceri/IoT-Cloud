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
import 'io_module/io_module.dart' as _i2;
import 'io_module/io_module_state.dart' as _i3;
import 'io_module/io_module_subtype.dart' as _i4;
import 'io_module/io_module_type.dart' as _i5;
import 'iot_device/iot_device.dart' as _i6;
import 'iot_device/iot_device_state.dart' as _i7;
import 'iot_device/iot_device_status.dart' as _i8;
import 'iot_device/iot_device_type.dart' as _i9;
import 'pin/pin.dart' as _i10;
import 'pin/pin_direction.dart' as _i11;
import 'pin/pin_state.dart' as _i12;
import 'pin/pin_type.dart' as _i13;
import 'unit_type.dart' as _i14;
export 'io_module/io_module.dart';
export 'io_module/io_module_state.dart';
export 'io_module/io_module_subtype.dart';
export 'io_module/io_module_type.dart';
export 'iot_device/iot_device.dart';
export 'iot_device/iot_device_state.dart';
export 'iot_device/iot_device_status.dart';
export 'iot_device/iot_device_type.dart';
export 'pin/pin.dart';
export 'pin/pin_direction.dart';
export 'pin/pin_state.dart';
export 'pin/pin_type.dart';
export 'unit_type.dart';
export 'client.dart';

class Protocol extends _i1.SerializationManager {
  Protocol._();

  factory Protocol() => _instance;

  static final Protocol _instance = Protocol._();

  @override
  T deserialize<T>(
    dynamic data, [
    Type? t,
  ]) {
    t ??= T;
    if (t == _i2.IoModule) {
      return _i2.IoModule.fromJson(data) as T;
    }
    if (t == _i3.IoModuleState) {
      return _i3.IoModuleState.fromJson(data) as T;
    }
    if (t == _i4.IoModuleSubType) {
      return _i4.IoModuleSubType.fromJson(data) as T;
    }
    if (t == _i5.IoModuleType) {
      return _i5.IoModuleType.fromJson(data) as T;
    }
    if (t == _i6.IotDevice) {
      return _i6.IotDevice.fromJson(data) as T;
    }
    if (t == _i7.IotDeviceState) {
      return _i7.IotDeviceState.fromJson(data) as T;
    }
    if (t == _i8.IotDeviceStatus) {
      return _i8.IotDeviceStatus.fromJson(data) as T;
    }
    if (t == _i9.IotDeviceType) {
      return _i9.IotDeviceType.fromJson(data) as T;
    }
    if (t == _i10.Pin) {
      return _i10.Pin.fromJson(data) as T;
    }
    if (t == _i11.PinDirection) {
      return _i11.PinDirection.fromJson(data) as T;
    }
    if (t == _i12.PinState) {
      return _i12.PinState.fromJson(data) as T;
    }
    if (t == _i13.PinProperty) {
      return _i13.PinProperty.fromJson(data) as T;
    }
    if (t == _i14.UnitType) {
      return _i14.UnitType.fromJson(data) as T;
    }
    if (t == _i1.getType<_i2.IoModule?>()) {
      return (data != null ? _i2.IoModule.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i3.IoModuleState?>()) {
      return (data != null ? _i3.IoModuleState.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i4.IoModuleSubType?>()) {
      return (data != null ? _i4.IoModuleSubType.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i5.IoModuleType?>()) {
      return (data != null ? _i5.IoModuleType.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i6.IotDevice?>()) {
      return (data != null ? _i6.IotDevice.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i7.IotDeviceState?>()) {
      return (data != null ? _i7.IotDeviceState.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i8.IotDeviceStatus?>()) {
      return (data != null ? _i8.IotDeviceStatus.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i9.IotDeviceType?>()) {
      return (data != null ? _i9.IotDeviceType.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i10.Pin?>()) {
      return (data != null ? _i10.Pin.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i11.PinDirection?>()) {
      return (data != null ? _i11.PinDirection.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i12.PinState?>()) {
      return (data != null ? _i12.PinState.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i13.PinProperty?>()) {
      return (data != null ? _i13.PinProperty.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i14.UnitType?>()) {
      return (data != null ? _i14.UnitType.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<List<_i2.IoModule>?>()) {
      return (data != null
          ? (data as List).map((e) => deserialize<_i2.IoModule>(e)).toList()
          : null) as dynamic;
    }
    if (t == _i1.getType<List<_i10.Pin>?>()) {
      return (data != null
          ? (data as List).map((e) => deserialize<_i10.Pin>(e)).toList()
          : null) as dynamic;
    }
    if (t == List<_i13.PinProperty>) {
      return (data as List)
          .map((e) => deserialize<_i13.PinProperty>(e))
          .toList() as dynamic;
    }
    return super.deserialize<T>(data, t);
  }

  @override
  String? getClassNameForObject(Object? data) {
    String? className = super.getClassNameForObject(data);
    if (className != null) return className;
    if (data is _i2.IoModule) {
      return 'IoModule';
    }
    if (data is _i3.IoModuleState) {
      return 'IoModuleState';
    }
    if (data is _i4.IoModuleSubType) {
      return 'IoModuleSubType';
    }
    if (data is _i5.IoModuleType) {
      return 'IoModuleType';
    }
    if (data is _i6.IotDevice) {
      return 'IotDevice';
    }
    if (data is _i7.IotDeviceState) {
      return 'IotDeviceState';
    }
    if (data is _i8.IotDeviceStatus) {
      return 'IotDeviceStatus';
    }
    if (data is _i9.IotDeviceType) {
      return 'IotDeviceType';
    }
    if (data is _i10.Pin) {
      return 'Pin';
    }
    if (data is _i11.PinDirection) {
      return 'PinDirection';
    }
    if (data is _i12.PinState) {
      return 'PinState';
    }
    if (data is _i13.PinProperty) {
      return 'PinProperty';
    }
    if (data is _i14.UnitType) {
      return 'UnitType';
    }
    return null;
  }

  @override
  dynamic deserializeByClassName(Map<String, dynamic> data) {
    var dataClassName = data['className'];
    if (dataClassName is! String) {
      return super.deserializeByClassName(data);
    }
    if (dataClassName == 'IoModule') {
      return deserialize<_i2.IoModule>(data['data']);
    }
    if (dataClassName == 'IoModuleState') {
      return deserialize<_i3.IoModuleState>(data['data']);
    }
    if (dataClassName == 'IoModuleSubType') {
      return deserialize<_i4.IoModuleSubType>(data['data']);
    }
    if (dataClassName == 'IoModuleType') {
      return deserialize<_i5.IoModuleType>(data['data']);
    }
    if (dataClassName == 'IotDevice') {
      return deserialize<_i6.IotDevice>(data['data']);
    }
    if (dataClassName == 'IotDeviceState') {
      return deserialize<_i7.IotDeviceState>(data['data']);
    }
    if (dataClassName == 'IotDeviceStatus') {
      return deserialize<_i8.IotDeviceStatus>(data['data']);
    }
    if (dataClassName == 'IotDeviceType') {
      return deserialize<_i9.IotDeviceType>(data['data']);
    }
    if (dataClassName == 'Pin') {
      return deserialize<_i10.Pin>(data['data']);
    }
    if (dataClassName == 'PinDirection') {
      return deserialize<_i11.PinDirection>(data['data']);
    }
    if (dataClassName == 'PinState') {
      return deserialize<_i12.PinState>(data['data']);
    }
    if (dataClassName == 'PinProperty') {
      return deserialize<_i13.PinProperty>(data['data']);
    }
    if (dataClassName == 'UnitType') {
      return deserialize<_i14.UnitType>(data['data']);
    }
    return super.deserializeByClassName(data);
  }
}
