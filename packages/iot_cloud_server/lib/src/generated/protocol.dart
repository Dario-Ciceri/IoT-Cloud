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
import 'io_module/io_module_state.dart' as _i4;
import 'io_module/io_module_subtype.dart' as _i5;
import 'io_module/io_module_type.dart' as _i6;
import 'iot_device/iot_device.dart' as _i7;
import 'iot_device/iot_device_state.dart' as _i8;
import 'iot_device/iot_device_status.dart' as _i9;
import 'iot_device/iot_device_type.dart' as _i10;
import 'pin/pin.dart' as _i11;
import 'pin/pin_direction.dart' as _i12;
import 'pin/pin_state.dart' as _i13;
import 'pin/pin_type.dart' as _i14;
import 'unit_type.dart' as _i15;
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

class Protocol extends _i1.SerializationManagerServer {
  Protocol._();

  factory Protocol() => _instance;

  static final Protocol _instance = Protocol._();

  static final List<_i2.TableDefinition> targetTableDefinitions = [
    _i2.TableDefinition(
      name: 'io_module',
      dartName: 'IoModule',
      schema: 'public',
      module: 'iot_cloud',
      columns: [
        _i2.ColumnDefinition(
          name: 'id',
          columnType: _i2.ColumnType.bigint,
          isNullable: false,
          dartType: 'int?',
          columnDefault: 'nextval(\'io_module_id_seq\'::regclass)',
        ),
        _i2.ColumnDefinition(
          name: 'iotDeviceId',
          columnType: _i2.ColumnType.bigint,
          isNullable: false,
          dartType: 'int',
        ),
        _i2.ColumnDefinition(
          name: 'stateId',
          columnType: _i2.ColumnType.bigint,
          isNullable: false,
          dartType: 'int',
        ),
        _i2.ColumnDefinition(
          name: 'serialId',
          columnType: _i2.ColumnType.text,
          isNullable: false,
          dartType: 'String',
        ),
        _i2.ColumnDefinition(
          name: 'name',
          columnType: _i2.ColumnType.text,
          isNullable: false,
          dartType: 'String',
        ),
        _i2.ColumnDefinition(
          name: 'type',
          columnType: _i2.ColumnType.bigint,
          isNullable: false,
          dartType: 'protocol:IoModuleType',
        ),
        _i2.ColumnDefinition(
          name: 'subtype',
          columnType: _i2.ColumnType.bigint,
          isNullable: false,
          dartType: 'protocol:IoModuleSubType',
        ),
        _i2.ColumnDefinition(
          name: 'createdAt',
          columnType: _i2.ColumnType.timestampWithoutTimeZone,
          isNullable: false,
          dartType: 'DateTime',
        ),
        _i2.ColumnDefinition(
          name: 'updatedAt',
          columnType: _i2.ColumnType.timestampWithoutTimeZone,
          isNullable: false,
          dartType: 'DateTime',
        ),
      ],
      foreignKeys: [
        _i2.ForeignKeyDefinition(
          constraintName: 'io_module_fk_0',
          columns: ['iotDeviceId'],
          referenceTable: 'iot_device',
          referenceTableSchema: 'public',
          referenceColumns: ['id'],
          onUpdate: _i2.ForeignKeyAction.noAction,
          onDelete: _i2.ForeignKeyAction.noAction,
          matchType: null,
        ),
        _i2.ForeignKeyDefinition(
          constraintName: 'io_module_fk_1',
          columns: ['stateId'],
          referenceTable: 'io_module_state',
          referenceTableSchema: 'public',
          referenceColumns: ['id'],
          onUpdate: _i2.ForeignKeyAction.noAction,
          onDelete: _i2.ForeignKeyAction.noAction,
          matchType: null,
        ),
      ],
      indexes: [
        _i2.IndexDefinition(
          indexName: 'io_module_pkey',
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
        ),
        _i2.IndexDefinition(
          indexName: 'io_module_state_unique_idx',
          tableSpace: null,
          elements: [
            _i2.IndexElementDefinition(
              type: _i2.IndexElementDefinitionType.column,
              definition: 'stateId',
            )
          ],
          type: 'btree',
          isUnique: true,
          isPrimary: false,
        ),
      ],
      managed: true,
    ),
    _i2.TableDefinition(
      name: 'io_module_state',
      dartName: 'IoModuleState',
      schema: 'public',
      module: 'iot_cloud',
      columns: [
        _i2.ColumnDefinition(
          name: 'id',
          columnType: _i2.ColumnType.bigint,
          isNullable: false,
          dartType: 'int?',
          columnDefault: 'nextval(\'io_module_state_id_seq\'::regclass)',
        ),
        _i2.ColumnDefinition(
          name: 'value',
          columnType: _i2.ColumnType.text,
          isNullable: false,
          dartType: 'String',
        ),
        _i2.ColumnDefinition(
          name: 'unit',
          columnType: _i2.ColumnType.bigint,
          isNullable: false,
          dartType: 'protocol:UnitType',
        ),
        _i2.ColumnDefinition(
          name: 'createdAt',
          columnType: _i2.ColumnType.timestampWithoutTimeZone,
          isNullable: false,
          dartType: 'DateTime',
        ),
        _i2.ColumnDefinition(
          name: 'updatedAt',
          columnType: _i2.ColumnType.timestampWithoutTimeZone,
          isNullable: false,
          dartType: 'DateTime',
        ),
      ],
      foreignKeys: [],
      indexes: [
        _i2.IndexDefinition(
          indexName: 'io_module_state_pkey',
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
          name: 'serialId',
          columnType: _i2.ColumnType.text,
          isNullable: false,
          dartType: 'String',
        ),
        _i2.ColumnDefinition(
          name: 'type',
          columnType: _i2.ColumnType.bigint,
          isNullable: false,
          dartType: 'protocol:IotDeviceType',
        ),
        _i2.ColumnDefinition(
          name: 'name',
          columnType: _i2.ColumnType.text,
          isNullable: false,
          dartType: 'String',
        ),
        _i2.ColumnDefinition(
          name: 'fwVersion',
          columnType: _i2.ColumnType.text,
          isNullable: false,
          dartType: 'String',
        ),
        _i2.ColumnDefinition(
          name: 'stateId',
          columnType: _i2.ColumnType.bigint,
          isNullable: false,
          dartType: 'int',
        ),
        _i2.ColumnDefinition(
          name: 'createdAt',
          columnType: _i2.ColumnType.timestampWithoutTimeZone,
          isNullable: false,
          dartType: 'DateTime',
        ),
        _i2.ColumnDefinition(
          name: 'updatedAt',
          columnType: _i2.ColumnType.timestampWithoutTimeZone,
          isNullable: false,
          dartType: 'DateTime',
        ),
      ],
      foreignKeys: [
        _i2.ForeignKeyDefinition(
          constraintName: 'iot_device_fk_0',
          columns: ['stateId'],
          referenceTable: 'iot_device_state',
          referenceTableSchema: 'public',
          referenceColumns: ['id'],
          onUpdate: _i2.ForeignKeyAction.noAction,
          onDelete: _i2.ForeignKeyAction.noAction,
          matchType: null,
        )
      ],
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
        ),
        _i2.IndexDefinition(
          indexName: 'iot_device_state_unique_idx',
          tableSpace: null,
          elements: [
            _i2.IndexElementDefinition(
              type: _i2.IndexElementDefinitionType.column,
              definition: 'stateId',
            )
          ],
          type: 'btree',
          isUnique: true,
          isPrimary: false,
        ),
      ],
      managed: true,
    ),
    _i2.TableDefinition(
      name: 'iot_device_state',
      dartName: 'IotDeviceState',
      schema: 'public',
      module: 'iot_cloud',
      columns: [
        _i2.ColumnDefinition(
          name: 'id',
          columnType: _i2.ColumnType.bigint,
          isNullable: false,
          dartType: 'int?',
          columnDefault: 'nextval(\'iot_device_state_id_seq\'::regclass)',
        ),
        _i2.ColumnDefinition(
          name: 'status',
          columnType: _i2.ColumnType.bigint,
          isNullable: false,
          dartType: 'protocol:IotDeviceStatus',
        ),
        _i2.ColumnDefinition(
          name: 'cpuLoad',
          columnType: _i2.ColumnType.bigint,
          isNullable: false,
          dartType: 'int',
        ),
        _i2.ColumnDefinition(
          name: 'temp',
          columnType: _i2.ColumnType.doublePrecision,
          isNullable: false,
          dartType: 'double',
        ),
        _i2.ColumnDefinition(
          name: 'mem',
          columnType: _i2.ColumnType.doublePrecision,
          isNullable: false,
          dartType: 'double',
        ),
        _i2.ColumnDefinition(
          name: 'heartBeat',
          columnType: _i2.ColumnType.timestampWithoutTimeZone,
          isNullable: false,
          dartType: 'DateTime',
        ),
        _i2.ColumnDefinition(
          name: 'createdAt',
          columnType: _i2.ColumnType.timestampWithoutTimeZone,
          isNullable: false,
          dartType: 'DateTime',
        ),
        _i2.ColumnDefinition(
          name: 'updatedAt',
          columnType: _i2.ColumnType.timestampWithoutTimeZone,
          isNullable: false,
          dartType: 'DateTime',
        ),
      ],
      foreignKeys: [],
      indexes: [
        _i2.IndexDefinition(
          indexName: 'iot_device_state_pkey',
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
    _i2.TableDefinition(
      name: 'pin',
      dartName: 'Pin',
      schema: 'public',
      module: 'iot_cloud',
      columns: [
        _i2.ColumnDefinition(
          name: 'id',
          columnType: _i2.ColumnType.bigint,
          isNullable: false,
          dartType: 'int?',
          columnDefault: 'nextval(\'pin_id_seq\'::regclass)',
        ),
        _i2.ColumnDefinition(
          name: 'iotDeviceId',
          columnType: _i2.ColumnType.bigint,
          isNullable: false,
          dartType: 'int',
        ),
        _i2.ColumnDefinition(
          name: 'name',
          columnType: _i2.ColumnType.text,
          isNullable: false,
          dartType: 'String',
        ),
        _i2.ColumnDefinition(
          name: 'number',
          columnType: _i2.ColumnType.bigint,
          isNullable: false,
          dartType: 'int',
        ),
        _i2.ColumnDefinition(
          name: 'direction',
          columnType: _i2.ColumnType.bigint,
          isNullable: false,
          dartType: 'protocol:PinDirection',
        ),
        _i2.ColumnDefinition(
          name: 'properties',
          columnType: _i2.ColumnType.json,
          isNullable: false,
          dartType: 'List<protocol:PinProperty>',
        ),
        _i2.ColumnDefinition(
          name: 'stateId',
          columnType: _i2.ColumnType.bigint,
          isNullable: false,
          dartType: 'int',
        ),
        _i2.ColumnDefinition(
          name: 'createdAt',
          columnType: _i2.ColumnType.timestampWithoutTimeZone,
          isNullable: false,
          dartType: 'DateTime',
        ),
        _i2.ColumnDefinition(
          name: 'updatedAt',
          columnType: _i2.ColumnType.timestampWithoutTimeZone,
          isNullable: false,
          dartType: 'DateTime',
        ),
      ],
      foreignKeys: [
        _i2.ForeignKeyDefinition(
          constraintName: 'pin_fk_0',
          columns: ['iotDeviceId'],
          referenceTable: 'iot_device',
          referenceTableSchema: 'public',
          referenceColumns: ['id'],
          onUpdate: _i2.ForeignKeyAction.noAction,
          onDelete: _i2.ForeignKeyAction.noAction,
          matchType: null,
        ),
        _i2.ForeignKeyDefinition(
          constraintName: 'pin_fk_1',
          columns: ['stateId'],
          referenceTable: 'pin_state',
          referenceTableSchema: 'public',
          referenceColumns: ['id'],
          onUpdate: _i2.ForeignKeyAction.noAction,
          onDelete: _i2.ForeignKeyAction.noAction,
          matchType: null,
        ),
      ],
      indexes: [
        _i2.IndexDefinition(
          indexName: 'pin_pkey',
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
        ),
        _i2.IndexDefinition(
          indexName: 'pin_state_unique_idx',
          tableSpace: null,
          elements: [
            _i2.IndexElementDefinition(
              type: _i2.IndexElementDefinitionType.column,
              definition: 'stateId',
            )
          ],
          type: 'btree',
          isUnique: true,
          isPrimary: false,
        ),
      ],
      managed: true,
    ),
    _i2.TableDefinition(
      name: 'pin_state',
      dartName: 'PinState',
      schema: 'public',
      module: 'iot_cloud',
      columns: [
        _i2.ColumnDefinition(
          name: 'id',
          columnType: _i2.ColumnType.bigint,
          isNullable: false,
          dartType: 'int?',
          columnDefault: 'nextval(\'pin_state_id_seq\'::regclass)',
        ),
        _i2.ColumnDefinition(
          name: 'value',
          columnType: _i2.ColumnType.text,
          isNullable: false,
          dartType: 'String',
        ),
      ],
      foreignKeys: [],
      indexes: [
        _i2.IndexDefinition(
          indexName: 'pin_state_pkey',
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
    if (t == _i4.IoModuleState) {
      return _i4.IoModuleState.fromJson(data) as T;
    }
    if (t == _i5.IoModuleSubType) {
      return _i5.IoModuleSubType.fromJson(data) as T;
    }
    if (t == _i6.IoModuleType) {
      return _i6.IoModuleType.fromJson(data) as T;
    }
    if (t == _i7.IotDevice) {
      return _i7.IotDevice.fromJson(data) as T;
    }
    if (t == _i8.IotDeviceState) {
      return _i8.IotDeviceState.fromJson(data) as T;
    }
    if (t == _i9.IotDeviceStatus) {
      return _i9.IotDeviceStatus.fromJson(data) as T;
    }
    if (t == _i10.IotDeviceType) {
      return _i10.IotDeviceType.fromJson(data) as T;
    }
    if (t == _i11.Pin) {
      return _i11.Pin.fromJson(data) as T;
    }
    if (t == _i12.PinDirection) {
      return _i12.PinDirection.fromJson(data) as T;
    }
    if (t == _i13.PinState) {
      return _i13.PinState.fromJson(data) as T;
    }
    if (t == _i14.PinProperty) {
      return _i14.PinProperty.fromJson(data) as T;
    }
    if (t == _i15.UnitType) {
      return _i15.UnitType.fromJson(data) as T;
    }
    if (t == _i1.getType<_i3.IoModule?>()) {
      return (data != null ? _i3.IoModule.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i4.IoModuleState?>()) {
      return (data != null ? _i4.IoModuleState.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i5.IoModuleSubType?>()) {
      return (data != null ? _i5.IoModuleSubType.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i6.IoModuleType?>()) {
      return (data != null ? _i6.IoModuleType.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i7.IotDevice?>()) {
      return (data != null ? _i7.IotDevice.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i8.IotDeviceState?>()) {
      return (data != null ? _i8.IotDeviceState.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i9.IotDeviceStatus?>()) {
      return (data != null ? _i9.IotDeviceStatus.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i10.IotDeviceType?>()) {
      return (data != null ? _i10.IotDeviceType.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i11.Pin?>()) {
      return (data != null ? _i11.Pin.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i12.PinDirection?>()) {
      return (data != null ? _i12.PinDirection.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i13.PinState?>()) {
      return (data != null ? _i13.PinState.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i14.PinProperty?>()) {
      return (data != null ? _i14.PinProperty.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i15.UnitType?>()) {
      return (data != null ? _i15.UnitType.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<List<_i3.IoModule>?>()) {
      return (data != null
          ? (data as List).map((e) => deserialize<_i3.IoModule>(e)).toList()
          : null) as dynamic;
    }
    if (t == _i1.getType<List<_i11.Pin>?>()) {
      return (data != null
          ? (data as List).map((e) => deserialize<_i11.Pin>(e)).toList()
          : null) as dynamic;
    }
    if (t == List<_i14.PinProperty>) {
      return (data as List)
          .map((e) => deserialize<_i14.PinProperty>(e))
          .toList() as dynamic;
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
    if (data is _i4.IoModuleState) {
      return 'IoModuleState';
    }
    if (data is _i5.IoModuleSubType) {
      return 'IoModuleSubType';
    }
    if (data is _i6.IoModuleType) {
      return 'IoModuleType';
    }
    if (data is _i7.IotDevice) {
      return 'IotDevice';
    }
    if (data is _i8.IotDeviceState) {
      return 'IotDeviceState';
    }
    if (data is _i9.IotDeviceStatus) {
      return 'IotDeviceStatus';
    }
    if (data is _i10.IotDeviceType) {
      return 'IotDeviceType';
    }
    if (data is _i11.Pin) {
      return 'Pin';
    }
    if (data is _i12.PinDirection) {
      return 'PinDirection';
    }
    if (data is _i13.PinState) {
      return 'PinState';
    }
    if (data is _i14.PinProperty) {
      return 'PinProperty';
    }
    if (data is _i15.UnitType) {
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
    if (dataClassName == 'IoModuleState') {
      return deserialize<_i4.IoModuleState>(data['data']);
    }
    if (dataClassName == 'IoModuleSubType') {
      return deserialize<_i5.IoModuleSubType>(data['data']);
    }
    if (dataClassName == 'IoModuleType') {
      return deserialize<_i6.IoModuleType>(data['data']);
    }
    if (dataClassName == 'IotDevice') {
      return deserialize<_i7.IotDevice>(data['data']);
    }
    if (dataClassName == 'IotDeviceState') {
      return deserialize<_i8.IotDeviceState>(data['data']);
    }
    if (dataClassName == 'IotDeviceStatus') {
      return deserialize<_i9.IotDeviceStatus>(data['data']);
    }
    if (dataClassName == 'IotDeviceType') {
      return deserialize<_i10.IotDeviceType>(data['data']);
    }
    if (dataClassName == 'Pin') {
      return deserialize<_i11.Pin>(data['data']);
    }
    if (dataClassName == 'PinDirection') {
      return deserialize<_i12.PinDirection>(data['data']);
    }
    if (dataClassName == 'PinState') {
      return deserialize<_i13.PinState>(data['data']);
    }
    if (dataClassName == 'PinProperty') {
      return deserialize<_i14.PinProperty>(data['data']);
    }
    if (dataClassName == 'UnitType') {
      return deserialize<_i15.UnitType>(data['data']);
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
      case _i3.IoModule:
        return _i3.IoModule.t;
      case _i4.IoModuleState:
        return _i4.IoModuleState.t;
      case _i7.IotDevice:
        return _i7.IotDevice.t;
      case _i8.IotDeviceState:
        return _i8.IotDeviceState.t;
      case _i11.Pin:
        return _i11.Pin.t;
      case _i13.PinState:
        return _i13.PinState.t;
    }
    return null;
  }

  @override
  List<_i2.TableDefinition> getTargetTableDefinitions() =>
      targetTableDefinitions;

  @override
  String getModuleName() => 'iot_cloud';
}
