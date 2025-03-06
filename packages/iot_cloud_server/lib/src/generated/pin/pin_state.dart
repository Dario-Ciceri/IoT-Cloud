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
import '../pin/pin.dart' as _i2;

abstract class PinState implements _i1.TableRow, _i1.ProtocolSerialization {
  PinState._({
    this.id,
    this.pin,
    required this.value,
  });

  factory PinState({
    int? id,
    _i2.Pin? pin,
    required String value,
  }) = _PinStateImpl;

  factory PinState.fromJson(Map<String, dynamic> jsonSerialization) {
    return PinState(
      id: jsonSerialization['id'] as int?,
      pin: jsonSerialization['pin'] == null
          ? null
          : _i2.Pin.fromJson(
              (jsonSerialization['pin'] as Map<String, dynamic>)),
      value: jsonSerialization['value'] as String,
    );
  }

  static final t = PinStateTable();

  static const db = PinStateRepository._();

  @override
  int? id;

  _i2.Pin? pin;

  String value;

  @override
  _i1.Table get table => t;

  /// Returns a shallow copy of this [PinState]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  PinState copyWith({
    int? id,
    _i2.Pin? pin,
    String? value,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      if (id != null) 'id': id,
      if (pin != null) 'pin': pin?.toJson(),
      'value': value,
    };
  }

  @override
  Map<String, dynamic> toJsonForProtocol() {
    return {
      if (id != null) 'id': id,
      if (pin != null) 'pin': pin?.toJsonForProtocol(),
      'value': value,
    };
  }

  static PinStateInclude include({_i2.PinInclude? pin}) {
    return PinStateInclude._(pin: pin);
  }

  static PinStateIncludeList includeList({
    _i1.WhereExpressionBuilder<PinStateTable>? where,
    int? limit,
    int? offset,
    _i1.OrderByBuilder<PinStateTable>? orderBy,
    bool orderDescending = false,
    _i1.OrderByListBuilder<PinStateTable>? orderByList,
    PinStateInclude? include,
  }) {
    return PinStateIncludeList._(
      where: where,
      limit: limit,
      offset: offset,
      orderBy: orderBy?.call(PinState.t),
      orderDescending: orderDescending,
      orderByList: orderByList?.call(PinState.t),
      include: include,
    );
  }

  @override
  String toString() {
    return _i1.SerializationManager.encode(this);
  }
}

class _Undefined {}

class _PinStateImpl extends PinState {
  _PinStateImpl({
    int? id,
    _i2.Pin? pin,
    required String value,
  }) : super._(
          id: id,
          pin: pin,
          value: value,
        );

  /// Returns a shallow copy of this [PinState]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  @override
  PinState copyWith({
    Object? id = _Undefined,
    Object? pin = _Undefined,
    String? value,
  }) {
    return PinState(
      id: id is int? ? id : this.id,
      pin: pin is _i2.Pin? ? pin : this.pin?.copyWith(),
      value: value ?? this.value,
    );
  }
}

class PinStateTable extends _i1.Table {
  PinStateTable({super.tableRelation}) : super(tableName: 'pin_state') {
    value = _i1.ColumnString(
      'value',
      this,
    );
  }

  _i2.PinTable? _pin;

  late final _i1.ColumnString value;

  _i2.PinTable get pin {
    if (_pin != null) return _pin!;
    _pin = _i1.createRelationTable(
      relationFieldName: 'pin',
      field: PinState.t.id,
      foreignField: _i2.Pin.t.stateId,
      tableRelation: tableRelation,
      createTable: (foreignTableRelation) =>
          _i2.PinTable(tableRelation: foreignTableRelation),
    );
    return _pin!;
  }

  @override
  List<_i1.Column> get columns => [
        id,
        value,
      ];

  @override
  _i1.Table? getRelationTable(String relationField) {
    if (relationField == 'pin') {
      return pin;
    }
    return null;
  }
}

class PinStateInclude extends _i1.IncludeObject {
  PinStateInclude._({_i2.PinInclude? pin}) {
    _pin = pin;
  }

  _i2.PinInclude? _pin;

  @override
  Map<String, _i1.Include?> get includes => {'pin': _pin};

  @override
  _i1.Table get table => PinState.t;
}

class PinStateIncludeList extends _i1.IncludeList {
  PinStateIncludeList._({
    _i1.WhereExpressionBuilder<PinStateTable>? where,
    super.limit,
    super.offset,
    super.orderBy,
    super.orderDescending,
    super.orderByList,
    super.include,
  }) {
    super.where = where?.call(PinState.t);
  }

  @override
  Map<String, _i1.Include?> get includes => include?.includes ?? {};

  @override
  _i1.Table get table => PinState.t;
}

class PinStateRepository {
  const PinStateRepository._();

  final attachRow = const PinStateAttachRowRepository._();

  /// Returns a list of [PinState]s matching the given query parameters.
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
  Future<List<PinState>> find(
    _i1.Session session, {
    _i1.WhereExpressionBuilder<PinStateTable>? where,
    int? limit,
    int? offset,
    _i1.OrderByBuilder<PinStateTable>? orderBy,
    bool orderDescending = false,
    _i1.OrderByListBuilder<PinStateTable>? orderByList,
    _i1.Transaction? transaction,
    PinStateInclude? include,
  }) async {
    return session.db.find<PinState>(
      where: where?.call(PinState.t),
      orderBy: orderBy?.call(PinState.t),
      orderByList: orderByList?.call(PinState.t),
      orderDescending: orderDescending,
      limit: limit,
      offset: offset,
      transaction: transaction,
      include: include,
    );
  }

