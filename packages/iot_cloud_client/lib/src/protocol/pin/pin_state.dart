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
import '../pin/pin.dart' as _i2;

abstract class PinState implements _i1.SerializableModel {
  PinState._({
    this.id,
    this.pin,
    required this.value,
  });

  factory PinState({
    int? id,
    _i2.Pin? pin,
    required String value,
  }) = _PinStateImpl;

  factory PinState.fromJson(Map<String, dynamic> jsonSerialization) {
    return PinState(
      id: jsonSerialization['id'] as int?,
      pin: jsonSerialization['pin'] == null
          ? null
          : _i2.Pin.fromJson(
              (jsonSerialization['pin'] as Map<String, dynamic>)),
      value: jsonSerialization['value'] as String,
    );
  }

  /// The database id, set if the object has been inserted into the
  /// database or if it has been fetched from the database. Otherwise,
  /// the id will be null.
  int? id;

  _i2.Pin? pin;

  String value;

  PinState copyWith({
    int? id,
    _i2.Pin? pin,
    String? value,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      if (id != null) 'id': id,
      if (pin != null) 'pin': pin?.toJson(),
      'value': value,
    };
  }

  @override
  String toString() {
    return _i1.SerializationManager.encode(this);
  }
}

class _Undefined {}

class _PinStateImpl extends PinState {
  _PinStateImpl({
    int? id,
    _i2.Pin? pin,
    required String value,
  }) : super._(
          id: id,
          pin: pin,
          value: value,
        );

  @override
  PinState copyWith({
    Object? id = _Undefined,
    Object? pin = _Undefined,
    String? value,
  }) {
    return PinState(
      id: id is int? ? id : this.id,
      pin: pin is _i2.Pin? ? pin : this.pin?.copyWith(),
      value: value ?? this.value,
    );
  }
}
