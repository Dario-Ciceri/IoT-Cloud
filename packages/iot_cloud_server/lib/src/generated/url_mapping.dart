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

abstract class UrlMapping implements _i1.TableRow, _i1.ProtocolSerialization {
  UrlMapping._({
    this.id,
    required this.shortCode,
    required this.originalUrl,
    this.createdAt,
  });

  factory UrlMapping({
    int? id,
    required String shortCode,
    required String originalUrl,
    DateTime? createdAt,
  }) = _UrlMappingImpl;

  factory UrlMapping.fromJson(Map<String, dynamic> jsonSerialization) {
    return UrlMapping(
      id: jsonSerialization['id'] as int?,
      shortCode: jsonSerialization['shortCode'] as String,
      originalUrl: jsonSerialization['originalUrl'] as String,
      createdAt: jsonSerialization['createdAt'] == null
          ? null
          : _i1.DateTimeJsonExtension.fromJson(jsonSerialization['createdAt']),
    );
  }

  static final t = UrlMappingTable();

  static const db = UrlMappingRepository._();

  @override
  int? id;

  String shortCode;

  String originalUrl;

  DateTime? createdAt;

  @override
  _i1.Table get table => t;

  /// Returns a shallow copy of this [UrlMapping]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  UrlMapping copyWith({
    int? id,
    String? shortCode,
    String? originalUrl,
    DateTime? createdAt,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      if (id != null) 'id': id,
      'shortCode': shortCode,
      'originalUrl': originalUrl,
      if (createdAt != null) 'createdAt': createdAt?.toJson(),
    };
  }

  @override
  Map<String, dynamic> toJsonForProtocol() {
    return {
      if (id != null) 'id': id,
      'shortCode': shortCode,
      'originalUrl': originalUrl,
      if (createdAt != null) 'createdAt': createdAt?.toJson(),
    };
  }

  static UrlMappingInclude include() {
    return UrlMappingInclude._();
  }

  static UrlMappingIncludeList includeList({
    _i1.WhereExpressionBuilder<UrlMappingTable>? where,
    int? limit,
    int? offset,
    _i1.OrderByBuilder<UrlMappingTable>? orderBy,
    bool orderDescending = false,
    _i1.OrderByListBuilder<UrlMappingTable>? orderByList,
    UrlMappingInclude? include,
  }) {
    return UrlMappingIncludeList._(
      where: where,
      limit: limit,
      offset: offset,
      orderBy: orderBy?.call(UrlMapping.t),
      orderDescending: orderDescending,
      orderByList: orderByList?.call(UrlMapping.t),
      include: include,
    );
  }

  @override
  String toString() {
    return _i1.SerializationManager.encode(this);
  }
}

class _Undefined {}

class _UrlMappingImpl extends UrlMapping {
  _UrlMappingImpl({
    int? id,
    required String shortCode,
    required String originalUrl,
    DateTime? createdAt,
  }) : super._(
          id: id,
          shortCode: shortCode,
          originalUrl: originalUrl,
          createdAt: createdAt,
        );

  /// Returns a shallow copy of this [UrlMapping]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  @override
  UrlMapping copyWith({
    Object? id = _Undefined,
    String? shortCode,
    String? originalUrl,
    Object? createdAt = _Undefined,
  }) {
    return UrlMapping(
      id: id is int? ? id : this.id,
      shortCode: shortCode ?? this.shortCode,
      originalUrl: originalUrl ?? this.originalUrl,
      createdAt: createdAt is DateTime? ? createdAt : this.createdAt,
    );
  }
}

class UrlMappingTable extends _i1.Table {
  UrlMappingTable({super.tableRelation}) : super(tableName: 'url_mapping') {
    shortCode = _i1.ColumnString(
      'shortCode',
      this,
    );
    originalUrl = _i1.ColumnString(
      'originalUrl',
      this,
    );
    createdAt = _i1.ColumnDateTime(
      'createdAt',
      this,
    );
  }

  late final _i1.ColumnString shortCode;

  late final _i1.ColumnString originalUrl;

  late final _i1.ColumnDateTime createdAt;

  @override
  List<_i1.Column> get columns => [
        id,
        shortCode,
        originalUrl,
        createdAt,
      ];
}

class UrlMappingInclude extends _i1.IncludeObject {
  UrlMappingInclude._();

  @override
  Map<String, _i1.Include?> get includes => {};

  @override
  _i1.Table get table => UrlMapping.t;
}

class UrlMappingIncludeList extends _i1.IncludeList {
  UrlMappingIncludeList._({
    _i1.WhereExpressionBuilder<UrlMappingTable>? where,
    super.limit,
    super.offset,
    super.orderBy,
    super.orderDescending,
    super.orderByList,
    super.include,
  }) {
    super.where = where?.call(UrlMapping.t);
  }

  @override
  Map<String, _i1.Include?> get includes => include?.includes ?? {};

  @override
  _i1.Table get table => UrlMapping.t;
}

class UrlMappingRepository {
  const UrlMappingRepository._();

