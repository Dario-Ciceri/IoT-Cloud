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

abstract class UrlMapping implements _i1.SerializableModel {
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

  /// The database id, set if the object has been inserted into the
  /// database or if it has been fetched from the database. Otherwise,
  /// the id will be null.
  int? id;

  String shortCode;

  String originalUrl;

  DateTime? createdAt;

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
