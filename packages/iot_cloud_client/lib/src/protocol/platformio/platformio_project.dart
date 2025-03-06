/* AUTOMATICALLY GENERATED CODE DO NOT MODIFY */
/*   To generate run: "serverpod generate"    */

// ignore_for_file: implementation_imports
// ignore_for_file: library_private_types_in_public_api
// ignore_for_file: non_constant_identifier_names
// ignore_for_file: public_member_api_docs
// ignore_for_file: type_literal_in_constant_pattern
// ignore_for_file: use_super_parameters

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:serverpod_client/serverpod_client.dart' as _i1;

abstract class PlatformioProject implements _i1.SerializableModel {
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

  /// The database id, set if the object has been inserted into the
  /// database or if it has been fetched from the database. Otherwise,
  /// the id will be null.
  int? id;

  String name;

  String path;

  String? description;

  String? board;

  String? framework;

  DateTime createdAt;

  DateTime updatedAt;

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
