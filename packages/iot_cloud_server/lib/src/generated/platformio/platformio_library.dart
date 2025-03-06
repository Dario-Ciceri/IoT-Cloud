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

abstract class PlatformioLibrary
    implements _i1.SerializableModel, _i1.ProtocolSerialization {
  PlatformioLibrary._({
    required this.id,
    required this.name,
    required this.description,
    required this.version,
    required this.exampleCount,
    this.authorName,
    this.homepage,
  });

  factory PlatformioLibrary({
    required String id,
    required String name,
    required String description,
    required String version,
    required int exampleCount,
    String? authorName,
    String? homepage,
  }) = _PlatformioLibraryImpl;

  factory PlatformioLibrary.fromJson(Map<String, dynamic> jsonSerialization) {
    return PlatformioLibrary(
      id: jsonSerialization['id'] as String,
      name: jsonSerialization['name'] as String,
      description: jsonSerialization['description'] as String,
      version: jsonSerialization['version'] as String,
      exampleCount: jsonSerialization['exampleCount'] as int,
      authorName: jsonSerialization['authorName'] as String?,
      homepage: jsonSerialization['homepage'] as String?,
    );
  }

  String id;

  String name;

  String description;

  String version;

  int exampleCount;

  String? authorName;

  String? homepage;

  /// Returns a shallow copy of this [PlatformioLibrary]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  PlatformioLibrary copyWith({
    String? id,
    String? name,
    String? description,
    String? version,
    int? exampleCount,
    String? authorName,
    String? homepage,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'description': description,
      'version': version,
      'exampleCount': exampleCount,
      if (authorName != null) 'authorName': authorName,
      if (homepage != null) 'homepage': homepage,
    };
  }

  @override
  Map<String, dynamic> toJsonForProtocol() {
    return {
      'id': id,
      'name': name,
      'description': description,
      'version': version,
      'exampleCount': exampleCount,
      if (authorName != null) 'authorName': authorName,
      if (homepage != null) 'homepage': homepage,
    };
  }

  @override
  String toString() {
    return _i1.SerializationManager.encode(this);
  }
}

class _Undefined {}

class _PlatformioLibraryImpl extends PlatformioLibrary {
  _PlatformioLibraryImpl({
    required String id,
    required String name,
    required String description,
    required String version,
    required int exampleCount,
    String? authorName,
    String? homepage,
  }) : super._(
          id: id,
          name: name,
          description: description,
          version: version,
          exampleCount: exampleCount,
          authorName: authorName,
          homepage: homepage,
        );

  /// Returns a shallow copy of this [PlatformioLibrary]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  @override
  PlatformioLibrary copyWith({
    String? id,
    String? name,
    String? description,
    String? version,
    int? exampleCount,
    Object? authorName = _Undefined,
    Object? homepage = _Undefined,
  }) {
    return PlatformioLibrary(
      id: id ?? this.id,
      name: name ?? this.name,
      description: description ?? this.description,
      version: version ?? this.version,
      exampleCount: exampleCount ?? this.exampleCount,
      authorName: authorName is String? ? authorName : this.authorName,
      homepage: homepage is String? ? homepage : this.homepage,
    );
  }
}
