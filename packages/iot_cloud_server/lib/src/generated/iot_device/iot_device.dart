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
import '../iot_device/iot_device_type.dart' as _i2;
import '../iot_device/iot_device_state.dart' as _i3;
import '../io_module/io_module.dart' as _i4;
import '../pin/pin.dart' as _i5;

abstract class IotDevice implements _i1.TableRow, _i1.ProtocolSerialization {
  IotDevice._({
    this.id,
    required this.serialId,
    required this.type,
    required this.name,
    required this.fwVersion,
    required this.stateId,
    this.state,
    this.attachedModules,
    this.pins,
    required this.createdAt,
    required this.updatedAt,
  });

  factory IotDevice({
    int? id,
    required String serialId,
    required _i2.IotDeviceType type,
    required String name,
    required String fwVersion,
    required int stateId,
    _i3.IotDeviceState? state,
    List<_i4.IoModule>? attachedModules,
    List<_i5.Pin>? pins,
    required DateTime createdAt,
    required DateTime updatedAt,
  }) = _IotDeviceImpl;

  factory IotDevice.fromJson(Map<String, dynamic> jsonSerialization) {
    return IotDevice(
      id: jsonSerialization['id'] as int?,
      serialId: jsonSerialization['serialId'] as String,
      type: _i2.IotDeviceType.fromJson((jsonSerialization['type'] as int)),
      name: jsonSerialization['name'] as String,
      fwVersion: jsonSerialization['fwVersion'] as String,
      stateId: jsonSerialization['stateId'] as int,
      state: jsonSerialization['state'] == null
          ? null
          : _i3.IotDeviceState.fromJson(
              (jsonSerialization['state'] as Map<String, dynamic>)),
      attachedModules: (jsonSerialization['attachedModules'] as List?)
          ?.map((e) => _i4.IoModule.fromJson((e as Map<String, dynamic>)))
          .toList(),
      pins: (jsonSerialization['pins'] as List?)
          ?.map((e) => _i5.Pin.fromJson((e as Map<String, dynamic>)))
          .toList(),
      createdAt:
          _i1.DateTimeJsonExtension.fromJson(jsonSerialization['createdAt']),
      updatedAt:
          _i1.DateTimeJsonExtension.fromJson(jsonSerialization['updatedAt']),
    );
  }

  static final t = IotDeviceTable();

  static const db = IotDeviceRepository._();

  @override
  int? id;

  String serialId;

  _i2.IotDeviceType type;

  String name;

  String fwVersion;

  int stateId;

  _i3.IotDeviceState? state;

  List<_i4.IoModule>? attachedModules;

  List<_i5.Pin>? pins;

  DateTime createdAt;

  DateTime updatedAt;

  @override
  _i1.Table get table => t;

