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
import 'example.dart' as _i2;
import 'exceptions/auth-exception.dart' as _i3;
import 'exceptions/cache-exception.dart' as _i4;
import 'exceptions/network-exception.dart' as _i5;
import 'exceptions/permission-exception.dart' as _i6;
import 'exceptions/server-exception.dart' as _i7;
import 'exceptions/unexpected-exception.dart' as _i8;
import 'exceptions/validation-exception.dart' as _i9;
import 'io_module/io_module.dart' as _i10;
import 'io_module/io_module_state.dart' as _i11;
import 'io_module/io_module_subtype.dart' as _i12;
import 'io_module/io_module_type.dart' as _i13;
import 'iot_device/iot_device.dart' as _i14;
import 'iot_device/iot_device_state.dart' as _i15;
import 'iot_device/iot_device_status.dart' as _i16;
import 'iot_device/iot_device_type.dart' as _i17;
import 'pin/pin.dart' as _i18;
import 'pin/pin_direction.dart' as _i19;
import 'pin/pin_state.dart' as _i20;
import 'pin/pin_type.dart' as _i21;
import 'platformio/platformio_board.dart' as _i22;
import 'platformio/platformio_build_result.dart' as _i23;
import 'platformio/platformio_device.dart' as _i24;
import 'platformio/platformio_file.dart' as _i25;
import 'platformio/platformio_library.dart' as _i26;
import 'platformio/platformio_platform.dart' as _i27;
import 'platformio/platformio_project.dart' as _i28;
import 'platformio/platformio_status.dart' as _i29;
import 'unit_type.dart' as _i30;
import 'url_mapping.dart' as _i31;
import 'package:iot_cloud_client/src/protocol/iot_device/iot_device.dart'
    as _i32;
import 'package:iot_cloud_client/src/protocol/platformio/platformio_project.dart'
    as _i33;
import 'package:iot_cloud_client/src/protocol/platformio/platformio_board.dart'
    as _i34;
import 'package:iot_cloud_client/src/protocol/platformio/platformio_device.dart'
    as _i35;
import 'package:iot_cloud_client/src/protocol/platformio/platformio_library.dart'
    as _i36;
import 'package:iot_cloud_client/src/protocol/platformio/platformio_platform.dart'
    as _i37;
import 'package:iot_cloud_client/src/protocol/platformio/platformio_file.dart'
    as _i38;
