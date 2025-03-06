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

abstract class PlatformioProject
    implements _i1.TableRow, _i1.ProtocolSerialization {
  PlatformioProject._({
    this.id,
    required this.name,
    required this.path,
    this.description,
    this.board,
    this.framework,
    required this.createdAt,
    required this.updatedAt,
  });

  factory PlatformioProject({
    int? id,
    required String name,
    required String path,
    String? description,
    String? board,
    String? framework,
    required DateTime createdAt,
    required DateTime updatedAt,
  }) = _PlatformioProjectImpl;

  factory PlatformioProject.fromJson(Map<String, dynamic> jsonSerialization) {
    return PlatformioProject(
      id: jsonSerialization['id'] as int?,
      name: jsonSerialization['name'] as String,
      path: jsonSerialization['path'] as String,
      description: jsonSerialization['description'] as String?,
      board: jsonSerialization['board'] as String?,
      framework: jsonSerialization['framework'] as String?,
      createdAt:
          _i1.DateTimeJsonExtension.fromJson(jsonSerialization['createdAt']),
      updatedAt:
          _i1.DateTimeJsonExtension.fromJson(jsonSerialization['updatedAt']),
    );
  }

  static final t = PlatformioProjectTable();

  static const db = PlatformioProjectRepository._();

  @override
  int? id;

  String name;

  String path;

  String? description;

  String? board;

  String? framework;

  DateTime createdAt;

  DateTime updatedAt;

  @override
  _i1.Table get table => t;

  /// Returns a shallow copy of this [PlatformioProject]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  PlatformioProject copyWith({
    int? id,
    String? name,
    String? path,
    String? description,
    String? board,
    String? framework,
    DateTime? createdAt,
    DateTime? updatedAt,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      if (id != null) 'id': id,
      'name': name,
      'path': path,
      if (description != null) 'description': description,
      if (board != null) 'board': board,
      if (framework != null) 'framework': framework,
      'createdAt': createdAt.toJson(),
      'updatedAt': updatedAt.toJson(),
    };
  }

  @override
  Map<String, dynamic> toJsonForProtocol() {
    return {
      if (id != null) 'id': id,
      'name': name,
      'path': path,
      if (description != null) 'description': description,
      if (board != null) 'board': board,
      if (framework != null) 'framework': framework,
      'createdAt': createdAt.toJson(),
      'updatedAt': updatedAt.toJson(),
    };
  }

  static PlatformioProjectInclude include() {
    return PlatformioProjectInclude._();
  }

  static PlatformioProjectIncludeList includeList({
    _i1.WhereExpressionBuilder<PlatformioProjectTable>? where,
    int? limit,
    int? offset,
    _i1.OrderByBuilder<PlatformioProjectTable>? orderBy,
    bool orderDescending = false,
    _i1.OrderByListBuilder<PlatformioProjectTable>? orderByList,
    PlatformioProjectInclude? include,
  }) {
    return PlatformioProjectIncludeList._(
      where: where,
      limit: limit,
      offset: offset,
      orderBy: orderBy?.call(PlatformioProject.t),
      orderDescending: orderDescending,
      orderByList: orderByList?.call(PlatformioProject.t),
      include: include,
    );
  }

  @override
  String toString() {
    return _i1.SerializationManager.encode(this);
  }
}

class _Undefined {}

class _PlatformioProjectImpl extends PlatformioProject {
  _PlatformioProjectImpl({
    int? id,
    required String name,
    required String path,
    String? description,
    String? board,
    String? framework,
    required DateTime createdAt,
    required DateTime updatedAt,
  }) : super._(
          id: id,
          name: name,
          path: path,
          description: description,
          board: board,
          framework: framework,
          createdAt: createdAt,
          updatedAt: updatedAt,
        );

