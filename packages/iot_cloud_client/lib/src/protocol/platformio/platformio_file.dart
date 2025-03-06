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

abstract class PlatformioFile implements _i1.SerializableModel {
  PlatformioFile._({
    required this.name,
    required this.path,
    required this.isDirectory,
    this.size,
    this.lastModified,
  });

  factory PlatformioFile({
    required String name,
    required String path,
    required bool isDirectory,
    int? size,
    DateTime? lastModified,
  }) = _PlatformioFileImpl;

  factory PlatformioFile.fromJson(Map<String, dynamic> jsonSerialization) {
    return PlatformioFile(
      name: jsonSerialization['name'] as String,
      path: jsonSerialization['path'] as String,
      isDirectory: jsonSerialization['isDirectory'] as bool,
      size: jsonSerialization['size'] as int?,
      lastModified: jsonSerialization['lastModified'] == null
          ? null
          : _i1.DateTimeJsonExtension.fromJson(
              jsonSerialization['lastModified']),
    );
  }

  String name;

  String path;

  bool isDirectory;

  int? size;

  DateTime? lastModified;

  /// Returns a shallow copy of this [PlatformioFile]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  PlatformioFile copyWith({
    String? name,
    String? path,
    bool? isDirectory,
    int? size,
    DateTime? lastModified,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'path': path,
      'isDirectory': isDirectory,
      if (size != null) 'size': size,
      if (lastModified != null) 'lastModified': lastModified?.toJson(),
    };
  }

  @override
  String toString() {
    return _i1.SerializationManager.encode(this);
  }
}

class _Undefined {}

class _PlatformioFileImpl extends PlatformioFile {
  _PlatformioFileImpl({
    required String name,
    required String path,
    required bool isDirectory,
    int? size,
    DateTime? lastModified,
  }) : super._(
          name: name,
          path: path,
          isDirectory: isDirectory,
          size: size,
          lastModified: lastModified,
        );

  /// Returns a shallow copy of this [PlatformioFile]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  @override
  PlatformioFile copyWith({
    String? name,
    String? path,
    bool? isDirectory,
    Object? size = _Undefined,
    Object? lastModified = _Undefined,
  }) {
    return PlatformioFile(
      name: name ?? this.name,
      path: path ?? this.path,
      isDirectory: isDirectory ?? this.isDirectory,
      size: size is int? ? size : this.size,
      lastModified:
          lastModified is DateTime? ? lastModified : this.lastModified,
    );
  }
}
