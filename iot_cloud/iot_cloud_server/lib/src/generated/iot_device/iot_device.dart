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
import '../iot_device/iot_device_info.dart' as _i2;
import '../iot_device/iot_device_state.dart' as _i3;
import '../io_module/io_module.dart' as _i4;

abstract class IotDevice implements _i1.TableRow, _i1.ProtocolSerialization {
  IotDevice._({
    this.id,
    required this.info,
    required this.state,
    required this.attachedModules,
  });

  factory IotDevice({
    int? id,
    required _i2.IotDeviceInfo info,
    required _i3.IotDeviceState state,
    required List<_i4.IoModule> attachedModules,
  }) = _IotDeviceImpl;

  factory IotDevice.fromJson(Map<String, dynamic> jsonSerialization) {
    return IotDevice(
      id: jsonSerialization['id'] as int?,
      info: _i2.IotDeviceInfo.fromJson(
          (jsonSerialization['info'] as Map<String, dynamic>)),
      state: _i3.IotDeviceState.fromJson(
          (jsonSerialization['state'] as Map<String, dynamic>)),
      attachedModules: (jsonSerialization['attachedModules'] as List)
          .map((e) => _i4.IoModule.fromJson((e as Map<String, dynamic>)))
          .toList(),
    );
  }

  static final t = IotDeviceTable();

  static const db = IotDeviceRepository._();

  @override
  int? id;

  _i2.IotDeviceInfo info;

  _i3.IotDeviceState state;

  List<_i4.IoModule> attachedModules;

  @override
  _i1.Table get table => t;

  IotDevice copyWith({
    int? id,
    _i2.IotDeviceInfo? info,
    _i3.IotDeviceState? state,
    List<_i4.IoModule>? attachedModules,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      if (id != null) 'id': id,
      'info': info.toJson(),
      'state': state.toJson(),
      'attachedModules': attachedModules.toJson(valueToJson: (v) => v.toJson()),
    };
  }

  @override
  Map<String, dynamic> toJsonForProtocol() {
    return {
      if (id != null) 'id': id,
      'info': info.toJsonForProtocol(),
      'state': state.toJsonForProtocol(),
      'attachedModules':
          attachedModules.toJson(valueToJson: (v) => v.toJsonForProtocol()),
    };
  }

  static IotDeviceInclude include() {
    return IotDeviceInclude._();
  }

  static IotDeviceIncludeList includeList({
    _i1.WhereExpressionBuilder<IotDeviceTable>? where,
    int? limit,
    int? offset,
    _i1.OrderByBuilder<IotDeviceTable>? orderBy,
    bool orderDescending = false,
    _i1.OrderByListBuilder<IotDeviceTable>? orderByList,
    IotDeviceInclude? include,
  }) {
    return IotDeviceIncludeList._(
      where: where,
      limit: limit,
      offset: offset,
      orderBy: orderBy?.call(IotDevice.t),
      orderDescending: orderDescending,
      orderByList: orderByList?.call(IotDevice.t),
      include: include,
    );
  }

  @override
  String toString() {
    return _i1.SerializationManager.encode(this);
  }
}

class _Undefined {}

class _IotDeviceImpl extends IotDevice {
  _IotDeviceImpl({
    int? id,
    required _i2.IotDeviceInfo info,
    required _i3.IotDeviceState state,
    required List<_i4.IoModule> attachedModules,
  }) : super._(
          id: id,
          info: info,
          state: state,
          attachedModules: attachedModules,
        );

  @override
  IotDevice copyWith({
    Object? id = _Undefined,
    _i2.IotDeviceInfo? info,
    _i3.IotDeviceState? state,
    List<_i4.IoModule>? attachedModules,
  }) {
    return IotDevice(
      id: id is int? ? id : this.id,
      info: info ?? this.info.copyWith(),
      state: state ?? this.state.copyWith(),
      attachedModules: attachedModules ??
          this.attachedModules.map((e0) => e0.copyWith()).toList(),
    );
  }
}

class IotDeviceTable extends _i1.Table {
  IotDeviceTable({super.tableRelation}) : super(tableName: 'iot_device') {
    info = _i1.ColumnSerializable(
      'info',
      this,
    );
    state = _i1.ColumnSerializable(
      'state',
      this,
    );
    attachedModules = _i1.ColumnSerializable(
      'attachedModules',
      this,
    );
  }

  late final _i1.ColumnSerializable info;

  late final _i1.ColumnSerializable state;

  late final _i1.ColumnSerializable attachedModules;

  @override
  List<_i1.Column> get columns => [
        id,
        info,
        state,
        attachedModules,
      ];
}

