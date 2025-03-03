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
import '../iot_device/iot_device_status.dart' as _i3;

abstract class IotDeviceState
    implements _i1.TableRow, _i1.ProtocolSerialization {
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

  static final t = IotDeviceStateTable();

  static const db = IotDeviceStateRepository._();

  @override
  int? id;

  _i2.IotDevice? iotDevice;

  _i3.IotDeviceStatus status;

  int cpuLoad;

  double temp;

  double mem;

  DateTime heartBeat;

  DateTime createdAt;

  DateTime updatedAt;

  @override
  _i1.Table get table => t;

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
  Map<String, dynamic> toJsonForProtocol() {
    return {
      if (id != null) 'id': id,
      if (iotDevice != null) 'iotDevice': iotDevice?.toJsonForProtocol(),
      'status': status.toJson(),
      'cpuLoad': cpuLoad,
      'temp': temp,
      'mem': mem,
      'heartBeat': heartBeat.toJson(),
      'createdAt': createdAt.toJson(),
      'updatedAt': updatedAt.toJson(),
    };
  }

  static IotDeviceStateInclude include({_i2.IotDeviceInclude? iotDevice}) {
    return IotDeviceStateInclude._(iotDevice: iotDevice);
  }

  static IotDeviceStateIncludeList includeList({
    _i1.WhereExpressionBuilder<IotDeviceStateTable>? where,
    int? limit,
    int? offset,
    _i1.OrderByBuilder<IotDeviceStateTable>? orderBy,
    bool orderDescending = false,
    _i1.OrderByListBuilder<IotDeviceStateTable>? orderByList,
    IotDeviceStateInclude? include,
  }) {
    return IotDeviceStateIncludeList._(
      where: where,
      limit: limit,
      offset: offset,
      orderBy: orderBy?.call(IotDeviceState.t),
      orderDescending: orderDescending,
      orderByList: orderByList?.call(IotDeviceState.t),
      include: include,
    );
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

class IotDeviceStateTable extends _i1.Table {
  IotDeviceStateTable({super.tableRelation})
      : super(tableName: 'iot_device_state') {
    status = _i1.ColumnEnum(
      'status',
      this,
      _i1.EnumSerialization.byIndex,
    );
    cpuLoad = _i1.ColumnInt(
      'cpuLoad',
      this,
    );
    temp = _i1.ColumnDouble(
      'temp',
      this,
    );
    mem = _i1.ColumnDouble(
      'mem',
      this,
    );
    heartBeat = _i1.ColumnDateTime(
      'heartBeat',
      this,
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

  _i2.IotDeviceTable? _iotDevice;

  late final _i1.ColumnEnum<_i3.IotDeviceStatus> status;

  late final _i1.ColumnInt cpuLoad;

  late final _i1.ColumnDouble temp;

  late final _i1.ColumnDouble mem;

  late final _i1.ColumnDateTime heartBeat;

  late final _i1.ColumnDateTime createdAt;

  late final _i1.ColumnDateTime updatedAt;

  _i2.IotDeviceTable get iotDevice {
    if (_iotDevice != null) return _iotDevice!;
    _iotDevice = _i1.createRelationTable(
      relationFieldName: 'iotDevice',
      field: IotDeviceState.t.id,
      foreignField: _i2.IotDevice.t.stateId,
      tableRelation: tableRelation,
      createTable: (foreignTableRelation) =>
          _i2.IotDeviceTable(tableRelation: foreignTableRelation),
    );
    return _iotDevice!;
  }

  @override
  List<_i1.Column> get columns => [
        id,
        status,
        cpuLoad,
        temp,
        mem,
        heartBeat,
        createdAt,
        updatedAt,
      ];

  @override
  _i1.Table? getRelationTable(String relationField) {
    if (relationField == 'iotDevice') {
      return iotDevice;
    }
    return null;
  }
}

class IotDeviceStateInclude extends _i1.IncludeObject {
  IotDeviceStateInclude._({_i2.IotDeviceInclude? iotDevice}) {
    _iotDevice = iotDevice;
  }

  _i2.IotDeviceInclude? _iotDevice;

  @override
  Map<String, _i1.Include?> get includes => {'iotDevice': _iotDevice};

  @override
  _i1.Table get table => IotDeviceState.t;
}

class IotDeviceStateIncludeList extends _i1.IncludeList {
  IotDeviceStateIncludeList._({
    _i1.WhereExpressionBuilder<IotDeviceStateTable>? where,
    super.limit,
    super.offset,
    super.orderBy,
    super.orderDescending,
    super.orderByList,
    super.include,
  }) {
    super.where = where?.call(IotDeviceState.t);
  }

  @override
  Map<String, _i1.Include?> get includes => include?.includes ?? {};

  @override
  _i1.Table get table => IotDeviceState.t;
}

class IotDeviceStateRepository {
  const IotDeviceStateRepository._();

  final attachRow = const IotDeviceStateAttachRowRepository._();

  Future<List<IotDeviceState>> find(
    _i1.Session session, {
    _i1.WhereExpressionBuilder<IotDeviceStateTable>? where,
    int? limit,
    int? offset,
    _i1.OrderByBuilder<IotDeviceStateTable>? orderBy,
    bool orderDescending = false,
    _i1.OrderByListBuilder<IotDeviceStateTable>? orderByList,
    _i1.Transaction? transaction,
    IotDeviceStateInclude? include,
  }) async {
    return session.db.find<IotDeviceState>(
      where: where?.call(IotDeviceState.t),
      orderBy: orderBy?.call(IotDeviceState.t),
      orderByList: orderByList?.call(IotDeviceState.t),
      orderDescending: orderDescending,
      limit: limit,
      offset: offset,
      transaction: transaction,
      include: include,
    );
  }

  Future<IotDeviceState?> findFirstRow(
    _i1.Session session, {
    _i1.WhereExpressionBuilder<IotDeviceStateTable>? where,
    int? offset,
    _i1.OrderByBuilder<IotDeviceStateTable>? orderBy,
    bool orderDescending = false,
    _i1.OrderByListBuilder<IotDeviceStateTable>? orderByList,
    _i1.Transaction? transaction,
    IotDeviceStateInclude? include,
  }) async {
    return session.db.findFirstRow<IotDeviceState>(
      where: where?.call(IotDeviceState.t),
      orderBy: orderBy?.call(IotDeviceState.t),
      orderByList: orderByList?.call(IotDeviceState.t),
      orderDescending: orderDescending,
      offset: offset,
      transaction: transaction,
      include: include,
    );
  }

  Future<IotDeviceState?> findById(
    _i1.Session session,
    int id, {
    _i1.Transaction? transaction,
    IotDeviceStateInclude? include,
  }) async {
    return session.db.findById<IotDeviceState>(
      id,
      transaction: transaction,
      include: include,
    );
  }

  Future<List<IotDeviceState>> insert(
    _i1.Session session,
    List<IotDeviceState> rows, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.insert<IotDeviceState>(
      rows,
      transaction: transaction,
    );
  }

  Future<IotDeviceState> insertRow(
    _i1.Session session,
    IotDeviceState row, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.insertRow<IotDeviceState>(
      row,
      transaction: transaction,
    );
  }

  Future<List<IotDeviceState>> update(
    _i1.Session session,
    List<IotDeviceState> rows, {
    _i1.ColumnSelections<IotDeviceStateTable>? columns,
    _i1.Transaction? transaction,
  }) async {
    return session.db.update<IotDeviceState>(
      rows,
      columns: columns?.call(IotDeviceState.t),
      transaction: transaction,
    );
  }

  Future<IotDeviceState> updateRow(
    _i1.Session session,
    IotDeviceState row, {
    _i1.ColumnSelections<IotDeviceStateTable>? columns,
    _i1.Transaction? transaction,
  }) async {
    return session.db.updateRow<IotDeviceState>(
      row,
      columns: columns?.call(IotDeviceState.t),
      transaction: transaction,
    );
  }

  Future<List<IotDeviceState>> delete(
    _i1.Session session,
    List<IotDeviceState> rows, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.delete<IotDeviceState>(
      rows,
      transaction: transaction,
    );
  }

  Future<IotDeviceState> deleteRow(
    _i1.Session session,
    IotDeviceState row, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.deleteRow<IotDeviceState>(
      row,
      transaction: transaction,
    );
  }

  Future<List<IotDeviceState>> deleteWhere(
    _i1.Session session, {
    required _i1.WhereExpressionBuilder<IotDeviceStateTable> where,
    _i1.Transaction? transaction,
  }) async {
    return session.db.deleteWhere<IotDeviceState>(
      where: where(IotDeviceState.t),
      transaction: transaction,
    );
  }

  Future<int> count(
    _i1.Session session, {
    _i1.WhereExpressionBuilder<IotDeviceStateTable>? where,
    int? limit,
    _i1.Transaction? transaction,
  }) async {
    return session.db.count<IotDeviceState>(
      where: where?.call(IotDeviceState.t),
      limit: limit,
      transaction: transaction,
    );
  }
}

class IotDeviceStateAttachRowRepository {
  const IotDeviceStateAttachRowRepository._();

  Future<void> iotDevice(
    _i1.Session session,
    IotDeviceState iotDeviceState,
    _i2.IotDevice iotDevice, {
    _i1.Transaction? transaction,
  }) async {
    if (iotDevice.id == null) {
      throw ArgumentError.notNull('iotDevice.id');
    }
    if (iotDeviceState.id == null) {
      throw ArgumentError.notNull('iotDeviceState.id');
    }

    var $iotDevice = iotDevice.copyWith(stateId: iotDeviceState.id);
    await session.db.updateRow<_i2.IotDevice>(
      $iotDevice,
      columns: [_i2.IotDevice.t.stateId],
      transaction: transaction,
    );
  }
}