  /// Returns a shallow copy of this [PlatformioProject]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  @override
  PlatformioProject copyWith({
    Object? id = _Undefined,
    String? name,
    String? path,
    Object? description = _Undefined,
    Object? board = _Undefined,
    Object? framework = _Undefined,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) {
    return PlatformioProject(
      id: id is int? ? id : this.id,
      name: name ?? this.name,
      path: path ?? this.path,
      description: description is String? ? description : this.description,
      board: board is String? ? board : this.board,
      framework: framework is String? ? framework : this.framework,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }
}

class PlatformioProjectTable extends _i1.Table {
  PlatformioProjectTable({super.tableRelation})
      : super(tableName: 'platformio_project') {
    name = _i1.ColumnString(
      'name',
      this,
    );
    path = _i1.ColumnString(
      'path',
      this,
    );
    description = _i1.ColumnString(
      'description',
      this,
    );
    board = _i1.ColumnString(
      'board',
      this,
    );
    framework = _i1.ColumnString(
      'framework',
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

  late final _i1.ColumnString name;

  late final _i1.ColumnString path;

  late final _i1.ColumnString description;

  late final _i1.ColumnString board;

  late final _i1.ColumnString framework;

  late final _i1.ColumnDateTime createdAt;

  late final _i1.ColumnDateTime updatedAt;

  @override
  List<_i1.Column> get columns => [
        id,
        name,
        path,
        description,
        board,
        framework,
        createdAt,
        updatedAt,
      ];
}

class PlatformioProjectInclude extends _i1.IncludeObject {
  PlatformioProjectInclude._();

  @override
  Map<String, _i1.Include?> get includes => {};

  @override
  _i1.Table get table => PlatformioProject.t;
}

class PlatformioProjectIncludeList extends _i1.IncludeList {
  PlatformioProjectIncludeList._({
    _i1.WhereExpressionBuilder<PlatformioProjectTable>? where,
    super.limit,
    super.offset,
    super.orderBy,
    super.orderDescending,
    super.orderByList,
    super.include,
  }) {
    super.where = where?.call(PlatformioProject.t);
  }

  @override
  Map<String, _i1.Include?> get includes => include?.includes ?? {};

  @override
  _i1.Table get table => PlatformioProject.t;
}

class PlatformioProjectRepository {
  const PlatformioProjectRepository._();

  /// Returns a list of [PlatformioProject]s matching the given query parameters.
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
  Future<List<PlatformioProject>> find(
    _i1.Session session, {
    _i1.WhereExpressionBuilder<PlatformioProjectTable>? where,
    int? limit,
    int? offset,
    _i1.OrderByBuilder<PlatformioProjectTable>? orderBy,
    bool orderDescending = false,
    _i1.OrderByListBuilder<PlatformioProjectTable>? orderByList,
    _i1.Transaction? transaction,
  }) async {
    return session.db.find<PlatformioProject>(
      where: where?.call(PlatformioProject.t),
      orderBy: orderBy?.call(PlatformioProject.t),
      orderByList: orderByList?.call(PlatformioProject.t),
      orderDescending: orderDescending,
      limit: limit,
      offset: offset,
      transaction: transaction,
    );
  }

  /// Returns the first matching [PlatformioProject] matching the given query parameters.
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
  Future<PlatformioProject?> findFirstRow(
    _i1.Session session, {
    _i1.WhereExpressionBuilder<PlatformioProjectTable>? where,
    int? offset,
    _i1.OrderByBuilder<PlatformioProjectTable>? orderBy,
    bool orderDescending = false,
    _i1.OrderByListBuilder<PlatformioProjectTable>? orderByList,
    _i1.Transaction? transaction,
  }) async {
    return session.db.findFirstRow<PlatformioProject>(
      where: where?.call(PlatformioProject.t),
      orderBy: orderBy?.call(PlatformioProject.t),
      orderByList: orderByList?.call(PlatformioProject.t),
      orderDescending: orderDescending,
      offset: offset,
      transaction: transaction,
    );
  }

  /// Finds a single [PlatformioProject] by its [id] or null if no such row exists.
  Future<PlatformioProject?> findById(
    _i1.Session session,
    int id, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.findById<PlatformioProject>(
      id,
      transaction: transaction,
    );
  }

  /// Inserts all [PlatformioProject]s in the list and returns the inserted rows.
  ///
  /// The returned [PlatformioProject]s will have their `id` fields set.
  ///
  /// This is an atomic operation, meaning that if one of the rows fails to
  /// insert, none of the rows will be inserted.
  Future<List<PlatformioProject>> insert(
    _i1.Session session,
    List<PlatformioProject> rows, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.insert<PlatformioProject>(
      rows,
      transaction: transaction,
    );
  }

  /// Inserts a single [PlatformioProject] and returns the inserted row.
  ///
  /// The returned [PlatformioProject] will have its `id` field set.
  Future<PlatformioProject> insertRow(
    _i1.Session session,
    PlatformioProject row, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.insertRow<PlatformioProject>(
      row,
      transaction: transaction,
    );
  }

  /// Updates all [PlatformioProject]s in the list and returns the updated rows. If
  /// [columns] is provided, only those columns will be updated. Defaults to
  /// all columns.
  /// This is an atomic operation, meaning that if one of the rows fails to
  /// update, none of the rows will be updated.
  Future<List<PlatformioProject>> update(
    _i1.Session session,
    List<PlatformioProject> rows, {
    _i1.ColumnSelections<PlatformioProjectTable>? columns,
    _i1.Transaction? transaction,
  }) async {
    return session.db.update<PlatformioProject>(
      rows,
      columns: columns?.call(PlatformioProject.t),
      transaction: transaction,
    );
  }

  /// Updates a single [PlatformioProject]. The row needs to have its id set.
  /// Optionally, a list of [columns] can be provided to only update those
  /// columns. Defaults to all columns.
  Future<PlatformioProject> updateRow(
    _i1.Session session,
    PlatformioProject row, {
    _i1.ColumnSelections<PlatformioProjectTable>? columns,
    _i1.Transaction? transaction,
  }) async {
    return session.db.updateRow<PlatformioProject>(
      row,
      columns: columns?.call(PlatformioProject.t),
      transaction: transaction,
    );
  }

  /// Deletes all [PlatformioProject]s in the list and returns the deleted rows.
  /// This is an atomic operation, meaning that if one of the rows fail to
  /// be deleted, none of the rows will be deleted.
  Future<List<PlatformioProject>> delete(
    _i1.Session session,
    List<PlatformioProject> rows, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.delete<PlatformioProject>(
      rows,
      transaction: transaction,
    );
  }

  /// Deletes a single [PlatformioProject].
  Future<PlatformioProject> deleteRow(
    _i1.Session session,
    PlatformioProject row, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.deleteRow<PlatformioProject>(
      row,
      transaction: transaction,
    );
  }

  /// Deletes all rows matching the [where] expression.
  Future<List<PlatformioProject>> deleteWhere(
    _i1.Session session, {
    required _i1.WhereExpressionBuilder<PlatformioProjectTable> where,
    _i1.Transaction? transaction,
  }) async {
    return session.db.deleteWhere<PlatformioProject>(
      where: where(PlatformioProject.t),
      transaction: transaction,
    );
  }

  /// Counts the number of rows matching the [where] expression. If omitted,
  /// will return the count of all rows in the table.
  Future<int> count(
    _i1.Session session, {
    _i1.WhereExpressionBuilder<PlatformioProjectTable>? where,
    int? limit,
    _i1.Transaction? transaction,
  }) async {
    return session.db.count<PlatformioProject>(
      where: where?.call(PlatformioProject.t),
      limit: limit,
      transaction: transaction,
    );
  }
}