export 'example.dart';
export 'exceptions/auth-exception.dart';
export 'exceptions/cache-exception.dart';
export 'exceptions/network-exception.dart';
export 'exceptions/permission-exception.dart';
export 'exceptions/server-exception.dart';
export 'exceptions/unexpected-exception.dart';
export 'exceptions/validation-exception.dart';
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
export 'platformio/platformio_board.dart';
export 'platformio/platformio_build_result.dart';
export 'platformio/platformio_device.dart';
export 'platformio/platformio_file.dart';
export 'platformio/platformio_library.dart';
export 'platformio/platformio_platform.dart';
export 'platformio/platformio_project.dart';
export 'platformio/platformio_status.dart';
export 'unit_type.dart';
export 'url_mapping.dart';
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
    if (t == _i2.Example) {
      return _i2.Example.fromJson(data) as T;
    }
    if (t == _i3.AuthException) {
      return _i3.AuthException.fromJson(data) as T;
    }
    if (t == _i4.CacheException) {
      return _i4.CacheException.fromJson(data) as T;
    }
    if (t == _i5.NetworkException) {
      return _i5.NetworkException.fromJson(data) as T;
    }
    if (t == _i6.PermissionException) {
      return _i6.PermissionException.fromJson(data) as T;
    }
    if (t == _i7.ServerException) {
      return _i7.ServerException.fromJson(data) as T;
    }
    if (t == _i8.UnexpectedException) {
      return _i8.UnexpectedException.fromJson(data) as T;
    }
    if (t == _i9.ValidationException) {
      return _i9.ValidationException.fromJson(data) as T;
    }
    if (t == _i10.IoModule) {
      return _i10.IoModule.fromJson(data) as T;
    }
    if (t == _i11.IoModuleState) {
      return _i11.IoModuleState.fromJson(data) as T;
    }
    if (t == _i12.IoModuleSubType) {
      return _i12.IoModuleSubType.fromJson(data) as T;
    }
    if (t == _i13.IoModuleType) {
      return _i13.IoModuleType.fromJson(data) as T;
    }
    if (t == _i14.IotDevice) {
      return _i14.IotDevice.fromJson(data) as T;
    }
    if (t == _i15.IotDeviceState) {
      return _i15.IotDeviceState.fromJson(data) as T;
    }
    if (t == _i16.IotDeviceStatus) {
      return _i16.IotDeviceStatus.fromJson(data) as T;
    }
    if (t == _i17.IotDeviceType) {
      return _i17.IotDeviceType.fromJson(data) as T;
    }
    if (t == _i18.Pin) {
      return _i18.Pin.fromJson(data) as T;
    }
    if (t == _i19.PinDirection) {
      return _i19.PinDirection.fromJson(data) as T;
    }
    if (t == _i20.PinState) {
      return _i20.PinState.fromJson(data) as T;
    }
    if (t == _i21.PinProperty) {
      return _i21.PinProperty.fromJson(data) as T;
    }
    if (t == _i22.PlatformioBoard) {
      return _i22.PlatformioBoard.fromJson(data) as T;
    }
    if (t == _i23.PlatformioBuildResult) {
      return _i23.PlatformioBuildResult.fromJson(data) as T;
    }
    if (t == _i24.PlatformioDevice) {
      return _i24.PlatformioDevice.fromJson(data) as T;
    }
    if (t == _i25.PlatformioFile) {
      return _i25.PlatformioFile.fromJson(data) as T;
    }
    if (t == _i26.PlatformioLibrary) {
      return _i26.PlatformioLibrary.fromJson(data) as T;
    }
    if (t == _i27.PlatformioPlatform) {
      return _i27.PlatformioPlatform.fromJson(data) as T;
    }
    if (t == _i28.PlatformioProject) {
      return _i28.PlatformioProject.fromJson(data) as T;
    }
    if (t == _i29.PlatformioStatus) {
      return _i29.PlatformioStatus.fromJson(data) as T;
    }
    if (t == _i30.UnitType) {
      return _i30.UnitType.fromJson(data) as T;
    }
    if (t == _i31.UrlMapping) {
      return _i31.UrlMapping.fromJson(data) as T;
    }
    if (t == _i1.getType<_i2.Example?>()) {
      return (data != null ? _i2.Example.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i3.AuthException?>()) {
      return (data != null ? _i3.AuthException.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i4.CacheException?>()) {
      return (data != null ? _i4.CacheException.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i5.NetworkException?>()) {
      return (data != null ? _i5.NetworkException.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i6.PermissionException?>()) {
      return (data != null ? _i6.PermissionException.fromJson(data) : null)
          as T;
    }
    if (t == _i1.getType<_i7.ServerException?>()) {
      return (data != null ? _i7.ServerException.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i8.UnexpectedException?>()) {
      return (data != null ? _i8.UnexpectedException.fromJson(data) : null)
          as T;
    }
    if (t == _i1.getType<_i9.ValidationException?>()) {
      return (data != null ? _i9.ValidationException.fromJson(data) : null)
          as T;
    }
    if (t == _i1.getType<_i10.IoModule?>()) {
      return (data != null ? _i10.IoModule.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i11.IoModuleState?>()) {
      return (data != null ? _i11.IoModuleState.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i12.IoModuleSubType?>()) {
      return (data != null ? _i12.IoModuleSubType.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i13.IoModuleType?>()) {
      return (data != null ? _i13.IoModuleType.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i14.IotDevice?>()) {
      return (data != null ? _i14.IotDevice.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i15.IotDeviceState?>()) {
      return (data != null ? _i15.IotDeviceState.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i16.IotDeviceStatus?>()) {
      return (data != null ? _i16.IotDeviceStatus.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i17.IotDeviceType?>()) {
      return (data != null ? _i17.IotDeviceType.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i18.Pin?>()) {
      return (data != null ? _i18.Pin.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i19.PinDirection?>()) {
      return (data != null ? _i19.PinDirection.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i20.PinState?>()) {
      return (data != null ? _i20.PinState.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i21.PinProperty?>()) {
      return (data != null ? _i21.PinProperty.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i22.PlatformioBoard?>()) {
      return (data != null ? _i22.PlatformioBoard.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i23.PlatformioBuildResult?>()) {
      return (data != null ? _i23.PlatformioBuildResult.fromJson(data) : null)
          as T;
    }
    if (t == _i1.getType<_i24.PlatformioDevice?>()) {
      return (data != null ? _i24.PlatformioDevice.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i25.PlatformioFile?>()) {
      return (data != null ? _i25.PlatformioFile.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i26.PlatformioLibrary?>()) {
      return (data != null ? _i26.PlatformioLibrary.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i27.PlatformioPlatform?>()) {
      return (data != null ? _i27.PlatformioPlatform.fromJson(data) : null)
          as T;
    }
    if (t == _i1.getType<_i28.PlatformioProject?>()) {
      return (data != null ? _i28.PlatformioProject.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i29.PlatformioStatus?>()) {
      return (data != null ? _i29.PlatformioStatus.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i30.UnitType?>()) {
      return (data != null ? _i30.UnitType.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i31.UrlMapping?>()) {
      return (data != null ? _i31.UrlMapping.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<Map<String, List<String>>?>()) {
      return (data != null
          ? (data as Map).map((k, v) =>
              MapEntry(deserialize<String>(k), deserialize<List<String>>(v)))
          : null) as T;
    }
    if (t == List<String>) {
      return (data as List).map((e) => deserialize<String>(e)).toList() as T;
    }
    if (t == _i1.getType<List<_i10.IoModule>?>()) {
      return (data != null
          ? (data as List).map((e) => deserialize<_i10.IoModule>(e)).toList()
          : null) as T;
    }
    if (t == _i1.getType<List<_i18.Pin>?>()) {
      return (data != null
          ? (data as List).map((e) => deserialize<_i18.Pin>(e)).toList()
          : null) as T;
    }
    if (t == List<_i21.PinProperty>) {
      return (data as List)
          .map((e) => deserialize<_i21.PinProperty>(e))
          .toList() as T;
    }
    if (t == List<_i32.IotDevice>) {
      return (data as List).map((e) => deserialize<_i32.IotDevice>(e)).toList()
          as T;
    }
    if (t == List<_i33.PlatformioProject>) {
      return (data as List)
          .map((e) => deserialize<_i33.PlatformioProject>(e))
          .toList() as T;
    }
    if (t == List<_i34.PlatformioBoard>) {
      return (data as List)
          .map((e) => deserialize<_i34.PlatformioBoard>(e))
          .toList() as T;
    }
    if (t == List<_i35.PlatformioDevice>) {
      return (data as List)
          .map((e) => deserialize<_i35.PlatformioDevice>(e))
          .toList() as T;
    }
    if (t == List<_i36.PlatformioLibrary>) {
      return (data as List)
          .map((e) => deserialize<_i36.PlatformioLibrary>(e))
          .toList() as T;
    }
    if (t == List<String>) {
      return (data as List).map((e) => deserialize<String>(e)).toList() as T;
    }
    if (t == List<_i37.PlatformioPlatform>) {
      return (data as List)
          .map((e) => deserialize<_i37.PlatformioPlatform>(e))
          .toList() as T;
    }
    if (t == Map<String, String>) {
      return (data as Map).map((k, v) =>
          MapEntry(deserialize<String>(k), deserialize<String>(v))) as T;
    }
    if (t == List<_i38.PlatformioFile>) {
      return (data as List)
          .map((e) => deserialize<_i38.PlatformioFile>(e))
          .toList() as T;
    }
    return super.deserialize<T>(data, t);
  }

  @override
  String? getClassNameForObject(Object? data) {
    String? className = super.getClassNameForObject(data);
    if (className != null) return className;
    if (data is _i2.Example) {
      return 'Example';
    }
    if (data is _i3.AuthException) {
      return 'AuthException';
    }
    if (data is _i4.CacheException) {
      return 'CacheException';
    }
    if (data is _i5.NetworkException) {
      return 'NetworkException';
    }
    if (data is _i6.PermissionException) {
      return 'PermissionException';
    }
    if (data is _i7.ServerException) {
      return 'ServerException';
    }
    if (data is _i8.UnexpectedException) {
      return 'UnexpectedException';
    }
    if (data is _i9.ValidationException) {
      return 'ValidationException';
    }
    if (data is _i10.IoModule) {
      return 'IoModule';
    }
    if (data is _i11.IoModuleState) {
      return 'IoModuleState';
    }
    if (data is _i12.IoModuleSubType) {
      return 'IoModuleSubType';
    }
    if (data is _i13.IoModuleType) {
      return 'IoModuleType';
    }
    if (data is _i14.IotDevice) {
      return 'IotDevice';
    }
    if (data is _i15.IotDeviceState) {
      return 'IotDeviceState';
    }
    if (data is _i16.IotDeviceStatus) {
      return 'IotDeviceStatus';
    }
    if (data is _i17.IotDeviceType) {
      return 'IotDeviceType';
    }
    if (data is _i18.Pin) {
      return 'Pin';
    }
    if (data is _i19.PinDirection) {
      return 'PinDirection';
    }
    if (data is _i20.PinState) {
      return 'PinState';
    }
    if (data is _i21.PinProperty) {
      return 'PinProperty';
    }
    if (data is _i22.PlatformioBoard) {
      return 'PlatformioBoard';
    }
    if (data is _i23.PlatformioBuildResult) {
      return 'PlatformioBuildResult';
    }
    if (data is _i24.PlatformioDevice) {
      return 'PlatformioDevice';
    }
    if (data is _i25.PlatformioFile) {
      return 'PlatformioFile';
    }
    if (data is _i26.PlatformioLibrary) {
      return 'PlatformioLibrary';
    }
    if (data is _i27.PlatformioPlatform) {
      return 'PlatformioPlatform';
    }
    if (data is _i28.PlatformioProject) {
      return 'PlatformioProject';
    }
    if (data is _i29.PlatformioStatus) {
      return 'PlatformioStatus';
    }
    if (data is _i30.UnitType) {
      return 'UnitType';
    }
    if (data is _i31.UrlMapping) {
      return 'UrlMapping';
    }
    return null;
  }

  @override
  dynamic deserializeByClassName(Map<String, dynamic> data) {
    var dataClassName = data['className'];
    if (dataClassName is! String) {
      return super.deserializeByClassName(data);
    }
    if (dataClassName == 'Example') {
      return deserialize<_i2.Example>(data['data']);
    }
    if (dataClassName == 'AuthException') {
      return deserialize<_i3.AuthException>(data['data']);
    }
    if (dataClassName == 'CacheException') {
      return deserialize<_i4.CacheException>(data['data']);
    }
    if (dataClassName == 'NetworkException') {
      return deserialize<_i5.NetworkException>(data['data']);
    }
    if (dataClassName == 'PermissionException') {
      return deserialize<_i6.PermissionException>(data['data']);
    }
    if (dataClassName == 'ServerException') {
      return deserialize<_i7.ServerException>(data['data']);
    }
    if (dataClassName == 'UnexpectedException') {
      return deserialize<_i8.UnexpectedException>(data['data']);
    }
    if (dataClassName == 'ValidationException') {
      return deserialize<_i9.ValidationException>(data['data']);
    }
    if (dataClassName == 'IoModule') {
      return deserialize<_i10.IoModule>(data['data']);
    }
    if (dataClassName == 'IoModuleState') {
      return deserialize<_i11.IoModuleState>(data['data']);
    }
    if (dataClassName == 'IoModuleSubType') {
      return deserialize<_i12.IoModuleSubType>(data['data']);
    }
    if (dataClassName == 'IoModuleType') {
      return deserialize<_i13.IoModuleType>(data['data']);
    }
    if (dataClassName == 'IotDevice') {
      return deserialize<_i14.IotDevice>(data['data']);
    }
    if (dataClassName == 'IotDeviceState') {
      return deserialize<_i15.IotDeviceState>(data['data']);
    }
    if (dataClassName == 'IotDeviceStatus') {
      return deserialize<_i16.IotDeviceStatus>(data['data']);
    }
    if (dataClassName == 'IotDeviceType') {
      return deserialize<_i17.IotDeviceType>(data['data']);
    }
    if (dataClassName == 'Pin') {
      return deserialize<_i18.Pin>(data['data']);
    }
    if (dataClassName == 'PinDirection') {
      return deserialize<_i19.PinDirection>(data['data']);
    }
    if (dataClassName == 'PinState') {
      return deserialize<_i20.PinState>(data['data']);
    }
    if (dataClassName == 'PinProperty') {
      return deserialize<_i21.PinProperty>(data['data']);
    }
    if (dataClassName == 'PlatformioBoard') {
      return deserialize<_i22.PlatformioBoard>(data['data']);
    }
    if (dataClassName == 'PlatformioBuildResult') {
      return deserialize<_i23.PlatformioBuildResult>(data['data']);
    }
    if (dataClassName == 'PlatformioDevice') {
      return deserialize<_i24.PlatformioDevice>(data['data']);
    }
    if (dataClassName == 'PlatformioFile') {
      return deserialize<_i25.PlatformioFile>(data['data']);
    }
    if (dataClassName == 'PlatformioLibrary') {
      return deserialize<_i26.PlatformioLibrary>(data['data']);
    }
    if (dataClassName == 'PlatformioPlatform') {
      return deserialize<_i27.PlatformioPlatform>(data['data']);
    }
    if (dataClassName == 'PlatformioProject') {
      return deserialize<_i28.PlatformioProject>(data['data']);
    }
    if (dataClassName == 'PlatformioStatus') {
      return deserialize<_i29.PlatformioStatus>(data['data']);
    }
    if (dataClassName == 'UnitType') {
      return deserialize<_i30.UnitType>(data['data']);
    }
    if (dataClassName == 'UrlMapping') {
      return deserialize<_i31.UrlMapping>(data['data']);
    }
    return super.deserializeByClassName(data);
  }
}
