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
import '../io_module/io_module.dart' as _i2;
import '../unit_type.dart' as _i3;

abstract class IoModuleState
    implements _i1.TableRow, _i1.ProtocolSerialization {
  IoModuleState._({
    this.id,
    this.ioModule,
    required this.value,
    required this.unit,
    required this.createdAt,
    required this.updatedAt,
  });

  factory IoModuleState({
    int? id,
    _i2.IoModule? ioModule,
    required String value,
    required _i3.UnitType unit,
    required DateTime createdAt,
    required DateTime updatedAt,
  }) = _IoModuleStateImpl;

  factory IoModuleState.fromJson(Map<String, dynamic> jsonSerialization) {
    return IoModuleState(
      id: jsonSerialization['id'] as int?,
      ioModule: jsonSerialization['ioModule'] == null
          ? null
          : _i2.IoModule.fromJson(
              (jsonSerialization['ioModule'] as Map<String, dynamic>)),
      value: jsonSerialization['value'] as String,
      unit: _i3.UnitType.fromJson((jsonSerialization['unit'] as int)),
      createdAt:
          _i1.DateTimeJsonExtension.fromJson(jsonSerialization['createdAt']),
      updatedAt:
          _i1.DateTimeJsonExtension.fromJson(jsonSerialization['updatedAt']),
    );
  }

  static final t = IoModuleStateTable();

  static const db = IoModuleStateRepository._();

  @override
  int? id;

  _i2.IoModule? ioModule;

  String value;

  _i3.UnitType unit;

  DateTime createdAt;

  DateTime updatedAt;

  @override
  _i1.Table get table => t;

  IoModuleState copyWith({
    int? id,
    _i2.IoModule? ioModule,
    String? value,
    _i3.UnitType? unit,
    DateTime? createdAt,
    DateTime? updatedAt,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      if (id != null) 'id': id,
      if (ioModule != null) 'ioModule': ioModule?.toJson(),
      'value': value,
      'unit': unit.toJson(),
      'createdAt': createdAt.toJson(),
      'updatedAt': updatedAt.toJson(),
    };
  }

  @override
  Map<String, dynamic> toJsonForProtocol() {
    return {
      if (id != null) 'id': id,
      if (ioModule != null) 'ioModule': ioModule?.toJsonForProtocol(),
      'value': value,
      'unit': unit.toJson(),
      'createdAt': createdAt.toJson(),
      'updatedAt': updatedAt.toJson(),
    };
  }

  static IoModuleStateInclude include({_i2.IoModuleInclude? ioModule}) {
    return IoModuleStateInclude._(ioModule: ioModule);
  }

  static IoModuleStateIncludeList includeList({
    _i1.WhereExpressionBuilder<IoModuleStateTable>? where,
    int? limit,
    int? offset,
    _i1.OrderByBuilder<IoModuleStateTable>? orderBy,
    bool orderDescending = false,
    _i1.OrderByListBuilder<IoModuleStateTable>? orderByList,
    IoModuleStateInclude? include,
  }) {
    return IoModuleStateIncludeList._(
      where: where,
      limit: limit,
      offset: offset,
      orderBy: orderBy?.call(IoModuleState.t),
      orderDescending: orderDescending,
      orderByList: orderByList?.call(IoModuleState.t),
      include: include,
    );
  }

  @override
  String toString() {
    return _i1.SerializationManager.encode(this);
  }
}

class _Undefined {}

class _IoModuleStateImpl extends IoModuleState {
  _IoModuleStateImpl({
    int? id,
    _i2.IoModule? ioModule,
    required String value,
    required _i3.UnitType unit,
    required DateTime createdAt,
    required DateTime updatedAt,
  }) : super._(
          id: id,
          ioModule: ioModule,
          value: value,
          unit: unit,
          createdAt: createdAt,
          updatedAt: updatedAt,
        );

