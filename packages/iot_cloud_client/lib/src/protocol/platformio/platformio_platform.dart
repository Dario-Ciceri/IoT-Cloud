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

abstract class PlatformioPlatform implements _i1.SerializableModel {
  PlatformioPlatform._({
    required this.name,
    required this.version,
    required this.packageName,
    required this.title,
    required this.description,
  });

  factory PlatformioPlatform({
    required String name,
    required String version,
    required String packageName,
    required String title,
    required String description,
  }) = _PlatformioPlatformImpl;

  factory PlatformioPlatform.fromJson(Map<String, dynamic> jsonSerialization) {
    return PlatformioPlatform(
      name: jsonSerialization['name'] as String,
      version: jsonSerialization['version'] as String,
      packageName: jsonSerialization['packageName'] as String,
      title: jsonSerialization['title'] as String,
      description: jsonSerialization['description'] as String,
    );
  }

  String name;

  String version;

  String packageName;

  String title;

  String description;

  /// Returns a shallow copy of this [PlatformioPlatform]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  PlatformioPlatform copyWith({
    String? name,
    String? version,
    String? packageName,
    String? title,
    String? description,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'version': version,
      'packageName': packageName,
      'title': title,
      'description': description,
    };
  }

  @override
  String toString() {
    return _i1.SerializationManager.encode(this);
  }
}

class _PlatformioPlatformImpl extends PlatformioPlatform {
  _PlatformioPlatformImpl({
    required String name,
    required String version,
    required String packageName,
    required String title,
    required String description,
  }) : super._(
          name: name,
          version: version,
          packageName: packageName,
          title: title,
          description: description,
        );

  /// Returns a shallow copy of this [PlatformioPlatform]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  @override
  PlatformioPlatform copyWith({
    String? name,
    String? version,
    String? packageName,
    String? title,
    String? description,
  }) {
    return PlatformioPlatform(
      name: name ?? this.name,
      version: version ?? this.version,
      packageName: packageName ?? this.packageName,
      title: title ?? this.title,
      description: description ?? this.description,
    );
  }
}
