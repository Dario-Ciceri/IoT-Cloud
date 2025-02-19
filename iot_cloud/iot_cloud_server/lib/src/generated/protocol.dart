/* AUTOMATICALLY GENERATED CODE DO NOT MODIFY */
/*   To generate run: "serverpod generate"    */

// ignore_for_file: implementation_imports
// ignore_for_file: library_private_types_in_public_api
// ignore_for_file: non_constant_identifier_names
// ignore_for_file: public_member_api_docs
// ignore_for_file: type_literal_in_constant_pattern
// ignore_for_file: use_super_parameters

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:serverpod/serverpod.dart' as _i1;
import 'package:serverpod/protocol.dart' as _i2;
import 'io_module/io_module.dart' as _i3;
import 'io_module/io_module_info.dart' as _i4;
import 'io_module/io_module_state.dart' as _i5;
import 'io_module/io_module_subtype.dart' as _i6;
import 'io_module/io_module_type.dart' as _i7;
import 'iot_device/iot_device.dart' as _i8;
import 'iot_device/iot_device_hw_state.dart' as _i9;
import 'iot_device/iot_device_info.dart' as _i10;
import 'iot_device/iot_device_state.dart' as _i11;
import 'iot_device/iot_device_status.dart' as _i12;
import 'iot_device/iot_device_type.dart' as _i13;
import 'pin/pin.dart' as _i14;
import 'pin/pin_direction.dart' as _i15;
import 'pin/pin_info.dart' as _i16;
import 'pin/pin_type.dart' as _i17;
import 'unit_type.dart' as _i18;
export 'io_module/io_module.dart';
export 'io_module/io_module_info.dart';
export 'io_module/io_module_state.dart';
export 'io_module/io_module_subtype.dart';
export 'io_module/io_module_type.dart';
export 'iot_device/iot_device.dart';
export 'iot_device/iot_device_hw_state.dart';
export 'iot_device/iot_device_info.dart';
export 'iot_device/iot_device_state.dart';
export 'iot_device/iot_device_status.dart';
export 'iot_device/iot_device_type.dart';
export 'pin/pin.dart';
export 'pin/pin_direction.dart';
export 'pin/pin_info.dart';
export 'pin/pin_type.dart';
export 'unit_type.dart';

class Protocol extends _i1.SerializationManagerServer {
  Protocol._();

  factory Protocol() => _instance;

  static final Protocol _instance = Protocol._();

  static final List<_i2.TableDefinition> targetTableDefinitions = [
    _i2.TableDefinition(
      name: 'iot_device',
      dartName: 'IotDevice',
      schema: 'public',
      module: 'iot_cloud',
      columns: [
        _i2.ColumnDefinition(
          name: 'id',
          columnType: _i2.ColumnType.bigint,
          isNullable: false,
          dartType: 'int?',
          columnDefault: 'nextval(\'iot_device_id_seq\'::regclass)',
        ),
        _i2.ColumnDefinition(
          name: 'info',
          columnType: _i2.ColumnType.json,
          isNullable: false,
          dartType: 'protocol:IotDeviceInfo',
        ),
        _i2.ColumnDefinition(
          name: 'state',
          columnType: _i2.ColumnType.json,
          isNullable: false,
          dartType: 'protocol:IotDeviceState',
        ),
        _i2.ColumnDefinition(
          name: 'attachedModules',
          columnType: _i2.ColumnType.json,
          isNullable: false,
          dartType: 'List<protocol:IoModule>',
        ),
      ],
      foreignKeys: [],
      indexes: [
        _i2.IndexDefinition(
          indexName: 'iot_device_pkey',
          tableSpace: null,
          elements: [
            _i2.IndexElementDefinition(
              type: _i2.IndexElementDefinitionType.column,
              definition: 'id',
            )
          ],
          type: 'btree',
          isUnique: true,
          isPrimary: true,
        )
      ],
      managed: true,
    ),
    ..._i2.Protocol.targetTableDefinitions,
  ];

