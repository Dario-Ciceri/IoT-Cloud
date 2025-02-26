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
import '../iot_device/iot_device.dart' as _i2;
import '../io_module/io_module_state.dart' as _i3;
import '../io_module/io_module_type.dart' as _i4;
import '../io_module/io_module_subtype.dart' as _i5;

abstract class IoModule implements _i1.TableRow, _i1.ProtocolSerialization {
  IoModule._({
    this.id,
    required this.iotDeviceId,
    this.iotDevice,
    required this.stateId,
    this.state,
    required this.serialId,
    required this.name,
    required this.type,
    required this.subtype,
    required this.createdAt,
    required this.updatedAt,
  });

  factory IoModule({
    int? id,
    required int iotDeviceId,
    _i2.IotDevice? iotDevice,
    required int stateId,
    _i3.IoModuleState? state,
    required String serialId,
    required String name,
    required _i4.IoModuleType type,
    required _i5.IoModuleSubType subtype,
    required DateTime createdAt,
    required DateTime updatedAt,
  }) = _IoModuleImpl;

  factory IoModule.fromJson(Map<String, dynamic> jsonSerialization) {
    return IoModule(
      id: jsonSerialization['id'] as int?,
      iotDeviceId: jsonSerialization['iotDeviceId'] as int,
      iotDevice: jsonSerialization['iotDevice'] == null
          ? null
          : _i2.IotDevice.fromJson(
              (jsonSerialization['iotDevice'] as Map<String, dynamic>)),
      stateId: jsonSerialization['stateId'] as int,
      state: jsonSerialization['state'] == null
          ? null
          : _i3.IoModuleState.fromJson(
              (jsonSerialization['state'] as Map<String, dynamic>)),
      serialId: jsonSerialization['serialId'] as String,
      name: jsonSerialization['name'] as String,
      type: _i4.IoModuleType.fromJson((jsonSerialization['type'] as int)),
      subtype:
          _i5.IoModuleSubType.fromJson((jsonSerialization['subtype'] as int)),
      createdAt:
          _i1.DateTimeJsonExtension.fromJson(jsonSerialization['createdAt']),
      updatedAt:
          _i1.DateTimeJsonExtension.fromJson(jsonSerialization['updatedAt']),
    );
  }

  static final t = IoModuleTable();

  static const db = IoModuleRepository._();

  @override
  int? id;

  int iotDeviceId;

  _i2.IotDevice? iotDevice;

  int stateId;

  _i3.IoModuleState? state;

  String serialId;

  String name;

  _i4.IoModuleType type;

  _i5.IoModuleSubType subtype;

  DateTime createdAt;

  DateTime updatedAt;

  @override
  _i1.Table get table => t;

  IoModule copyWith({
    int? id,
    int? iotDeviceId,
    _i2.IotDevice? iotDevice,
    int? stateId,
    _i3.IoModuleState? state,
    String? serialId,
    String? name,
    _i4.IoModuleType? type,
    _i5.IoModuleSubType? subtype,
    DateTime? createdAt,
    DateTime? updatedAt,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      if (id != null) 'id': id,
      'iotDeviceId': iotDeviceId,
      if (iotDevice != null) 'iotDevice': iotDevice?.toJson(),
      'stateId': stateId,
      if (state != null) 'state': state?.toJson(),
      'serialId': serialId,
      'name': name,
      'type': type.toJson(),
      'subtype': subtype.toJson(),
      'createdAt': createdAt.toJson(),
      'updatedAt': updatedAt.toJson(),
    };
  }

  @override
  Map<String, dynamic> toJsonForProtocol() {
    return {
      if (id != null) 'id': id,
      'iotDeviceId': iotDeviceId,
      if (iotDevice != null) 'iotDevice': iotDevice?.toJsonForProtocol(),
      'stateId': stateId,
      if (state != null) 'state': state?.toJsonForProtocol(),
      'serialId': serialId,
      'name': name,
      'type': type.toJson(),
      'subtype': subtype.toJson(),
      'createdAt': createdAt.toJson(),
      'updatedAt': updatedAt.toJson(),
    };
  }

