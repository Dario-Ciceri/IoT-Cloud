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
import '../io_module/io_module_type.dart' as _i2;
import '../io_module/io_module_subtype.dart' as _i3;

abstract class IoModuleInfo implements _i1.SerializableModel {
  IoModuleInfo._({
    required this.serialId,
    required this.name,
    required this.type,
    required this.subtype,
  });

  factory IoModuleInfo({
    required String serialId,
    required String name,
    required _i2.IoModuleType type,
    required _i3.IoModuleSubType subtype,
  }) = _IoModuleInfoImpl;

  factory IoModuleInfo.fromJson(Map<String, dynamic> jsonSerialization) {
    return IoModuleInfo(
      serialId: jsonSerialization['serialId'] as String,
      name: jsonSerialization['name'] as String,
      type: _i2.IoModuleType.fromJson((jsonSerialization['type'] as int)),
      subtype:
          _i3.IoModuleSubType.fromJson((jsonSerialization['subtype'] as int)),
    );
  }

  String serialId;

  String name;

  _i2.IoModuleType type;

  _i3.IoModuleSubType subtype;

  IoModuleInfo copyWith({
    String? serialId,
    String? name,
    _i2.IoModuleType? type,
    _i3.IoModuleSubType? subtype,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      'serialId': serialId,
      'name': name,
      'type': type.toJson(),
      'subtype': subtype.toJson(),
    };
  }

  @override
  String toString() {
    return _i1.SerializationManager.encode(this);
  }
}

class _IoModuleInfoImpl extends IoModuleInfo {
  _IoModuleInfoImpl({
    required String serialId,
    required String name,
    required _i2.IoModuleType type,
    required _i3.IoModuleSubType subtype,
  }) : super._(
          serialId: serialId,
          name: name,
          type: type,
          subtype: subtype,
        );

  @override
  IoModuleInfo copyWith({
    String? serialId,
    String? name,
    _i2.IoModuleType? type,
    _i3.IoModuleSubType? subtype,
  }) {
    return IoModuleInfo(
      serialId: serialId ?? this.serialId,
      name: name ?? this.name,
      type: type ?? this.type,
      subtype: subtype ?? this.subtype,
    );
  }
}