  @override
  T deserialize<T>(
    dynamic data, [
    Type? t,
  ]) {
    t ??= T;
    if (t == _i3.IoModule) {
      return _i3.IoModule.fromJson(data) as T;
    }
    if (t == _i4.IoModuleInfo) {
      return _i4.IoModuleInfo.fromJson(data) as T;
    }
    if (t == _i5.IoModuleState) {
      return _i5.IoModuleState.fromJson(data) as T;
    }
    if (t == _i6.IoModuleSubType) {
      return _i6.IoModuleSubType.fromJson(data) as T;
    }
    if (t == _i7.IoModuleType) {
      return _i7.IoModuleType.fromJson(data) as T;
    }
    if (t == _i8.IotDevice) {
      return _i8.IotDevice.fromJson(data) as T;
    }
    if (t == _i9.IotDeviceHwState) {
      return _i9.IotDeviceHwState.fromJson(data) as T;
    }
    if (t == _i10.IotDeviceInfo) {
      return _i10.IotDeviceInfo.fromJson(data) as T;
    }
    if (t == _i11.IotDeviceState) {
      return _i11.IotDeviceState.fromJson(data) as T;
    }
    if (t == _i12.IotDeviceStatus) {
      return _i12.IotDeviceStatus.fromJson(data) as T;
    }
    if (t == _i13.IotDeviceType) {
      return _i13.IotDeviceType.fromJson(data) as T;
    }
    if (t == _i14.Pin) {
      return _i14.Pin.fromJson(data) as T;
    }
    if (t == _i15.PinDirection) {
      return _i15.PinDirection.fromJson(data) as T;
    }
    if (t == _i16.PinInfo) {
      return _i16.PinInfo.fromJson(data) as T;
    }
    if (t == _i17.PinType) {
      return _i17.PinType.fromJson(data) as T;
    }
    if (t == _i18.UnitType) {
      return _i18.UnitType.fromJson(data) as T;
    }
    if (t == _i1.getType<_i3.IoModule?>()) {
      return (data != null ? _i3.IoModule.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i4.IoModuleInfo?>()) {
      return (data != null ? _i4.IoModuleInfo.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i5.IoModuleState?>()) {
      return (data != null ? _i5.IoModuleState.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i6.IoModuleSubType?>()) {
      return (data != null ? _i6.IoModuleSubType.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i7.IoModuleType?>()) {
      return (data != null ? _i7.IoModuleType.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i8.IotDevice?>()) {
      return (data != null ? _i8.IotDevice.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i9.IotDeviceHwState?>()) {
      return (data != null ? _i9.IotDeviceHwState.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i10.IotDeviceInfo?>()) {
      return (data != null ? _i10.IotDeviceInfo.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i11.IotDeviceState?>()) {
      return (data != null ? _i11.IotDeviceState.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i12.IotDeviceStatus?>()) {
      return (data != null ? _i12.IotDeviceStatus.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i13.IotDeviceType?>()) {
      return (data != null ? _i13.IotDeviceType.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i14.Pin?>()) {
      return (data != null ? _i14.Pin.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i15.PinDirection?>()) {
      return (data != null ? _i15.PinDirection.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i16.PinInfo?>()) {
      return (data != null ? _i16.PinInfo.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i17.PinType?>()) {
      return (data != null ? _i17.PinType.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i18.UnitType?>()) {
      return (data != null ? _i18.UnitType.fromJson(data) : null) as T;
    }
    if (t == List<_i3.IoModule>) {
      return (data as List).map((e) => deserialize<_i3.IoModule>(e)).toList()
          as dynamic;
    }
    try {
      return _i2.Protocol().deserialize<T>(data, t);
    } on _i1.DeserializationTypeNotFoundException catch (_) {}
    return super.deserialize<T>(data, t);
  }

  @override
  String? getClassNameForObject(Object? data) {
    String? className = super.getClassNameForObject(data);
    if (className != null) return className;
    if (data is _i3.IoModule) {
      return 'IoModule';
    }
    if (data is _i4.IoModuleInfo) {
      return 'IoModuleInfo';
    }
    if (data is _i5.IoModuleState) {
      return 'IoModuleState';
    }
    if (data is _i6.IoModuleSubType) {
      return 'IoModuleSubType';
    }
    if (data is _i7.IoModuleType) {
      return 'IoModuleType';
    }
    if (data is _i8.IotDevice) {
      return 'IotDevice';
    }
    if (data is _i9.IotDeviceHwState) {
      return 'IotDeviceHwState';
    }
    if (data is _i10.IotDeviceInfo) {
      return 'IotDeviceInfo';
    }
    if (data is _i11.IotDeviceState) {
      return 'IotDeviceState';
    }
    if (data is _i12.IotDeviceStatus) {
      return 'IotDeviceStatus';
    }
    if (data is _i13.IotDeviceType) {
      return 'IotDeviceType';
    }
    if (data is _i14.Pin) {
      return 'Pin';
    }
    if (data is _i15.PinDirection) {
      return 'PinDirection';
    }
    if (data is _i16.PinInfo) {
      return 'PinInfo';
    }
    if (data is _i17.PinType) {
      return 'PinType';
    }
    if (data is _i18.UnitType) {
      return 'UnitType';
    }
    className = _i2.Protocol().getClassNameForObject(data);
    if (className != null) {
      return 'serverpod.$className';
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
      return deserialize<_i3.IoModule>(data['data']);
    }
    if (dataClassName == 'IoModuleInfo') {
      return deserialize<_i4.IoModuleInfo>(data['data']);
    }
    if (dataClassName == 'IoModuleState') {
      return deserialize<_i5.IoModuleState>(data['data']);
    }
    if (dataClassName == 'IoModuleSubType') {
      return deserialize<_i6.IoModuleSubType>(data['data']);
    }
    if (dataClassName == 'IoModuleType') {
      return deserialize<_i7.IoModuleType>(data['data']);
    }
    if (dataClassName == 'IotDevice') {
      return deserialize<_i8.IotDevice>(data['data']);
    }
    if (dataClassName == 'IotDeviceHwState') {
      return deserialize<_i9.IotDeviceHwState>(data['data']);
    }
    if (dataClassName == 'IotDeviceInfo') {
      return deserialize<_i10.IotDeviceInfo>(data['data']);
    }
    if (dataClassName == 'IotDeviceState') {
      return deserialize<_i11.IotDeviceState>(data['data']);
    }
    if (dataClassName == 'IotDeviceStatus') {
      return deserialize<_i12.IotDeviceStatus>(data['data']);
    }
    if (dataClassName == 'IotDeviceType') {
      return deserialize<_i13.IotDeviceType>(data['data']);
    }
    if (dataClassName == 'Pin') {
      return deserialize<_i14.Pin>(data['data']);
    }
    if (dataClassName == 'PinDirection') {
      return deserialize<_i15.PinDirection>(data['data']);
    }
    if (dataClassName == 'PinInfo') {
      return deserialize<_i16.PinInfo>(data['data']);
    }
    if (dataClassName == 'PinType') {
      return deserialize<_i17.PinType>(data['data']);
    }
    if (dataClassName == 'UnitType') {
      return deserialize<_i18.UnitType>(data['data']);
    }
    if (dataClassName.startsWith('serverpod.')) {
      data['className'] = dataClassName.substring(10);
      return _i2.Protocol().deserializeByClassName(data);
    }
    return super.deserializeByClassName(data);
  }

  @override
  _i1.Table? getTableForType(Type t) {
    {
      var table = _i2.Protocol().getTableForType(t);
      if (table != null) {
        return table;
      }
    }
    switch (t) {
      case _i8.IotDevice:
        return _i8.IotDevice.t;
    }
    return null;
  }

  @override
  List<_i2.TableDefinition> getTargetTableDefinitions() =>
      targetTableDefinitions;

  @override
  String getModuleName() => 'iot_cloud';
}
