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
import 'example.dart' as _i3;
import 'exceptions/auth-exception.dart' as _i4;
import 'exceptions/cache-exception.dart' as _i5;
import 'exceptions/network-exception.dart' as _i6;
import 'exceptions/permission-exception.dart' as _i7;
import 'exceptions/server-exception.dart' as _i8;
import 'exceptions/unexpected-exception.dart' as _i9;
import 'exceptions/validation-exception.dart' as _i10;
import 'io_module/io_module.dart' as _i11;
import 'io_module/io_module_state.dart' as _i12;
import 'io_module/io_module_subtype.dart' as _i13;
import 'io_module/io_module_type.dart' as _i14;
import 'iot_device/iot_device.dart' as _i15;
import 'iot_device/iot_device_state.dart' as _i16;
import 'iot_device/iot_device_status.dart' as _i17;
import 'iot_device/iot_device_type.dart' as _i18;
import 'pin/pin.dart' as _i19;
import 'pin/pin_direction.dart' as _i20;
import 'pin/pin_state.dart' as _i21;
import 'pin/pin_type.dart' as _i22;
import 'platformio/platformio_board.dart' as _i23;
import 'platformio/platformio_build_result.dart' as _i24;
import 'platformio/platformio_device.dart' as _i25;
import 'platformio/platformio_file.dart' as _i26;
import 'platformio/platformio_library.dart' as _i27;
import 'platformio/platformio_platform.dart' as _i28;
import 'platformio/platformio_project.dart' as _i29;
import 'platformio/platformio_status.dart' as _i30;
import 'unit_type.dart' as _i31;
import 'url_mapping.dart' as _i32;
import 'package:iot_cloud_server/src/generated/iot_device/iot_device.dart'
    as _i33;
import 'package:iot_cloud_server/src/generated/platformio/platformio_project.dart'
    as _i34;
import 'package:iot_cloud_server/src/generated/platformio/platformio_board.dart'
    as _i35;
import 'package:iot_cloud_server/src/generated/platformio/platformio_device.dart'
    as _i36;
import 'package:iot_cloud_server/src/generated/platformio/platformio_library.dart'
    as _i37;
import 'package:iot_cloud_server/src/generated/platformio/platformio_platform.dart'
    as _i38;