class IotDeviceInclude extends _i1.IncludeObject {
  IotDeviceInclude._();

  @override
  Map<String, _i1.Include?> get includes => {};

  @override
  _i1.Table get table => IotDevice.t;
}

class IotDeviceIncludeList extends _i1.IncludeList {
  IotDeviceIncludeList._({
    _i1.WhereExpressionBuilder<IotDeviceTable>? where,
    super.limit,
    super.offset,
    super.orderBy,
    super.orderDescending,
    super.orderByList,
    super.include,
  }) {
    super.where = where?.call(IotDevice.t);
  }

  @override
  Map<String, _i1.Include?> get includes => include?.includes ?? {};

  @override
  _i1.Table get table => IotDevice.t;
}

class IotDeviceRepository {
  const IotDeviceRepository._();

  Future<List<IotDevice>> find(
    _i1.Session session, {
    _i1.WhereExpressionBuilder<IotDeviceTable>? where,
    int? limit,
    int? offset,
    _i1.OrderByBuilder<IotDeviceTable>? orderBy,
    bool orderDescending = false,
    _i1.OrderByListBuilder<IotDeviceTable>? orderByList,
    _i1.Transaction? transaction,
  }) async {
    return session.db.find<IotDevice>(
      where: where?.call(IotDevice.t),
      orderBy: orderBy?.call(IotDevice.t),
      orderByList: orderByList?.call(IotDevice.t),
      orderDescending: orderDescending,
      limit: limit,
      offset: offset,
      transaction: transaction,
    );
  }

  Future<IotDevice?> findFirstRow(
    _i1.Session session, {
    _i1.WhereExpressionBuilder<IotDeviceTable>? where,
    int? offset,
    _i1.OrderByBuilder<IotDeviceTable>? orderBy,
    bool orderDescending = false,
    _i1.OrderByListBuilder<IotDeviceTable>? orderByList,
    _i1.Transaction? transaction,
  }) async {
    return session.db.findFirstRow<IotDevice>(
      where: where?.call(IotDevice.t),
      orderBy: orderBy?.call(IotDevice.t),
      orderByList: orderByList?.call(IotDevice.t),
      orderDescending: orderDescending,
      offset: offset,
      transaction: transaction,
    );
  }

  Future<IotDevice?> findById(
    _i1.Session session,
    int id, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.findById<IotDevice>(
      id,
      transaction: transaction,
    );
  }

  Future<List<IotDevice>> insert(
    _i1.Session session,
    List<IotDevice> rows, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.insert<IotDevice>(
      rows,
      transaction: transaction,
    );
  }

  Future<IotDevice> insertRow(
    _i1.Session session,
    IotDevice row, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.insertRow<IotDevice>(
      row,
      transaction: transaction,
    );
  }

  Future<List<IotDevice>> update(
    _i1.Session session,
    List<IotDevice> rows, {
    _i1.ColumnSelections<IotDeviceTable>? columns,
    _i1.Transaction? transaction,
  }) async {
    return session.db.update<IotDevice>(
      rows,
      columns: columns?.call(IotDevice.t),
      transaction: transaction,
    );
  }

  Future<IotDevice> updateRow(
    _i1.Session session,
    IotDevice row, {
    _i1.ColumnSelections<IotDeviceTable>? columns,
    _i1.Transaction? transaction,
  }) async {
    return session.db.updateRow<IotDevice>(
      row,
      columns: columns?.call(IotDevice.t),
      transaction: transaction,
    );
  }

  Future<List<IotDevice>> delete(
    _i1.Session session,
    List<IotDevice> rows, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.delete<IotDevice>(
      rows,
      transaction: transaction,
    );
  }

  Future<IotDevice> deleteRow(
    _i1.Session session,
    IotDevice row, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.deleteRow<IotDevice>(
      row,
      transaction: transaction,
    );
  }

  Future<List<IotDevice>> deleteWhere(
    _i1.Session session, {
    required _i1.WhereExpressionBuilder<IotDeviceTable> where,
    _i1.Transaction? transaction,
  }) async {
    return session.db.deleteWhere<IotDevice>(
      where: where(IotDevice.t),
      transaction: transaction,
    );
  }

  Future<int> count(
    _i1.Session session, {
    _i1.WhereExpressionBuilder<IotDeviceTable>? where,
    int? limit,
    _i1.Transaction? transaction,
  }) async {
    return session.db.count<IotDevice>(
      where: where?.call(IotDevice.t),
      limit: limit,
      transaction: transaction,
    );
  }
}