  @override
  IoModuleState copyWith({
    Object? id = _Undefined,
    Object? ioModule = _Undefined,
    String? value,
    _i3.UnitType? unit,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) {
    return IoModuleState(
      id: id is int? ? id : this.id,
      ioModule:
          ioModule is _i2.IoModule? ? ioModule : this.ioModule?.copyWith(),
      value: value ?? this.value,
      unit: unit ?? this.unit,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }
}

class IoModuleStateTable extends _i1.Table {
  IoModuleStateTable({super.tableRelation})
      : super(tableName: 'io_module_state') {
    value = _i1.ColumnString(
      'value',
      this,
    );
    unit = _i1.ColumnEnum(
      'unit',
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

  _i2.IoModuleTable? _ioModule;

  late final _i1.ColumnString value;

  late final _i1.ColumnEnum<_i3.UnitType> unit;

  late final _i1.ColumnDateTime createdAt;

  late final _i1.ColumnDateTime updatedAt;

  _i2.IoModuleTable get ioModule {
    if (_ioModule != null) return _ioModule!;
    _ioModule = _i1.createRelationTable(
      relationFieldName: 'ioModule',
      field: IoModuleState.t.id,
      foreignField: _i2.IoModule.t.stateId,
      tableRelation: tableRelation,
      createTable: (foreignTableRelation) =>
          _i2.IoModuleTable(tableRelation: foreignTableRelation),
    );
    return _ioModule!;
  }

  @override
  List<_i1.Column> get columns => [
        id,
        value,
        unit,
        createdAt,
        updatedAt,
      ];

  @override
  _i1.Table? getRelationTable(String relationField) {
    if (relationField == 'ioModule') {
      return ioModule;
    }
    return null;
  }
}

class IoModuleStateInclude extends _i1.IncludeObject {
  IoModuleStateInclude._({_i2.IoModuleInclude? ioModule}) {
    _ioModule = ioModule;
  }

  _i2.IoModuleInclude? _ioModule;

  @override
  Map<String, _i1.Include?> get includes => {'ioModule': _ioModule};

  @override
  _i1.Table get table => IoModuleState.t;
}

class IoModuleStateIncludeList extends _i1.IncludeList {
  IoModuleStateIncludeList._({
    _i1.WhereExpressionBuilder<IoModuleStateTable>? where,
    super.limit,
    super.offset,
    super.orderBy,
    super.orderDescending,
    super.orderByList,
    super.include,
  }) {
    super.where = where?.call(IoModuleState.t);
  }

  @override
  Map<String, _i1.Include?> get includes => include?.includes ?? {};

  @override
  _i1.Table get table => IoModuleState.t;
}

class IoModuleStateRepository {
  const IoModuleStateRepository._();

  final attachRow = const IoModuleStateAttachRowRepository._();

  Future<List<IoModuleState>> find(
    _i1.Session session, {
    _i1.WhereExpressionBuilder<IoModuleStateTable>? where,
    int? limit,
    int? offset,
    _i1.OrderByBuilder<IoModuleStateTable>? orderBy,
    bool orderDescending = false,
    _i1.OrderByListBuilder<IoModuleStateTable>? orderByList,
    _i1.Transaction? transaction,
    IoModuleStateInclude? include,
  }) async {
    return session.db.find<IoModuleState>(
      where: where?.call(IoModuleState.t),
      orderBy: orderBy?.call(IoModuleState.t),
      orderByList: orderByList?.call(IoModuleState.t),
      orderDescending: orderDescending,
      limit: limit,
      offset: offset,
      transaction: transaction,
      include: include,
    );
  }

  Future<IoModuleState?> findFirstRow(
    _i1.Session session, {
    _i1.WhereExpressionBuilder<IoModuleStateTable>? where,
    int? offset,
    _i1.OrderByBuilder<IoModuleStateTable>? orderBy,
    bool orderDescending = false,
    _i1.OrderByListBuilder<IoModuleStateTable>? orderByList,
    _i1.Transaction? transaction,
    IoModuleStateInclude? include,
  }) async {
    return session.db.findFirstRow<IoModuleState>(
      where: where?.call(IoModuleState.t),
      orderBy: orderBy?.call(IoModuleState.t),
      orderByList: orderByList?.call(IoModuleState.t),
      orderDescending: orderDescending,
      offset: offset,
      transaction: transaction,
      include: include,
    );
  }

  Future<IoModuleState?> findById(
    _i1.Session session,
    int id, {
    _i1.Transaction? transaction,
    IoModuleStateInclude? include,
  }) async {
    return session.db.findById<IoModuleState>(
      id,
      transaction: transaction,
      include: include,
    );
  }

  Future<List<IoModuleState>> insert(
    _i1.Session session,
    List<IoModuleState> rows, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.insert<IoModuleState>(
      rows,
      transaction: transaction,
    );
  }

  Future<IoModuleState> insertRow(
    _i1.Session session,
    IoModuleState row, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.insertRow<IoModuleState>(
      row,
      transaction: transaction,
    );
  }

  Future<List<IoModuleState>> update(
    _i1.Session session,
    List<IoModuleState> rows, {
    _i1.ColumnSelections<IoModuleStateTable>? columns,
    _i1.Transaction? transaction,
  }) async {
    return session.db.update<IoModuleState>(
      rows,
      columns: columns?.call(IoModuleState.t),
      transaction: transaction,
    );
  }

  Future<IoModuleState> updateRow(
    _i1.Session session,
    IoModuleState row, {
    _i1.ColumnSelections<IoModuleStateTable>? columns,
    _i1.Transaction? transaction,
  }) async {
    return session.db.updateRow<IoModuleState>(
      row,
      columns: columns?.call(IoModuleState.t),
      transaction: transaction,
    );
  }

  Future<List<IoModuleState>> delete(
    _i1.Session session,
    List<IoModuleState> rows, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.delete<IoModuleState>(
      rows,
      transaction: transaction,
    );
  }

  Future<IoModuleState> deleteRow(
    _i1.Session session,
    IoModuleState row, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.deleteRow<IoModuleState>(
      row,
      transaction: transaction,
    );
  }

  Future<List<IoModuleState>> deleteWhere(
    _i1.Session session, {
    required _i1.WhereExpressionBuilder<IoModuleStateTable> where,
    _i1.Transaction? transaction,
  }) async {
    return session.db.deleteWhere<IoModuleState>(
      where: where(IoModuleState.t),
      transaction: transaction,
    );
  }

  Future<int> count(
    _i1.Session session, {
    _i1.WhereExpressionBuilder<IoModuleStateTable>? where,
    int? limit,
    _i1.Transaction? transaction,
  }) async {
    return session.db.count<IoModuleState>(
      where: where?.call(IoModuleState.t),
      limit: limit,
      transaction: transaction,
    );
  }
}

class IoModuleStateAttachRowRepository {
  const IoModuleStateAttachRowRepository._();

  Future<void> ioModule(
    _i1.Session session,
    IoModuleState ioModuleState,
    _i2.IoModule ioModule, {
    _i1.Transaction? transaction,
  }) async {
    if (ioModule.id == null) {
      throw ArgumentError.notNull('ioModule.id');
    }
    if (ioModuleState.id == null) {
      throw ArgumentError.notNull('ioModuleState.id');
    }

    var $ioModule = ioModule.copyWith(stateId: ioModuleState.id);
    await session.db.updateRow<_i2.IoModule>(
      $ioModule,
      columns: [_i2.IoModule.t.stateId],
      transaction: transaction,
    );
  }
}
