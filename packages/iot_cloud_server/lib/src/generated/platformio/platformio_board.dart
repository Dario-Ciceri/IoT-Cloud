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

abstract class PlatformioBoard
    implements _i1.SerializableModel, _i1.ProtocolSerialization {
  PlatformioBoard._({
    required this.id,
    required this.name,
    required this.platform,
    required this.frameworks,
    this.vendor,
    this.url,
  });

  factory PlatformioBoard({
    required String id,
    required String name,
    required String platform,
    required List<String> frameworks,
    String? vendor,
    String? url,
  }) = _PlatformioBoardImpl;

  factory PlatformioBoard.fromJson(Map<String, dynamic> jsonSerialization) {
    return PlatformioBoard(
      id: jsonSerialization['id'] as String,
      name: jsonSerialization['name'] as String,
      platform: jsonSerialization['platform'] as String,
      frameworks: (jsonSerialization['frameworks'] as List)
          .map((e) => e as String)
          .toList(),
      vendor: jsonSerialization['vendor'] as String?,
      url: jsonSerialization['url'] as String?,
    );
  }

  String id;

  String name;

  String platform;

  List<String> frameworks;

  String? vendor;

  String? url;

  /// Returns a shallow copy of this [PlatformioBoard]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  PlatformioBoard copyWith({
    String? id,
    String? name,
    String? platform,
    List<String>? frameworks,
    String? vendor,
    String? url,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'platform': platform,
      'frameworks': frameworks.toJson(),
      if (vendor != null) 'vendor': vendor,
      if (url != null) 'url': url,
    };
  }

  @override
  Map<String, dynamic> toJsonForProtocol() {
    return {
      'id': id,
      'name': name,
      'platform': platform,
      'frameworks': frameworks.toJson(),
      if (vendor != null) 'vendor': vendor,
      if (url != null) 'url': url,
    };
  }

  @override
  String toString() {
    return _i1.SerializationManager.encode(this);
  }
}

class _Undefined {}

class _PlatformioBoardImpl extends PlatformioBoard {
  _PlatformioBoardImpl({
    required String id,
    required String name,
    required String platform,
    required List<String> frameworks,
    String? vendor,
    String? url,
  }) : super._(
          id: id,
          name: name,
          platform: platform,
          frameworks: frameworks,
          vendor: vendor,
          url: url,
        );

  /// Returns a shallow copy of this [PlatformioBoard]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  @override
  PlatformioBoard copyWith({
    String? id,
    String? name,
    String? platform,
    List<String>? frameworks,
    Object? vendor = _Undefined,
    Object? url = _Undefined,
  }) {
    return PlatformioBoard(
      id: id ?? this.id,
      name: name ?? this.name,
      platform: platform ?? this.platform,
      frameworks: frameworks ?? this.frameworks.map((e0) => e0).toList(),
      vendor: vendor is String? ? vendor : this.vendor,
      url: url is String? ? url : this.url,
    );
  }
}