import 'package:iot_cloud_server/src/generated/platformio/platformio_file.dart'
    as _i39;
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
          columnDefault: 'CURRENT_TIMESTAMP',
        ),
        _i2.ColumnDefinition(
          name: 'updatedAt',
          columnType: _i2.ColumnType.timestampWithoutTimeZone,
          isNullable: false,
          dartType: 'DateTime',
          columnDefault: 'CURRENT_TIMESTAMP',
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
          columnDefault: 'CURRENT_TIMESTAMP',
        ),
        _i2.ColumnDefinition(
          name: 'updatedAt',
          columnType: _i2.ColumnType.timestampWithoutTimeZone,
          isNullable: false,
          dartType: 'DateTime',
          columnDefault: 'CURRENT_TIMESTAMP',
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
          columnDefault: 'CURRENT_TIMESTAMP',
        ),
        _i2.ColumnDefinition(
          name: 'updatedAt',
          columnType: _i2.ColumnType.timestampWithoutTimeZone,
          isNullable: false,
          dartType: 'DateTime',
          columnDefault: 'CURRENT_TIMESTAMP',
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
          name: 'errorMessage',
          columnType: _i2.ColumnType.text,
          isNullable: true,
          dartType: 'String?',
        ),
        _i2.ColumnDefinition(
          name: 'heartBeat',
          columnType: _i2.ColumnType.timestampWithoutTimeZone,
          isNullable: false,
          dartType: 'DateTime',
          columnDefault: 'CURRENT_TIMESTAMP',
        ),
        _i2.ColumnDefinition(
          name: 'createdAt',
          columnType: _i2.ColumnType.timestampWithoutTimeZone,
          isNullable: false,
          dartType: 'DateTime',
          columnDefault: 'CURRENT_TIMESTAMP',
        ),
        _i2.ColumnDefinition(
          name: 'updatedAt',
          columnType: _i2.ColumnType.timestampWithoutTimeZone,
          isNullable: false,
          dartType: 'DateTime',
          columnDefault: 'CURRENT_TIMESTAMP',
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
          columnDefault: 'CURRENT_TIMESTAMP',
        ),
        _i2.ColumnDefinition(
          name: 'updatedAt',
          columnType: _i2.ColumnType.timestampWithoutTimeZone,
          isNullable: false,
          dartType: 'DateTime',
          columnDefault: 'CURRENT_TIMESTAMP',
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
    _i2.TableDefinition(
      name: 'platformio_project',
      dartName: 'PlatformioProject',
      schema: 'public',
      module: 'iot_cloud',
      columns: [
        _i2.ColumnDefinition(
          name: 'id',
          columnType: _i2.ColumnType.bigint,
          isNullable: false,
          dartType: 'int?',
          columnDefault: 'nextval(\'platformio_project_id_seq\'::regclass)',
        ),
        _i2.ColumnDefinition(
          name: 'name',
          columnType: _i2.ColumnType.text,
          isNullable: false,
          dartType: 'String',
        ),
        _i2.ColumnDefinition(
          name: 'path',
          columnType: _i2.ColumnType.text,
          isNullable: false,
          dartType: 'String',
        ),
        _i2.ColumnDefinition(
          name: 'description',
          columnType: _i2.ColumnType.text,
          isNullable: true,
          dartType: 'String?',
        ),
        _i2.ColumnDefinition(
          name: 'board',
          columnType: _i2.ColumnType.text,
          isNullable: true,
          dartType: 'String?',
        ),
        _i2.ColumnDefinition(
          name: 'framework',
          columnType: _i2.ColumnType.text,
          isNullable: true,
          dartType: 'String?',
        ),
        _i2.ColumnDefinition(
          name: 'createdAt',
          columnType: _i2.ColumnType.timestampWithoutTimeZone,
          isNullable: false,
          dartType: 'DateTime',
          columnDefault: 'CURRENT_TIMESTAMP',
        ),
        _i2.ColumnDefinition(
          name: 'updatedAt',
          columnType: _i2.ColumnType.timestampWithoutTimeZone,
          isNullable: false,
          dartType: 'DateTime',
          columnDefault: 'CURRENT_TIMESTAMP',
        ),
      ],
      foreignKeys: [],
      indexes: [
        _i2.IndexDefinition(
          indexName: 'platformio_project_pkey',
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
      name: 'url_mapping',
      dartName: 'UrlMapping',
      schema: 'public',
      module: 'iot_cloud',
      columns: [
        _i2.ColumnDefinition(
          name: 'id',
          columnType: _i2.ColumnType.bigint,
          isNullable: false,
          dartType: 'int?',
          columnDefault: 'nextval(\'url_mapping_id_seq\'::regclass)',
        ),
        _i2.ColumnDefinition(
          name: 'shortCode',
          columnType: _i2.ColumnType.text,
          isNullable: false,
          dartType: 'String',
        ),
        _i2.ColumnDefinition(
          name: 'originalUrl',
          columnType: _i2.ColumnType.text,
          isNullable: false,
          dartType: 'String',
        ),
        _i2.ColumnDefinition(
          name: 'createdAt',
          columnType: _i2.ColumnType.timestampWithoutTimeZone,
          isNullable: true,
          dartType: 'DateTime?',
          columnDefault: 'CURRENT_TIMESTAMP',
        ),
      ],
      foreignKeys: [],
      indexes: [
        _i2.IndexDefinition(
          indexName: 'url_mapping_pkey',
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
          indexName: 'url_mapping_short_code_idx',
          tableSpace: null,
          elements: [
            _i2.IndexElementDefinition(
              type: _i2.IndexElementDefinitionType.column,
              definition: 'shortCode',
            )
          ],
          type: 'btree',
          isUnique: true,
          isPrimary: false,
        ),
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
    if (t == _i3.Example) {
      return _i3.Example.fromJson(data) as T;
    }
    if (t == _i4.AuthException) {
      return _i4.AuthException.fromJson(data) as T;
    }
    if (t == _i5.CacheException) {
      return _i5.CacheException.fromJson(data) as T;
    }
    if (t == _i6.NetworkException) {
      return _i6.NetworkException.fromJson(data) as T;
    }
    if (t == _i7.PermissionException) {
      return _i7.PermissionException.fromJson(data) as T;
    }
    if (t == _i8.ServerException) {
      return _i8.ServerException.fromJson(data) as T;
    }
    if (t == _i9.UnexpectedException) {
      return _i9.UnexpectedException.fromJson(data) as T;
    }
    if (t == _i10.ValidationException) {
      return _i10.ValidationException.fromJson(data) as T;
    }
    if (t == _i11.IoModule) {
      return _i11.IoModule.fromJson(data) as T;
    }
    if (t == _i12.IoModuleState) {
      return _i12.IoModuleState.fromJson(data) as T;
    }
    if (t == _i13.IoModuleSubType) {
      return _i13.IoModuleSubType.fromJson(data) as T;
    }
    if (t == _i14.IoModuleType) {
      return _i14.IoModuleType.fromJson(data) as T;
    }
    if (t == _i15.IotDevice) {
      return _i15.IotDevice.fromJson(data) as T;
    }
    if (t == _i16.IotDeviceState) {
      return _i16.IotDeviceState.fromJson(data) as T;
    }
    if (t == _i17.IotDeviceStatus) {
      return _i17.IotDeviceStatus.fromJson(data) as T;
    }
    if (t == _i18.IotDeviceType) {
      return _i18.IotDeviceType.fromJson(data) as T;
    }
    if (t == _i19.Pin) {
      return _i19.Pin.fromJson(data) as T;
    }
    if (t == _i20.PinDirection) {
      return _i20.PinDirection.fromJson(data) as T;
    }
    if (t == _i21.PinState) {
      return _i21.PinState.fromJson(data) as T;
    }
    if (t == _i22.PinProperty) {
      return _i22.PinProperty.fromJson(data) as T;
    }
    if (t == _i23.PlatformioBoard) {
      return _i23.PlatformioBoard.fromJson(data) as T;
    }
    if (t == _i24.PlatformioBuildResult) {
      return _i24.PlatformioBuildResult.fromJson(data) as T;
    }
    if (t == _i25.PlatformioDevice) {
      return _i25.PlatformioDevice.fromJson(data) as T;
    }
    if (t == _i26.PlatformioFile) {
      return _i26.PlatformioFile.fromJson(data) as T;
    }
    if (t == _i27.PlatformioLibrary) {
      return _i27.PlatformioLibrary.fromJson(data) as T;
    }
    if (t == _i28.PlatformioPlatform) {
      return _i28.PlatformioPlatform.fromJson(data) as T;
    }
    if (t == _i29.PlatformioProject) {
      return _i29.PlatformioProject.fromJson(data) as T;
    }
    if (t == _i30.PlatformioStatus) {
      return _i30.PlatformioStatus.fromJson(data) as T;
    }
    if (t == _i31.UnitType) {
      return _i31.UnitType.fromJson(data) as T;
    }
    if (t == _i32.UrlMapping) {
      return _i32.UrlMapping.fromJson(data) as T;
    }
    if (t == _i1.getType<_i3.Example?>()) {
      return (data != null ? _i3.Example.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i4.AuthException?>()) {
      return (data != null ? _i4.AuthException.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i5.CacheException?>()) {
      return (data != null ? _i5.CacheException.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i6.NetworkException?>()) {
      return (data != null ? _i6.NetworkException.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i7.PermissionException?>()) {
      return (data != null ? _i7.PermissionException.fromJson(data) : null)
          as T;
    }
    if (t == _i1.getType<_i8.ServerException?>()) {
      return (data != null ? _i8.ServerException.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i9.UnexpectedException?>()) {
      return (data != null ? _i9.UnexpectedException.fromJson(data) : null)
          as T;
    }
    if (t == _i1.getType<_i10.ValidationException?>()) {
      return (data != null ? _i10.ValidationException.fromJson(data) : null)
          as T;
    }
    if (t == _i1.getType<_i11.IoModule?>()) {
      return (data != null ? _i11.IoModule.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i12.IoModuleState?>()) {
      return (data != null ? _i12.IoModuleState.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i13.IoModuleSubType?>()) {
      return (data != null ? _i13.IoModuleSubType.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i14.IoModuleType?>()) {
      return (data != null ? _i14.IoModuleType.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i15.IotDevice?>()) {
      return (data != null ? _i15.IotDevice.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i16.IotDeviceState?>()) {
      return (data != null ? _i16.IotDeviceState.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i17.IotDeviceStatus?>()) {
      return (data != null ? _i17.IotDeviceStatus.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i18.IotDeviceType?>()) {
      return (data != null ? _i18.IotDeviceType.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i19.Pin?>()) {
      return (data != null ? _i19.Pin.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i20.PinDirection?>()) {
      return (data != null ? _i20.PinDirection.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i21.PinState?>()) {
      return (data != null ? _i21.PinState.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i22.PinProperty?>()) {
      return (data != null ? _i22.PinProperty.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i23.PlatformioBoard?>()) {
      return (data != null ? _i23.PlatformioBoard.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i24.PlatformioBuildResult?>()) {
      return (data != null ? _i24.PlatformioBuildResult.fromJson(data) : null)
          as T;
    }
    if (t == _i1.getType<_i25.PlatformioDevice?>()) {
      return (data != null ? _i25.PlatformioDevice.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i26.PlatformioFile?>()) {
      return (data != null ? _i26.PlatformioFile.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i27.PlatformioLibrary?>()) {
      return (data != null ? _i27.PlatformioLibrary.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i28.PlatformioPlatform?>()) {
      return (data != null ? _i28.PlatformioPlatform.fromJson(data) : null)
          as T;
    }
    if (t == _i1.getType<_i29.PlatformioProject?>()) {
      return (data != null ? _i29.PlatformioProject.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i30.PlatformioStatus?>()) {
      return (data != null ? _i30.PlatformioStatus.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i31.UnitType?>()) {
      return (data != null ? _i31.UnitType.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i32.UrlMapping?>()) {
      return (data != null ? _i32.UrlMapping.fromJson(data) : null) as T;
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
    if (t == _i1.getType<List<_i11.IoModule>?>()) {
      return (data != null
          ? (data as List).map((e) => deserialize<_i11.IoModule>(e)).toList()
          : null) as T;
    }
    if (t == _i1.getType<List<_i19.Pin>?>()) {
      return (data != null
          ? (data as List).map((e) => deserialize<_i19.Pin>(e)).toList()
          : null) as T;
    }
    if (t == List<_i22.PinProperty>) {
      return (data as List)
          .map((e) => deserialize<_i22.PinProperty>(e))
          .toList() as T;
    }
    if (t == List<_i33.IotDevice>) {
      return (data as List).map((e) => deserialize<_i33.IotDevice>(e)).toList()
          as T;
    }
    if (t == List<_i34.PlatformioProject>) {
      return (data as List)
          .map((e) => deserialize<_i34.PlatformioProject>(e))
          .toList() as T;
    }
    if (t == List<_i35.PlatformioBoard>) {
      return (data as List)
          .map((e) => deserialize<_i35.PlatformioBoard>(e))
          .toList() as T;
    }
    if (t == List<_i36.PlatformioDevice>) {
      return (data as List)
          .map((e) => deserialize<_i36.PlatformioDevice>(e))
          .toList() as T;
    }
    if (t == List<_i37.PlatformioLibrary>) {
      return (data as List)
          .map((e) => deserialize<_i37.PlatformioLibrary>(e))
          .toList() as T;
    }
    if (t == List<String>) {
      return (data as List).map((e) => deserialize<String>(e)).toList() as T;
    }
    if (t == List<_i38.PlatformioPlatform>) {
      return (data as List)
          .map((e) => deserialize<_i38.PlatformioPlatform>(e))
          .toList() as T;
    }
    if (t == Map<String, String>) {
      return (data as Map).map((k, v) =>
          MapEntry(deserialize<String>(k), deserialize<String>(v))) as T;
    }
    if (t == List<_i39.PlatformioFile>) {
      return (data as List)
          .map((e) => deserialize<_i39.PlatformioFile>(e))
          .toList() as T;
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
    if (data is _i3.Example) {
      return 'Example';
    }
    if (data is _i4.AuthException) {
      return 'AuthException';
    }
    if (data is _i5.CacheException) {
      return 'CacheException';
    }
    if (data is _i6.NetworkException) {
      return 'NetworkException';
    }
    if (data is _i7.PermissionException) {
      return 'PermissionException';
    }
    if (data is _i8.ServerException) {
      return 'ServerException';
    }
    if (data is _i9.UnexpectedException) {
      return 'UnexpectedException';
    }
    if (data is _i10.ValidationException) {
      return 'ValidationException';
    }
    if (data is _i11.IoModule) {
      return 'IoModule';
    }
    if (data is _i12.IoModuleState) {
      return 'IoModuleState';
    }
    if (data is _i13.IoModuleSubType) {
      return 'IoModuleSubType';
    }
    if (data is _i14.IoModuleType) {
      return 'IoModuleType';
    }
    if (data is _i15.IotDevice) {
      return 'IotDevice';
    }
    if (data is _i16.IotDeviceState) {
      return 'IotDeviceState';
    }
    if (data is _i17.IotDeviceStatus) {
      return 'IotDeviceStatus';
    }
    if (data is _i18.IotDeviceType) {
      return 'IotDeviceType';
    }
    if (data is _i19.Pin) {
      return 'Pin';
    }
    if (data is _i20.PinDirection) {
      return 'PinDirection';
    }
    if (data is _i21.PinState) {
      return 'PinState';
    }
    if (data is _i22.PinProperty) {
      return 'PinProperty';
    }
    if (data is _i23.PlatformioBoard) {
      return 'PlatformioBoard';
    }
    if (data is _i24.PlatformioBuildResult) {
      return 'PlatformioBuildResult';
    }
    if (data is _i25.PlatformioDevice) {
      return 'PlatformioDevice';
    }
    if (data is _i26.PlatformioFile) {
      return 'PlatformioFile';
    }
    if (data is _i27.PlatformioLibrary) {
      return 'PlatformioLibrary';
    }
    if (data is _i28.PlatformioPlatform) {
      return 'PlatformioPlatform';
    }
    if (data is _i29.PlatformioProject) {
      return 'PlatformioProject';
    }
    if (data is _i30.PlatformioStatus) {
      return 'PlatformioStatus';
    }
    if (data is _i31.UnitType) {
      return 'UnitType';
    }
    if (data is _i32.UrlMapping) {
      return 'UrlMapping';
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
    if (dataClassName == 'Example') {
      return deserialize<_i3.Example>(data['data']);
    }
    if (dataClassName == 'AuthException') {
      return deserialize<_i4.AuthException>(data['data']);
    }
    if (dataClassName == 'CacheException') {
      return deserialize<_i5.CacheException>(data['data']);
    }
    if (dataClassName == 'NetworkException') {
      return deserialize<_i6.NetworkException>(data['data']);
    }
    if (dataClassName == 'PermissionException') {
      return deserialize<_i7.PermissionException>(data['data']);
    }
    if (dataClassName == 'ServerException') {
      return deserialize<_i8.ServerException>(data['data']);
    }
    if (dataClassName == 'UnexpectedException') {
      return deserialize<_i9.UnexpectedException>(data['data']);
    }
    if (dataClassName == 'ValidationException') {
      return deserialize<_i10.ValidationException>(data['data']);
    }
    if (dataClassName == 'IoModule') {
      return deserialize<_i11.IoModule>(data['data']);
    }
    if (dataClassName == 'IoModuleState') {
      return deserialize<_i12.IoModuleState>(data['data']);
    }
    if (dataClassName == 'IoModuleSubType') {
      return deserialize<_i13.IoModuleSubType>(data['data']);
    }
    if (dataClassName == 'IoModuleType') {
      return deserialize<_i14.IoModuleType>(data['data']);
    }
    if (dataClassName == 'IotDevice') {
      return deserialize<_i15.IotDevice>(data['data']);
    }
    if (dataClassName == 'IotDeviceState') {
      return deserialize<_i16.IotDeviceState>(data['data']);
    }
    if (dataClassName == 'IotDeviceStatus') {
      return deserialize<_i17.IotDeviceStatus>(data['data']);
    }
    if (dataClassName == 'IotDeviceType') {
      return deserialize<_i18.IotDeviceType>(data['data']);
    }
    if (dataClassName == 'Pin') {
      return deserialize<_i19.Pin>(data['data']);
    }
    if (dataClassName == 'PinDirection') {
      return deserialize<_i20.PinDirection>(data['data']);
    }
    if (dataClassName == 'PinState') {
      return deserialize<_i21.PinState>(data['data']);
    }
    if (dataClassName == 'PinProperty') {
      return deserialize<_i22.PinProperty>(data['data']);
    }
    if (dataClassName == 'PlatformioBoard') {
      return deserialize<_i23.PlatformioBoard>(data['data']);
    }
    if (dataClassName == 'PlatformioBuildResult') {
      return deserialize<_i24.PlatformioBuildResult>(data['data']);
    }
    if (dataClassName == 'PlatformioDevice') {
      return deserialize<_i25.PlatformioDevice>(data['data']);
    }
    if (dataClassName == 'PlatformioFile') {
      return deserialize<_i26.PlatformioFile>(data['data']);
    }
    if (dataClassName == 'PlatformioLibrary') {
      return deserialize<_i27.PlatformioLibrary>(data['data']);
    }
    if (dataClassName == 'PlatformioPlatform') {
      return deserialize<_i28.PlatformioPlatform>(data['data']);
    }
    if (dataClassName == 'PlatformioProject') {
      return deserialize<_i29.PlatformioProject>(data['data']);
    }
    if (dataClassName == 'PlatformioStatus') {
      return deserialize<_i30.PlatformioStatus>(data['data']);
    }
    if (dataClassName == 'UnitType') {
      return deserialize<_i31.UnitType>(data['data']);
    }
    if (dataClassName == 'UrlMapping') {
      return deserialize<_i32.UrlMapping>(data['data']);
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
      case _i11.IoModule:
        return _i11.IoModule.t;
      case _i12.IoModuleState:
        return _i12.IoModuleState.t;
      case _i15.IotDevice:
        return _i15.IotDevice.t;
      case _i16.IotDeviceState:
        return _i16.IotDeviceState.t;
      case _i19.Pin:
        return _i19.Pin.t;
      case _i21.PinState:
        return _i21.PinState.t;
      case _i29.PlatformioProject:
        return _i29.PlatformioProject.t;
      case _i32.UrlMapping:
        return _i32.UrlMapping.t;
    }
    return null;
  }

  @override
  List<_i2.TableDefinition> getTargetTableDefinitions() =>
      targetTableDefinitions;

  @override
  String getModuleName() => 'iot_cloud';
}