  /// Returns a shallow copy of this [IotDevice]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  IotDevice copyWith({
    int? id,
    String? serialId,
    _i2.IotDeviceType? type,
    String? name,
    String? fwVersion,
    int? stateId,
    _i3.IotDeviceState? state,
    List<_i4.IoModule>? attachedModules,
    List<_i5.Pin>? pins,
    DateTime? createdAt,
    DateTime? updatedAt,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      if (id != null) 'id': id,
      'serialId': serialId,
      'type': type.toJson(),
      'name': name,
      'fwVersion': fwVersion,
      'stateId': stateId,
      if (state != null) 'state': state?.toJson(),
      if (attachedModules != null)
        'attachedModules':
            attachedModules?.toJson(valueToJson: (v) => v.toJson()),
      if (pins != null) 'pins': pins?.toJson(valueToJson: (v) => v.toJson()),
      'createdAt': createdAt.toJson(),
      'updatedAt': updatedAt.toJson(),
    };
  }

  @override
  Map<String, dynamic> toJsonForProtocol() {
    return {
      if (id != null) 'id': id,
      'serialId': serialId,
      'type': type.toJson(),
      'name': name,
      'fwVersion': fwVersion,
      'stateId': stateId,
      if (state != null) 'state': state?.toJsonForProtocol(),
      if (attachedModules != null)
        'attachedModules':
            attachedModules?.toJson(valueToJson: (v) => v.toJsonForProtocol()),
      if (pins != null)
        'pins': pins?.toJson(valueToJson: (v) => v.toJsonForProtocol()),
      'createdAt': createdAt.toJson(),
      'updatedAt': updatedAt.toJson(),
    };
  }

  static IotDeviceInclude include({
    _i3.IotDeviceStateInclude? state,
    _i4.IoModuleIncludeList? attachedModules,
    _i5.PinIncludeList? pins,
  }) {
    return IotDeviceInclude._(
      state: state,
      attachedModules: attachedModules,
      pins: pins,
    );
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
    required String serialId,
    required _i2.IotDeviceType type,
    required String name,
    required String fwVersion,
    required int stateId,
    _i3.IotDeviceState? state,
    List<_i4.IoModule>? attachedModules,
    List<_i5.Pin>? pins,
    required DateTime createdAt,
    required DateTime updatedAt,
  }) : super._(
          id: id,
          serialId: serialId,
          type: type,
          name: name,
          fwVersion: fwVersion,
          stateId: stateId,
          state: state,
          attachedModules: attachedModules,
          pins: pins,
          createdAt: createdAt,
          updatedAt: updatedAt,
        );

  /// Returns a shallow copy of this [IotDevice]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  @override
  IotDevice copyWith({
    Object? id = _Undefined,
    String? serialId,
    _i2.IotDeviceType? type,
    String? name,
    String? fwVersion,
    int? stateId,
    Object? state = _Undefined,
    Object? attachedModules = _Undefined,
    Object? pins = _Undefined,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) {
    return IotDevice(
      id: id is int? ? id : this.id,
      serialId: serialId ?? this.serialId,
      type: type ?? this.type,
      name: name ?? this.name,
      fwVersion: fwVersion ?? this.fwVersion,
      stateId: stateId ?? this.stateId,
      state: state is _i3.IotDeviceState? ? state : this.state?.copyWith(),
      attachedModules: attachedModules is List<_i4.IoModule>?
          ? attachedModules
          : this.attachedModules?.map((e0) => e0.copyWith()).toList(),
      pins: pins is List<_i5.Pin>?
          ? pins
          : this.pins?.map((e0) => e0.copyWith()).toList(),
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }
}

class IotDeviceTable extends _i1.Table {
  IotDeviceTable({super.tableRelation}) : super(tableName: 'iot_device') {
    serialId = _i1.ColumnString(
      'serialId',
      this,
    );
    type = _i1.ColumnEnum(
      'type',
      this,
      _i1.EnumSerialization.byIndex,
    );
    name = _i1.ColumnString(
      'name',
      this,
    );
    fwVersion = _i1.ColumnString(
      'fwVersion',
      this,
    );
    stateId = _i1.ColumnInt(
      'stateId',
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

  late final _i1.ColumnString serialId;

  late final _i1.ColumnEnum<_i2.IotDeviceType> type;

  late final _i1.ColumnString name;

  late final _i1.ColumnString fwVersion;

  late final _i1.ColumnInt stateId;

  _i3.IotDeviceStateTable? _state;

  _i4.IoModuleTable? ___attachedModules;

  _i1.ManyRelation<_i4.IoModuleTable>? _attachedModules;

  _i5.PinTable? ___pins;

  _i1.ManyRelation<_i5.PinTable>? _pins;

  late final _i1.ColumnDateTime createdAt;

  late final _i1.ColumnDateTime updatedAt;

  _i3.IotDeviceStateTable get state {
    if (_state != null) return _state!;
    _state = _i1.createRelationTable(
      relationFieldName: 'state',
      field: IotDevice.t.stateId,
      foreignField: _i3.IotDeviceState.t.id,
      tableRelation: tableRelation,
      createTable: (foreignTableRelation) =>
          _i3.IotDeviceStateTable(tableRelation: foreignTableRelation),
    );
    return _state!;
  }

  _i4.IoModuleTable get __attachedModules {
    if (___attachedModules != null) return ___attachedModules!;
    ___attachedModules = _i1.createRelationTable(
      relationFieldName: '__attachedModules',
      field: IotDevice.t.id,
      foreignField: _i4.IoModule.t.iotDeviceId,
      tableRelation: tableRelation,
      createTable: (foreignTableRelation) =>
          _i4.IoModuleTable(tableRelation: foreignTableRelation),
    );
    return ___attachedModules!;
  }

  _i5.PinTable get __pins {
    if (___pins != null) return ___pins!;
    ___pins = _i1.createRelationTable(
      relationFieldName: '__pins',
      field: IotDevice.t.id,
      foreignField: _i5.Pin.t.iotDeviceId,
      tableRelation: tableRelation,
      createTable: (foreignTableRelation) =>
          _i5.PinTable(tableRelation: foreignTableRelation),
    );
    return ___pins!;
  }

  _i1.ManyRelation<_i4.IoModuleTable> get attachedModules {
    if (_attachedModules != null) return _attachedModules!;
    var relationTable = _i1.createRelationTable(
      relationFieldName: 'attachedModules',
      field: IotDevice.t.id,
      foreignField: _i4.IoModule.t.iotDeviceId,
      tableRelation: tableRelation,
      createTable: (foreignTableRelation) =>
          _i4.IoModuleTable(tableRelation: foreignTableRelation),
    );
    _attachedModules = _i1.ManyRelation<_i4.IoModuleTable>(
      tableWithRelations: relationTable,
      table: _i4.IoModuleTable(
          tableRelation: relationTable.tableRelation!.lastRelation),
    );
    return _attachedModules!;
  }

  _i1.ManyRelation<_i5.PinTable> get pins {
    if (_pins != null) return _pins!;
    var relationTable = _i1.createRelationTable(
      relationFieldName: 'pins',
      field: IotDevice.t.id,
      foreignField: _i5.Pin.t.iotDeviceId,
      tableRelation: tableRelation,
      createTable: (foreignTableRelation) =>
          _i5.PinTable(tableRelation: foreignTableRelation),
    );
    _pins = _i1.ManyRelation<_i5.PinTable>(
      tableWithRelations: relationTable,
      table: _i5.PinTable(
          tableRelation: relationTable.tableRelation!.lastRelation),
    );
    return _pins!;
  }

  @override
  List<_i1.Column> get columns => [
        id,
        serialId,
        type,
        name,
        fwVersion,
        stateId,
        createdAt,
        updatedAt,
      ];

  @override
  _i1.Table? getRelationTable(String relationField) {
    if (relationField == 'state') {
      return state;
    }
    if (relationField == 'attachedModules') {
      return __attachedModules;
    }
    if (relationField == 'pins') {
      return __pins;
    }
    return null;
  }
}

class IotDeviceInclude extends _i1.IncludeObject {
  IotDeviceInclude._({
    _i3.IotDeviceStateInclude? state,
    _i4.IoModuleIncludeList? attachedModules,
    _i5.PinIncludeList? pins,
  }) {
    _state = state;
    _attachedModules = attachedModules;
    _pins = pins;
  }

  _i3.IotDeviceStateInclude? _state;

  _i4.IoModuleIncludeList? _attachedModules;

  _i5.PinIncludeList? _pins;

  @override
  Map<String, _i1.Include?> get includes => {
        'state': _state,
        'attachedModules': _attachedModules,
        'pins': _pins,
      };

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

  final attach = const IotDeviceAttachRepository._();

  final attachRow = const IotDeviceAttachRowRepository._();

  final detach = const IotDeviceDetachRepository._();

  final detachRow = const IotDeviceDetachRowRepository._();

  /// Returns a list of [IotDevice]s matching the given query parameters.
  ///
  /// Use [where] to specify which items to include in the return value.
  /// If none is specified, all items will be returned.
  ///
  /// To specify the order of the items use [orderBy] or [orderByList]
  /// when sorting by multiple columns.
  ///
  /// The maximum number of items can be set by [limit]. If no limit is set,
  /// all items matching the query will be returned.
  ///
  /// [offset] defines how many items to skip, after which [limit] (or all)
  /// items are read from the database.
  ///
  /// ```dart
  /// var persons = await Persons.db.find(
  ///   session,
  ///   where: (t) => t.lastName.equals('Jones'),
  ///   orderBy: (t) => t.firstName,
  ///   limit: 100,
  /// );
  /// ```
  Future<List<IotDevice>> find(
    _i1.Session session, {
    _i1.WhereExpressionBuilder<IotDeviceTable>? where,
    int? limit,
    int? offset,
    _i1.OrderByBuilder<IotDeviceTable>? orderBy,
    bool orderDescending = false,
    _i1.OrderByListBuilder<IotDeviceTable>? orderByList,
    _i1.Transaction? transaction,
    IotDeviceInclude? include,
  }) async {
    return session.db.find<IotDevice>(
      where: where?.call(IotDevice.t),
      orderBy: orderBy?.call(IotDevice.t),
      orderByList: orderByList?.call(IotDevice.t),
      orderDescending: orderDescending,
      limit: limit,
      offset: offset,
      transaction: transaction,
      include: include,
    );
  }

  /// Returns the first matching [IotDevice] matching the given query parameters.
  ///
  /// Use [where] to specify which items to include in the return value.
  /// If none is specified, all items will be returned.
  ///
  /// To specify the order use [orderBy] or [orderByList]
  /// when sorting by multiple columns.
  ///
  /// [offset] defines how many items to skip, after which the next one will be picked.
  ///
  /// ```dart
  /// var youngestPerson = await Persons.db.findFirstRow(
  ///   session,
  ///   where: (t) => t.lastName.equals('Jones'),
  ///   orderBy: (t) => t.age,
  /// );
  /// ```
  Future<IotDevice?> findFirstRow(
    _i1.Session session, {
    _i1.WhereExpressionBuilder<IotDeviceTable>? where,
    int? offset,
    _i1.OrderByBuilder<IotDeviceTable>? orderBy,
    bool orderDescending = false,
    _i1.OrderByListBuilder<IotDeviceTable>? orderByList,
    _i1.Transaction? transaction,
    IotDeviceInclude? include,
  }) async {
    return session.db.findFirstRow<IotDevice>(
      where: where?.call(IotDevice.t),
      orderBy: orderBy?.call(IotDevice.t),
      orderByList: orderByList?.call(IotDevice.t),
      orderDescending: orderDescending,
      offset: offset,
      transaction: transaction,
      include: include,
    );
  }

  /// Finds a single [IotDevice] by its [id] or null if no such row exists.
  Future<IotDevice?> findById(
    _i1.Session session,
    int id, {
    _i1.Transaction? transaction,
    IotDeviceInclude? include,
  }) async {
    return session.db.findById<IotDevice>(
      id,
      transaction: transaction,
      include: include,
    );
  }

  /// Inserts all [IotDevice]s in the list and returns the inserted rows.
  ///
  /// The returned [IotDevice]s will have their `id` fields set.
  ///
  /// This is an atomic operation, meaning that if one of the rows fails to
  /// insert, none of the rows will be inserted.
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

  /// Inserts a single [IotDevice] and returns the inserted row.
  ///
  /// The returned [IotDevice] will have its `id` field set.
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

  /// Updates all [IotDevice]s in the list and returns the updated rows. If
  /// [columns] is provided, only those columns will be updated. Defaults to
  /// all columns.
  /// This is an atomic operation, meaning that if one of the rows fails to
  /// update, none of the rows will be updated.
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

  /// Updates a single [IotDevice]. The row needs to have its id set.
  /// Optionally, a list of [columns] can be provided to only update those
  /// columns. Defaults to all columns.
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

  /// Deletes all [IotDevice]s in the list and returns the deleted rows.
  /// This is an atomic operation, meaning that if one of the rows fail to
  /// be deleted, none of the rows will be deleted.
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

  /// Deletes a single [IotDevice].
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

  /// Deletes all rows matching the [where] expression.
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

  /// Counts the number of rows matching the [where] expression. If omitted,
  /// will return the count of all rows in the table.
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

class IotDeviceAttachRepository {
  const IotDeviceAttachRepository._();

  /// Creates a relation between this [IotDevice] and the given [IoModule]s
  /// by setting each [IoModule]'s foreign key `iotDeviceId` to refer to this [IotDevice].
  Future<void> attachedModules(
    _i1.Session session,
    IotDevice iotDevice,
    List<_i4.IoModule> ioModule, {
    _i1.Transaction? transaction,
  }) async {
    if (ioModule.any((e) => e.id == null)) {
      throw ArgumentError.notNull('ioModule.id');
    }
    if (iotDevice.id == null) {
      throw ArgumentError.notNull('iotDevice.id');
    }

    var $ioModule =
        ioModule.map((e) => e.copyWith(iotDeviceId: iotDevice.id)).toList();
    await session.db.update<_i4.IoModule>(
      $ioModule,
      columns: [_i4.IoModule.t.iotDeviceId],
      transaction: transaction,
    );
  }

  /// Creates a relation between this [IotDevice] and the given [Pin]s
  /// by setting each [Pin]'s foreign key `iotDeviceId` to refer to this [IotDevice].
  Future<void> pins(
    _i1.Session session,
    IotDevice iotDevice,
    List<_i5.Pin> pin, {
    _i1.Transaction? transaction,
  }) async {
    if (pin.any((e) => e.id == null)) {
      throw ArgumentError.notNull('pin.id');
    }
    if (iotDevice.id == null) {
      throw ArgumentError.notNull('iotDevice.id');
    }

    var $pin = pin.map((e) => e.copyWith(iotDeviceId: iotDevice.id)).toList();
    await session.db.update<_i5.Pin>(
      $pin,
      columns: [_i5.Pin.t.iotDeviceId],
      transaction: transaction,
    );
  }
}

class IotDeviceAttachRowRepository {
  const IotDeviceAttachRowRepository._();

  /// Creates a relation between the given [IotDevice] and [IotDeviceState]
  /// by setting the [IotDevice]'s foreign key `stateId` to refer to the [IotDeviceState].
  Future<void> state(
    _i1.Session session,
    IotDevice iotDevice,
    _i3.IotDeviceState state, {
    _i1.Transaction? transaction,
  }) async {
    if (iotDevice.id == null) {
      throw ArgumentError.notNull('iotDevice.id');
    }
    if (state.id == null) {
      throw ArgumentError.notNull('state.id');
    }

    var $iotDevice = iotDevice.copyWith(stateId: state.id);
    await session.db.updateRow<IotDevice>(
      $iotDevice,
      columns: [IotDevice.t.stateId],
      transaction: transaction,
    );
  }

  /// Creates a relation between this [IotDevice] and the given [IoModule]
  /// by setting the [IoModule]'s foreign key `iotDeviceId` to refer to this [IotDevice].
  Future<void> attachedModules(
    _i1.Session session,
    IotDevice iotDevice,
    _i4.IoModule ioModule, {
    _i1.Transaction? transaction,
  }) async {
    if (ioModule.id == null) {
      throw ArgumentError.notNull('ioModule.id');
    }
    if (iotDevice.id == null) {
      throw ArgumentError.notNull('iotDevice.id');
    }

    var $ioModule = ioModule.copyWith(iotDeviceId: iotDevice.id);
    await session.db.updateRow<_i4.IoModule>(
      $ioModule,
      columns: [_i4.IoModule.t.iotDeviceId],
      transaction: transaction,
    );
  }

  /// Creates a relation between this [IotDevice] and the given [Pin]
  /// by setting the [Pin]'s foreign key `iotDeviceId` to refer to this [IotDevice].
  Future<void> pins(
    _i1.Session session,
    IotDevice iotDevice,
    _i5.Pin pin, {
    _i1.Transaction? transaction,
  }) async {
    if (pin.id == null) {
      throw ArgumentError.notNull('pin.id');
    }
    if (iotDevice.id == null) {
      throw ArgumentError.notNull('iotDevice.id');
    }

    var $pin = pin.copyWith(iotDeviceId: iotDevice.id);
    await session.db.updateRow<_i5.Pin>(
      $pin,
      columns: [_i5.Pin.t.iotDeviceId],
      transaction: transaction,
    );
  }
}

class IotDeviceDetachRepository {
  const IotDeviceDetachRepository._();

  /// Detaches the relation between this [IotDevice] and the given [Pin]
  /// by setting the [Pin]'s foreign key `iotDeviceId` to `null`.
  ///
  /// This removes the association between the two models without deleting
  /// the related record.
  Future<void> pins(
    _i1.Session session,
    List<_i5.Pin> pin, {
    _i1.Transaction? transaction,
  }) async {
    if (pin.any((e) => e.id == null)) {
      throw ArgumentError.notNull('pin.id');
    }

    var $pin = pin.map((e) => e.copyWith(iotDeviceId: null)).toList();
    await session.db.update<_i5.Pin>(
      $pin,
      columns: [_i5.Pin.t.iotDeviceId],
      transaction: transaction,
    );
  }
}

class IotDeviceDetachRowRepository {
  const IotDeviceDetachRowRepository._();

  /// Detaches the relation between this [IotDevice] and the given [Pin]
  /// by setting the [Pin]'s foreign key `iotDeviceId` to `null`.
  ///
  /// This removes the association between the two models without deleting
  /// the related record.
  Future<void> pins(
    _i1.Session session,
    _i5.Pin pin, {
    _i1.Transaction? transaction,
  }) async {
    if (pin.id == null) {
      throw ArgumentError.notNull('pin.id');
    }

    var $pin = pin.copyWith(iotDeviceId: null);
    await session.db.updateRow<_i5.Pin>(
      $pin,
      columns: [_i5.Pin.t.iotDeviceId],
      transaction: transaction,
    );
  }
}