  static IoModuleInclude include({
    _i2.IotDeviceInclude? iotDevice,
    _i3.IoModuleStateInclude? state,
  }) {
    return IoModuleInclude._(
      iotDevice: iotDevice,
      state: state,
    );
  }

  static IoModuleIncludeList includeList({
    _i1.WhereExpressionBuilder<IoModuleTable>? where,
    int? limit,
    int? offset,
    _i1.OrderByBuilder<IoModuleTable>? orderBy,
    bool orderDescending = false,
    _i1.OrderByListBuilder<IoModuleTable>? orderByList,
    IoModuleInclude? include,
  }) {
    return IoModuleIncludeList._(
      where: where,
      limit: limit,
      offset: offset,
      orderBy: orderBy?.call(IoModule.t),
      orderDescending: orderDescending,
      orderByList: orderByList?.call(IoModule.t),
      include: include,
    );
  }

  @override
  String toString() {
    return _i1.SerializationManager.encode(this);
  }
}

class _Undefined {}

class _IoModuleImpl extends IoModule {
  _IoModuleImpl({
    int? id,
    required int iotDeviceId,
    _i2.IotDevice? iotDevice,
    required int stateId,
    _i3.IoModuleState? state,
    required String serialId,
    required String name,
    required _i4.IoModuleType type,
    required _i5.IoModuleSubType subtype,
    required DateTime createdAt,
    required DateTime updatedAt,
  }) : super._(
          id: id,
          iotDeviceId: iotDeviceId,
          iotDevice: iotDevice,
          stateId: stateId,
          state: state,
          serialId: serialId,
          name: name,
          type: type,
          subtype: subtype,
          createdAt: createdAt,
          updatedAt: updatedAt,
        );

