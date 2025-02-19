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
import '../unit_type.dart' as _i2;

abstract class IoModuleState implements _i1.SerializableModel {
  IoModuleState._({
    required this.value,
    required this.unit,
  });

  factory IoModuleState({
    required String value,
    required _i2.UnitType unit,
  }) = _IoModuleStateImpl;

  factory IoModuleState.fromJson(Map<String, dynamic> jsonSerialization) {
    return IoModuleState(
      value: jsonSerialization['value'] as String,
      unit: _i2.UnitType.fromJson((jsonSerialization['unit'] as int)),
    );
  }

  String value;

  _i2.UnitType unit;

  IoModuleState copyWith({
    String? value,
    _i2.UnitType? unit,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      'value': value,
      'unit': unit.toJson(),
    };
  }

  @override
  String toString() {
    return _i1.SerializationManager.encode(this);
  }
}

class _IoModuleStateImpl extends IoModuleState {
  _IoModuleStateImpl({
    required String value,
    required _i2.UnitType unit,
  }) : super._(
          value: value,
          unit: unit,
        );

  @override
  IoModuleState copyWith({
    String? value,
    _i2.UnitType? unit,
  }) {
    return IoModuleState(
      value: value ?? this.value,
      unit: unit ?? this.unit,
    );
  }
}