  /// Returns a list of [UrlMapping]s matching the given query parameters.
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
  Future<List<UrlMapping>> find(
    _i1.Session session, {
    _i1.WhereExpressionBuilder<UrlMappingTable>? where,
    int? limit,
    int? offset,
    _i1.OrderByBuilder<UrlMappingTable>? orderBy,
    bool orderDescending = false,
    _i1.OrderByListBuilder<UrlMappingTable>? orderByList,
    _i1.Transaction? transaction,
  }) async {
    return session.db.find<UrlMapping>(
      where: where?.call(UrlMapping.t),
      orderBy: orderBy?.call(UrlMapping.t),
      orderByList: orderByList?.call(UrlMapping.t),
      orderDescending: orderDescending,
      limit: limit,
      offset: offset,
      transaction: transaction,
    );
  }

  /// Returns the first matching [UrlMapping] matching the given query parameters.
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
  Future<UrlMapping?> findFirstRow(
    _i1.Session session, {
    _i1.WhereExpressionBuilder<UrlMappingTable>? where,
    int? offset,
    _i1.OrderByBuilder<UrlMappingTable>? orderBy,
    bool orderDescending = false,
    _i1.OrderByListBuilder<UrlMappingTable>? orderByList,
    _i1.Transaction? transaction,
  }) async {
    return session.db.findFirstRow<UrlMapping>(
      where: where?.call(UrlMapping.t),
      orderBy: orderBy?.call(UrlMapping.t),
      orderByList: orderByList?.call(UrlMapping.t),
      orderDescending: orderDescending,
      offset: offset,
      transaction: transaction,
    );
  }

  /// Finds a single [UrlMapping] by its [id] or null if no such row exists.
  Future<UrlMapping?> findById(
    _i1.Session session,
    int id, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.findById<UrlMapping>(
      id,
      transaction: transaction,
    );
  }

  /// Inserts all [UrlMapping]s in the list and returns the inserted rows.
  ///
  /// The returned [UrlMapping]s will have their `id` fields set.
  ///
  /// This is an atomic operation, meaning that if one of the rows fails to
  /// insert, none of the rows will be inserted.
  Future<List<UrlMapping>> insert(
    _i1.Session session,
    List<UrlMapping> rows, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.insert<UrlMapping>(
      rows,
      transaction: transaction,
    );
  }

  /// Inserts a single [UrlMapping] and returns the inserted row.
  ///
  /// The returned [UrlMapping] will have its `id` field set.
  Future<UrlMapping> insertRow(
    _i1.Session session,
    UrlMapping row, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.insertRow<UrlMapping>(
      row,
      transaction: transaction,
    );
  }

  /// Updates all [UrlMapping]s in the list and returns the updated rows. If
  /// [columns] is provided, only those columns will be updated. Defaults to
  /// all columns.
  /// This is an atomic operation, meaning that if one of the rows fails to
  /// update, none of the rows will be updated.
  Future<List<UrlMapping>> update(
    _i1.Session session,
    List<UrlMapping> rows, {
    _i1.ColumnSelections<UrlMappingTable>? columns,
    _i1.Transaction? transaction,
  }) async {
    return session.db.update<UrlMapping>(
      rows,
      columns: columns?.call(UrlMapping.t),
      transaction: transaction,
    );
  }

  /// Updates a single [UrlMapping]. The row needs to have its id set.
  /// Optionally, a list of [columns] can be provided to only update those
  /// columns. Defaults to all columns.
  Future<UrlMapping> updateRow(
    _i1.Session session,
    UrlMapping row, {
    _i1.ColumnSelections<UrlMappingTable>? columns,
    _i1.Transaction? transaction,
  }) async {
    return session.db.updateRow<UrlMapping>(
      row,
      columns: columns?.call(UrlMapping.t),
      transaction: transaction,
    );
  }

  /// Deletes all [UrlMapping]s in the list and returns the deleted rows.
  /// This is an atomic operation, meaning that if one of the rows fail to
  /// be deleted, none of the rows will be deleted.
  Future<List<UrlMapping>> delete(
    _i1.Session session,
    List<UrlMapping> rows, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.delete<UrlMapping>(
      rows,
      transaction: transaction,
    );
  }

  /// Deletes a single [UrlMapping].
  Future<UrlMapping> deleteRow(
    _i1.Session session,
    UrlMapping row, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.deleteRow<UrlMapping>(
      row,
      transaction: transaction,
    );
  }

  /// Deletes all rows matching the [where] expression.
  Future<List<UrlMapping>> deleteWhere(
    _i1.Session session, {
    required _i1.WhereExpressionBuilder<UrlMappingTable> where,
    _i1.Transaction? transaction,
  }) async {
    return session.db.deleteWhere<UrlMapping>(
      where: where(UrlMapping.t),
      transaction: transaction,
    );
  }

  /// Counts the number of rows matching the [where] expression. If omitted,
  /// will return the count of all rows in the table.
  Future<int> count(
    _i1.Session session, {
    _i1.WhereExpressionBuilder<UrlMappingTable>? where,
    int? limit,
    _i1.Transaction? transaction,
  }) async {
    return session.db.count<UrlMapping>(
      where: where?.call(UrlMapping.t),
      limit: limit,
      transaction: transaction,
    );
  }
}