  /// Returns the first matching [PinState] matching the given query parameters.
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
  Future<PinState?> findFirstRow(
    _i1.Session session, {
    _i1.WhereExpressionBuilder<PinStateTable>? where,
    int? offset,
    _i1.OrderByBuilder<PinStateTable>? orderBy,
    bool orderDescending = false,
    _i1.OrderByListBuilder<PinStateTable>? orderByList,
    _i1.Transaction? transaction,
    PinStateInclude? include,
  }) async {
    return session.db.findFirstRow<PinState>(
      where: where?.call(PinState.t),
      orderBy: orderBy?.call(PinState.t),
      orderByList: orderByList?.call(PinState.t),
      orderDescending: orderDescending,
      offset: offset,
      transaction: transaction,
      include: include,
    );
  }

  /// Finds a single [PinState] by its [id] or null if no such row exists.
  Future<PinState?> findById(
    _i1.Session session,
    int id, {
    _i1.Transaction? transaction,
    PinStateInclude? include,
  }) async {
    return session.db.findById<PinState>(
      id,
      transaction: transaction,
      include: include,
    );
  }

  /// Inserts all [PinState]s in the list and returns the inserted rows.
  ///
  /// The returned [PinState]s will have their `id` fields set.
  ///
  /// This is an atomic operation, meaning that if one of the rows fails to
  /// insert, none of the rows will be inserted.
  Future<List<PinState>> insert(
    _i1.Session session,
    List<PinState> rows, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.insert<PinState>(
      rows,
      transaction: transaction,
    );
  }

  /// Inserts a single [PinState] and returns the inserted row.
  ///
  /// The returned [PinState] will have its `id` field set.
  Future<PinState> insertRow(
    _i1.Session session,
    PinState row, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.insertRow<PinState>(
      row,
      transaction: transaction,
    );
  }

  /// Updates all [PinState]s in the list and returns the updated rows. If
  /// [columns] is provided, only those columns will be updated. Defaults to
  /// all columns.
  /// This is an atomic operation, meaning that if one of the rows fails to
  /// update, none of the rows will be updated.
  Future<List<PinState>> update(
    _i1.Session session,
    List<PinState> rows, {
    _i1.ColumnSelections<PinStateTable>? columns,
    _i1.Transaction? transaction,
  }) async {
    return session.db.update<PinState>(
      rows,
      columns: columns?.call(PinState.t),
      transaction: transaction,
    );
  }

  /// Updates a single [PinState]. The row needs to have its id set.
  /// Optionally, a list of [columns] can be provided to only update those
  /// columns. Defaults to all columns.
  Future<PinState> updateRow(
    _i1.Session session,
    PinState row, {
    _i1.ColumnSelections<PinStateTable>? columns,
    _i1.Transaction? transaction,
  }) async {
    return session.db.updateRow<PinState>(
      row,
      columns: columns?.call(PinState.t),
      transaction: transaction,
    );
  }

  /// Deletes all [PinState]s in the list and returns the deleted rows.
  /// This is an atomic operation, meaning that if one of the rows fail to
  /// be deleted, none of the rows will be deleted.
  Future<List<PinState>> delete(
    _i1.Session session,
    List<PinState> rows, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.delete<PinState>(
      rows,
      transaction: transaction,
    );
  }

  /// Deletes a single [PinState].
  Future<PinState> deleteRow(
    _i1.Session session,
    PinState row, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.deleteRow<PinState>(
      row,
      transaction: transaction,
    );
  }

  /// Deletes all rows matching the [where] expression.
  Future<List<PinState>> deleteWhere(
    _i1.Session session, {
    required _i1.WhereExpressionBuilder<PinStateTable> where,
    _i1.Transaction? transaction,
  }) async {
    return session.db.deleteWhere<PinState>(
      where: where(PinState.t),
      transaction: transaction,
    );
  }

  /// Counts the number of rows matching the [where] expression. If omitted,
  /// will return the count of all rows in the table.
  Future<int> count(
    _i1.Session session, {
    _i1.WhereExpressionBuilder<PinStateTable>? where,
    int? limit,
    _i1.Transaction? transaction,
  }) async {
    return session.db.count<PinState>(
      where: where?.call(PinState.t),
      limit: limit,
      transaction: transaction,
    );
  }
}

class PinStateAttachRowRepository {
  const PinStateAttachRowRepository._();

  /// Creates a relation between the given [PinState] and [Pin]
  /// by setting the [PinState]'s foreign key `id` to refer to the [Pin].
  Future<void> pin(
    _i1.Session session,
    PinState pinState,
    _i2.Pin pin, {
    _i1.Transaction? transaction,
  }) async {
    if (pin.id == null) {
      throw ArgumentError.notNull('pin.id');
    }
    if (pinState.id == null) {
      throw ArgumentError.notNull('pinState.id');
    }

    var $pin = pin.copyWith(stateId: pinState.id);
    await session.db.updateRow<_i2.Pin>(
      $pin,
      columns: [_i2.Pin.t.stateId],
      transaction: transaction,
    );
  }
}
