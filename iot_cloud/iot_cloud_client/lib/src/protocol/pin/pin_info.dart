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

abstract class PinInfo implements _i1.SerializableModel {
  PinInfo._({
    required this.name,
    required this.number,
  });

  factory PinInfo({
    required String name,
    required int number,
  }) = _PinInfoImpl;

  factory PinInfo.fromJson(Map<String, dynamic> jsonSerialization) {
    return PinInfo(
      name: jsonSerialization['name'] as String,
      number: jsonSerialization['number'] as int,
    );
  }

  String name;

  int number;

  PinInfo copyWith({
    String? name,
    int? number,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'number': number,
    };
  }

  @override
  String toString() {
    return _i1.SerializationManager.encode(this);
  }
}

class _PinInfoImpl extends PinInfo {
  _PinInfoImpl({
    required String name,
    required int number,
  }) : super._(
          name: name,
          number: number,
        );

  @override
  PinInfo copyWith({
    String? name,
    int? number,
  }) {
    return PinInfo(
      name: name ?? this.name,
      number: number ?? this.number,
    );
  }
}
