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
import '../io_module/io_module.dart' as _i2;
import '../unit_type.dart' as _i3;

abstract class IoModuleState implements _i1.SerializableModel {
  IoModuleState._({
    this.id,
    this.ioModule,
    required this.value,
    required this.unit,
    required this.createdAt,
    required this.updatedAt,
  });

  factory IoModuleState({
    int? id,
    _i2.IoModule? ioModule,
    required String value,
    required _i3.UnitType unit,
    required DateTime createdAt,
    required DateTime updatedAt,
  }) = _IoModuleStateImpl;

  factory IoModuleState.fromJson(Map<String, dynamic> jsonSerialization) {
    return IoModuleState(
      id: jsonSerialization['id'] as int?,
      ioModule: jsonSerialization['ioModule'] == null
          ? null
          : _i2.IoModule.fromJson(
              (jsonSerialization['ioModule'] as Map<String, dynamic>)),
      value: jsonSerialization['value'] as String,
      unit: _i3.UnitType.fromJson((jsonSerialization['unit'] as int)),
      createdAt:
          _i1.DateTimeJsonExtension.fromJson(jsonSerialization['createdAt']),
      updatedAt:
          _i1.DateTimeJsonExtension.fromJson(jsonSerialization['updatedAt']),
    );
  }

  /// The database id, set if the object has been inserted into the
  /// database or if it has been fetched from the database. Otherwise,
  /// the id will be null.
  int? id;

  _i2.IoModule? ioModule;

  String value;

  _i3.UnitType unit;

  DateTime createdAt;

  DateTime updatedAt;

  IoModuleState copyWith({
    int? id,
    _i2.IoModule? ioModule,
    String? value,
    _i3.UnitType? unit,
    DateTime? createdAt,
    DateTime? updatedAt,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      if (id != null) 'id': id,
      if (ioModule != null) 'ioModule': ioModule?.toJson(),
      'value': value,
      'unit': unit.toJson(),
      'createdAt': createdAt.toJson(),
      'updatedAt': updatedAt.toJson(),
    };
  }

  @override
  String toString() {
    return _i1.SerializationManager.encode(this);
  }
}

class _Undefined {}

class _IoModuleStateImpl extends IoModuleState {
  _IoModuleStateImpl({
    int? id,
    _i2.IoModule? ioModule,
    required String value,
    required _i3.UnitType unit,
    required DateTime createdAt,
    required DateTime updatedAt,
  }) : super._(
          id: id,
          ioModule: ioModule,
          value: value,
          unit: unit,
          createdAt: createdAt,
          updatedAt: updatedAt,
        );

  @override
  IoModuleState copyWith({
    Object? id = _Undefined,
    Object? ioModule = _Undefined,
    String? value,
    _i3.UnitType? unit,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) {
    return IoModuleState(
      id: id is int? ? id : this.id,
      ioModule:
          ioModule is _i2.IoModule? ? ioModule : this.ioModule?.copyWith(),
      value: value ?? this.value,
      unit: unit ?? this.unit,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }
}