  @override
  IoModule copyWith({
    Object? id = _Undefined,
    int? iotDeviceId,
    Object? iotDevice = _Undefined,
    int? stateId,
    Object? state = _Undefined,
    String? serialId,
    String? name,
    _i4.IoModuleType? type,
    _i5.IoModuleSubType? subtype,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) {
    return IoModule(
      id: id is int? ? id : this.id,
      iotDeviceId: iotDeviceId ?? this.iotDeviceId,
      iotDevice:
          iotDevice is _i2.IotDevice? ? iotDevice : this.iotDevice?.copyWith(),
      stateId: stateId ?? this.stateId,
      state: state is _i3.IoModuleState? ? state : this.state?.copyWith(),
      serialId: serialId ?? this.serialId,
      name: name ?? this.name,
      type: type ?? this.type,
      subtype: subtype ?? this.subtype,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }
}

class IoModuleTable extends _i1.Table {
  IoModuleTable({super.tableRelation}) : super(tableName: 'io_module') {
    iotDeviceId = _i1.ColumnInt(
      'iotDeviceId',
      this,
    );
    stateId = _i1.ColumnInt(
      'stateId',
      this,
    );
    serialId = _i1.ColumnString(
      'serialId',
      this,
    );
    name = _i1.ColumnString(
      'name',
      this,
    );
    type = _i1.ColumnEnum(
      'type',
      this,
      _i1.EnumSerialization.byIndex,
    );
    subtype = _i1.ColumnEnum(
      'subtype',
      this,
      _i1.EnumSerialization.byIndex,
    );
    createdAt = _i1.ColumnDateTime(
      'createdAt',
      this,
    );
    updatedAt = _i1.ColumnDateTime(
      'updatedAt',
      this,
    );
  }

  late final _i1.ColumnInt iotDeviceId;

  _i2.IotDeviceTable? _iotDevice;

  late final _i1.ColumnInt stateId;

  _i3.IoModuleStateTable? _state;

  late final _i1.ColumnString serialId;

  late final _i1.ColumnString name;

  late final _i1.ColumnEnum<_i4.IoModuleType> type;

  late final _i1.ColumnEnum<_i5.IoModuleSubType> subtype;

  late final _i1.ColumnDateTime createdAt;

  late final _i1.ColumnDateTime updatedAt;

  _i2.IotDeviceTable get iotDevice {
    if (_iotDevice != null) return _iotDevice!;
    _iotDevice = _i1.createRelationTable(
      relationFieldName: 'iotDevice',
      field: IoModule.t.iotDeviceId,
      foreignField: _i2.IotDevice.t.id,
      tableRelation: tableRelation,
      createTable: (foreignTableRelation) =>
          _i2.IotDeviceTable(tableRelation: foreignTableRelation),
    );
    return _iotDevice!;
  }

  _i3.IoModuleStateTable get state {
    if (_state != null) return _state!;
    _state = _i1.createRelationTable(
      relationFieldName: 'state',
      field: IoModule.t.stateId,
      foreignField: _i3.IoModuleState.t.id,
      tableRelation: tableRelation,
      createTable: (foreignTableRelation) =>
          _i3.IoModuleStateTable(tableRelation: foreignTableRelation),
    );
    return _state!;
  }

  @override
  List<_i1.Column> get columns => [
        id,
        iotDeviceId,
        stateId,
        serialId,
        name,
        type,
        subtype,
        createdAt,
        updatedAt,
      ];

  @override
  _i1.Table? getRelationTable(String relationField) {
    if (relationField == 'iotDevice') {
      return iotDevice;
    }
    if (relationField == 'state') {
      return state;
    }
    return null;
  }
}

class IoModuleInclude extends _i1.IncludeObject {
  IoModuleInclude._({
    _i2.IotDeviceInclude? iotDevice,
    _i3.IoModuleStateInclude? state,
  }) {
    _iotDevice = iotDevice;
    _state = state;
  }

  _i2.IotDeviceInclude? _iotDevice;

  _i3.IoModuleStateInclude? _state;

  @override
  Map<String, _i1.Include?> get includes => {
        'iotDevice': _iotDevice,
        'state': _state,
      };

  @override
  _i1.Table get table => IoModule.t;
}

class IoModuleIncludeList extends _i1.IncludeList {
  IoModuleIncludeList._({
    _i1.WhereExpressionBuilder<IoModuleTable>? where,
    super.limit,
    super.offset,
    super.orderBy,
    super.orderDescending,
    super.orderByList,
    super.include,
  }) {
    super.where = where?.call(IoModule.t);
  }

  @override
  Map<String, _i1.Include?> get includes => include?.includes ?? {};

  @override
  _i1.Table get table => IoModule.t;
}

class IoModuleRepository {
  const IoModuleRepository._();

  final attachRow = const IoModuleAttachRowRepository._();

  Future<List<IoModule>> find(
    _i1.Session session, {
    _i1.WhereExpressionBuilder<IoModuleTable>? where,
    int? limit,
    int? offset,
    _i1.OrderByBuilder<IoModuleTable>? orderBy,
    bool orderDescending = false,
    _i1.OrderByListBuilder<IoModuleTable>? orderByList,
    _i1.Transaction? transaction,
    IoModuleInclude? include,
  }) async {
    return session.db.find<IoModule>(
      where: where?.call(IoModule.t),
      orderBy: orderBy?.call(IoModule.t),
      orderByList: orderByList?.call(IoModule.t),
      orderDescending: orderDescending,
      limit: limit,
      offset: offset,
      transaction: transaction,
      include: include,
    );
  }

  Future<IoModule?> findFirstRow(
    _i1.Session session, {
    _i1.WhereExpressionBuilder<IoModuleTable>? where,
    int? offset,
    _i1.OrderByBuilder<IoModuleTable>? orderBy,
    bool orderDescending = false,
    _i1.OrderByListBuilder<IoModuleTable>? orderByList,
    _i1.Transaction? transaction,
    IoModuleInclude? include,
  }) async {
    return session.db.findFirstRow<IoModule>(
      where: where?.call(IoModule.t),
      orderBy: orderBy?.call(IoModule.t),
      orderByList: orderByList?.call(IoModule.t),
      orderDescending: orderDescending,
      offset: offset,
      transaction: transaction,
      include: include,
    );
  }

  Future<IoModule?> findById(
    _i1.Session session,
    int id, {
    _i1.Transaction? transaction,
    IoModuleInclude? include,
  }) async {
    return session.db.findById<IoModule>(
      id,
      transaction: transaction,
      include: include,
    );
  }

  Future<List<IoModule>> insert(
    _i1.Session session,
    List<IoModule> rows, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.insert<IoModule>(
      rows,
      transaction: transaction,
    );
  }

  Future<IoModule> insertRow(
    _i1.Session session,
    IoModule row, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.insertRow<IoModule>(
      row,
      transaction: transaction,
    );
  }

  Future<List<IoModule>> update(
    _i1.Session session,
    List<IoModule> rows, {
    _i1.ColumnSelections<IoModuleTable>? columns,
    _i1.Transaction? transaction,
  }) async {
    return session.db.update<IoModule>(
      rows,
      columns: columns?.call(IoModule.t),
      transaction: transaction,
    );
  }

  Future<IoModule> updateRow(
    _i1.Session session,
    IoModule row, {
    _i1.ColumnSelections<IoModuleTable>? columns,
    _i1.Transaction? transaction,
  }) async {
    return session.db.updateRow<IoModule>(
      row,
      columns: columns?.call(IoModule.t),
      transaction: transaction,
    );
  }

  Future<List<IoModule>> delete(
    _i1.Session session,
    List<IoModule> rows, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.delete<IoModule>(
      rows,
      transaction: transaction,
    );
  }

  Future<IoModule> deleteRow(
    _i1.Session session,
    IoModule row, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.deleteRow<IoModule>(
      row,
      transaction: transaction,
    );
  }

  Future<List<IoModule>> deleteWhere(
    _i1.Session session, {
    required _i1.WhereExpressionBuilder<IoModuleTable> where,
    _i1.Transaction? transaction,
  }) async {
    return session.db.deleteWhere<IoModule>(
      where: where(IoModule.t),
      transaction: transaction,
    );
  }

  Future<int> count(
    _i1.Session session, {
    _i1.WhereExpressionBuilder<IoModuleTable>? where,
    int? limit,
    _i1.Transaction? transaction,
  }) async {
    return session.db.count<IoModule>(
      where: where?.call(IoModule.t),
      limit: limit,
      transaction: transaction,
    );
  }
}

class IoModuleAttachRowRepository {
  const IoModuleAttachRowRepository._();

  Future<void> iotDevice(
    _i1.Session session,
    IoModule ioModule,
    _i2.IotDevice iotDevice, {
    _i1.Transaction? transaction,
  }) async {
    if (ioModule.id == null) {
      throw ArgumentError.notNull('ioModule.id');
    }
    if (iotDevice.id == null) {
      throw ArgumentError.notNull('iotDevice.id');
    }

    var $ioModule = ioModule.copyWith(iotDeviceId: iotDevice.id);
    await session.db.updateRow<IoModule>(
      $ioModule,
      columns: [IoModule.t.iotDeviceId],
      transaction: transaction,
    );
  }

  Future<void> state(
    _i1.Session session,
    IoModule ioModule,
    _i3.IoModuleState state, {
    _i1.Transaction? transaction,
  }) async {
    if (ioModule.id == null) {
      throw ArgumentError.notNull('ioModule.id');
    }
    if (state.id == null) {
      throw ArgumentError.notNull('state.id');
    }

    var $ioModule = ioModule.copyWith(stateId: state.id);
    await session.db.updateRow<IoModule>(
      $ioModule,
      columns: [IoModule.t.stateId],
      transaction: transaction,
    );
  }
}
