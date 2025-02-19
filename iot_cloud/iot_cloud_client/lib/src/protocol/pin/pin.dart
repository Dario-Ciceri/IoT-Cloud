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
import '../pin/pin_info.dart' as _i2;
import '../pin/pin_type.dart' as _i3;
import '../pin/pin_direction.dart' as _i4;

abstract class Pin implements _i1.SerializableModel {
  Pin._({
    required this.info,
    required this.value,
    required this.type,
    required this.direction,
  });

  factory Pin({
    required _i2.PinInfo info,
    required String value,
    required _i3.PinType type,
    required _i4.PinDirection direction,
  }) = _PinImpl;

  factory Pin.fromJson(Map<String, dynamic> jsonSerialization) {
    return Pin(
      info: _i2.PinInfo.fromJson(
          (jsonSerialization['info'] as Map<String, dynamic>)),
      value: jsonSerialization['value'] as String,
      type: _i3.PinType.fromJson((jsonSerialization['type'] as int)),
      direction:
          _i4.PinDirection.fromJson((jsonSerialization['direction'] as int)),
    );
  }

  _i2.PinInfo info;

  String value;

  _i3.PinType type;

  _i4.PinDirection direction;

  Pin copyWith({
    _i2.PinInfo? info,
    String? value,
    _i3.PinType? type,
    _i4.PinDirection? direction,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      'info': info.toJson(),
      'value': value,
      'type': type.toJson(),
      'direction': direction.toJson(),
    };
  }

  @override
  String toString() {
    return _i1.SerializationManager.encode(this);
  }
}

class _PinImpl extends Pin {
  _PinImpl({
    required _i2.PinInfo info,
    required String value,
    required _i3.PinType type,
    required _i4.PinDirection direction,
  }) : super._(
          info: info,
          value: value,
          type: type,
          direction: direction,
        );

  @override
  Pin copyWith({
    _i2.PinInfo? info,
    String? value,
    _i3.PinType? type,
    _i4.PinDirection? direction,
  }) {
    return Pin(
      info: info ?? this.info.copyWith(),
      value: value ?? this.value,
      type: type ?? this.type,
      direction: direction ?? this.direction,
    );
  }
}
