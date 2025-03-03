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
import '../iot_device/iot_device.dart' as _i2;
import '../pin/pin_direction.dart' as _i3;
import '../pin/pin_type.dart' as _i4;
import '../pin/pin_state.dart' as _i5;

abstract class Pin implements _i1.TableRow, _i1.ProtocolSerialization {
  Pin._({
    this.id,
    required this.iotDeviceId,
    this.iotDevice,
    required this.name,
    required this.number,
    required this.direction,
    required this.properties,
    required this.stateId,
    this.state,
    required this.createdAt,
    required this.updatedAt,
  });

  factory Pin({
    int? id,
    required int iotDeviceId,
    _i2.IotDevice? iotDevice,
    required String name,
    required int number,
    required _i3.PinDirection direction,
    required List<_i4.PinProperty> properties,
    required int stateId,
    _i5.PinState? state,
    required DateTime createdAt,
    required DateTime updatedAt,
  }) = _PinImpl;

  factory Pin.fromJson(Map<String, dynamic> jsonSerialization) {
    return Pin(
      id: jsonSerialization['id'] as int?,
      iotDeviceId: jsonSerialization['iotDeviceId'] as int,
      iotDevice: jsonSerialization['iotDevice'] == null
          ? null
          : _i2.IotDevice.fromJson(
              (jsonSerialization['iotDevice'] as Map<String, dynamic>)),
      name: jsonSerialization['name'] as String,
      number: jsonSerialization['number'] as int,
      direction:
          _i3.PinDirection.fromJson((jsonSerialization['direction'] as int)),
      properties: (jsonSerialization['properties'] as List)
          .map((e) => _i4.PinProperty.fromJson((e as int)))
          .toList(),
      stateId: jsonSerialization['stateId'] as int,
      state: jsonSerialization['state'] == null
          ? null
          : _i5.PinState.fromJson(
              (jsonSerialization['state'] as Map<String, dynamic>)),
      createdAt:
          _i1.DateTimeJsonExtension.fromJson(jsonSerialization['createdAt']),
      updatedAt:
          _i1.DateTimeJsonExtension.fromJson(jsonSerialization['updatedAt']),
    );
  }

  static final t = PinTable();

  static const db = PinRepository._();

  @override
  int? id;

  int iotDeviceId;

  _i2.IotDevice? iotDevice;

  String name;

  int number;

  _i3.PinDirection direction;

  List<_i4.PinProperty> properties;

  int stateId;

  _i5.PinState? state;

  DateTime createdAt;

  DateTime updatedAt;

  @override
  _i1.Table get table => t;

  Pin copyWith({
    int? id,
    int? iotDeviceId,
    _i2.IotDevice? iotDevice,
    String? name,
    int? number,
    _i3.PinDirection? direction,
    List<_i4.PinProperty>? properties,
    int? stateId,
    _i5.PinState? state,
    DateTime? createdAt,
    DateTime? updatedAt,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      if (id != null) 'id': id,
      'iotDeviceId': iotDeviceId,
      if (iotDevice != null) 'iotDevice': iotDevice?.toJson(),
      'name': name,
      'number': number,
      'direction': direction.toJson(),
      'properties': properties.toJson(valueToJson: (v) => v.toJson()),
      'stateId': stateId,
      if (state != null) 'state': state?.toJson(),
      'createdAt': createdAt.toJson(),
      'updatedAt': updatedAt.toJson(),
    };
  }

  @override
  Map<String, dynamic> toJsonForProtocol() {
    return {
      if (id != null) 'id': id,
      'iotDeviceId': iotDeviceId,
      if (iotDevice != null) 'iotDevice': iotDevice?.toJsonForProtocol(),
      'name': name,
      'number': number,
      'direction': direction.toJson(),
      'properties': properties.toJson(valueToJson: (v) => v.toJson()),
      'stateId': stateId,
      if (state != null) 'state': state?.toJsonForProtocol(),
      'createdAt': createdAt.toJson(),
      'updatedAt': updatedAt.toJson(),
    };
  }

  static PinInclude include({
    _i2.IotDeviceInclude? iotDevice,
    _i5.PinStateInclude? state,
  }) {
    return PinInclude._(
      iotDevice: iotDevice,
      state: state,
    );
  }

  static PinIncludeList includeList({
    _i1.WhereExpressionBuilder<PinTable>? where,
    int? limit,
    int? offset,
    _i1.OrderByBuilder<PinTable>? orderBy,
    bool orderDescending = false,
    _i1.OrderByListBuilder<PinTable>? orderByList,
    PinInclude? include,
  }) {
    return PinIncludeList._(
      where: where,
      limit: limit,
      offset: offset,
      orderBy: orderBy?.call(Pin.t),
      orderDescending: orderDescending,
      orderByList: orderByList?.call(Pin.t),
      include: include,
    );
  }

  @override
  String toString() {
    return _i1.SerializationManager.encode(this);
  }
}

class _Undefined {}

class _PinImpl extends Pin {
  _PinImpl({
    int? id,
    required int iotDeviceId,
    _i2.IotDevice? iotDevice,
    required String name,
    required int number,
    required _i3.PinDirection direction,
    required List<_i4.PinProperty> properties,
    required int stateId,
    _i5.PinState? state,
    required DateTime createdAt,
    required DateTime updatedAt,
  }) : super._(
          id: id,
          iotDeviceId: iotDeviceId,
          iotDevice: iotDevice,
          name: name,
          number: number,
          direction: direction,
          properties: properties,
          stateId: stateId,
          state: state,
          createdAt: createdAt,
          updatedAt: updatedAt,
        );

  @override
  Pin copyWith({
    Object? id = _Undefined,
    int? iotDeviceId,
    Object? iotDevice = _Undefined,
    String? name,
    int? number,
    _i3.PinDirection? direction,
    List<_i4.PinProperty>? properties,
    int? stateId,
    Object? state = _Undefined,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) {
    return Pin(
      id: id is int? ? id : this.id,
      iotDeviceId: iotDeviceId ?? this.iotDeviceId,
      iotDevice:
          iotDevice is _i2.IotDevice? ? iotDevice : this.iotDevice?.copyWith(),
      name: name ?? this.name,
      number: number ?? this.number,
      direction: direction ?? this.direction,
      properties: properties ?? this.properties.map((e0) => e0).toList(),
      stateId: stateId ?? this.stateId,
      state: state is _i5.PinState? ? state : this.state?.copyWith(),
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }
}

class PinTable extends _i1.Table {
  PinTable({super.tableRelation}) : super(tableName: 'pin') {
    iotDeviceId = _i1.ColumnInt(
      'iotDeviceId',
      this,
    );
    name = _i1.ColumnString(
      'name',
      this,
    );
    number = _i1.ColumnInt(
      'number',
      this,
    );
    direction = _i1.ColumnEnum(
      'direction',
      this,
      _i1.EnumSerialization.byIndex,
    );
    properties = _i1.ColumnSerializable(
      'properties',
      this,
    );
    stateId = _i1.ColumnInt(
      'stateId',
      this,
    );
    createdAt = _i1.ColumnDateTime(
      'createdAt',
      this,
    );
    updatedAt = _i1.ColumnDateTime(
      'updatedAt',
      this,
    );
  }

  late final _i1.ColumnInt iotDeviceId;

  _i2.IotDeviceTable? _iotDevice;

  late final _i1.ColumnString name;

  late final _i1.ColumnInt number;

  late final _i1.ColumnEnum<_i3.PinDirection> direction;

  late final _i1.ColumnSerializable properties;

  late final _i1.ColumnInt stateId;

  _i5.PinStateTable? _state;

  late final _i1.ColumnDateTime createdAt;

  late final _i1.ColumnDateTime updatedAt;

  _i2.IotDeviceTable get iotDevice {
    if (_iotDevice != null) return _iotDevice!;
    _iotDevice = _i1.createRelationTable(
      relationFieldName: 'iotDevice',
      field: Pin.t.iotDeviceId,
      foreignField: _i2.IotDevice.t.id,
      tableRelation: tableRelation,
      createTable: (foreignTableRelation) =>
          _i2.IotDeviceTable(tableRelation: foreignTableRelation),
    );
    return _iotDevice!;
  }

  _i5.PinStateTable get state {
    if (_state != null) return _state!;
    _state = _i1.createRelationTable(
      relationFieldName: 'state',
      field: Pin.t.stateId,
      foreignField: _i5.PinState.t.id,
      tableRelation: tableRelation,
      createTable: (foreignTableRelation) =>
          _i5.PinStateTable(tableRelation: foreignTableRelation),
    );
    return _state!;
  }

  @override
  List<_i1.Column> get columns => [
        id,
        iotDeviceId,
        name,
        number,
        direction,
        properties,
        stateId,
        createdAt,
        updatedAt,
      ];

  @override
  _i1.Table? getRelationTable(String relationField) {
    if (relationField == 'iotDevice') {
      return iotDevice;
    }
    if (relationField == 'state') {
      return state;
    }
    return null;
  }
}

class PinInclude extends _i1.IncludeObject {
  PinInclude._({
    _i2.IotDeviceInclude? iotDevice,
    _i5.PinStateInclude? state,
  }) {
    _iotDevice = iotDevice;
    _state = state;
  }

  _i2.IotDeviceInclude? _iotDevice;

  _i5.PinStateInclude? _state;

  @override
  Map<String, _i1.Include?> get includes => {
        'iotDevice': _iotDevice,
        'state': _state,
      };

  @override
  _i1.Table get table => Pin.t;
}

class PinIncludeList extends _i1.IncludeList {
  PinIncludeList._({
    _i1.WhereExpressionBuilder<PinTable>? where,
    super.limit,
    super.offset,
    super.orderBy,
    super.orderDescending,
    super.orderByList,
    super.include,
  }) {
    super.where = where?.call(Pin.t);
  }

  @override
  Map<String, _i1.Include?> get includes => include?.includes ?? {};

  @override
  _i1.Table get table => Pin.t;
}

class PinRepository {
  const PinRepository._();

  final attachRow = const PinAttachRowRepository._();

  Future<List<Pin>> find(
    _i1.Session session, {
    _i1.WhereExpressionBuilder<PinTable>? where,
    int? limit,
    int? offset,
    _i1.OrderByBuilder<PinTable>? orderBy,
    bool orderDescending = false,
    _i1.OrderByListBuilder<PinTable>? orderByList,
    _i1.Transaction? transaction,
    PinInclude? include,
  }) async {
    return session.db.find<Pin>(
      where: where?.call(Pin.t),
      orderBy: orderBy?.call(Pin.t),
      orderByList: orderByList?.call(Pin.t),
      orderDescending: orderDescending,
      limit: limit,
      offset: offset,
      transaction: transaction,
      include: include,
    );
  }

  Future<Pin?> findFirstRow(
    _i1.Session session, {
    _i1.WhereExpressionBuilder<PinTable>? where,
    int? offset,
    _i1.OrderByBuilder<PinTable>? orderBy,
    bool orderDescending = false,
    _i1.OrderByListBuilder<PinTable>? orderByList,
    _i1.Transaction? transaction,
    PinInclude? include,
  }) async {
    return session.db.findFirstRow<Pin>(
      where: where?.call(Pin.t),
      orderBy: orderBy?.call(Pin.t),
      orderByList: orderByList?.call(Pin.t),
      orderDescending: orderDescending,
      offset: offset,
      transaction: transaction,
      include: include,
    );
  }

  Future<Pin?> findById(
    _i1.Session session,
    int id, {
    _i1.Transaction? transaction,
    PinInclude? include,
  }) async {
    return session.db.findById<Pin>(
      id,
      transaction: transaction,
      include: include,
    );
  }

  Future<List<Pin>> insert(
    _i1.Session session,
    List<Pin> rows, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.insert<Pin>(
      rows,
      transaction: transaction,
    );
  }

  Future<Pin> insertRow(
    _i1.Session session,
    Pin row, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.insertRow<Pin>(
      row,
      transaction: transaction,
    );
  }

  Future<List<Pin>> update(
    _i1.Session session,
    List<Pin> rows, {
    _i1.ColumnSelections<PinTable>? columns,
    _i1.Transaction? transaction,
  }) async {
    return session.db.update<Pin>(
      rows,
      columns: columns?.call(Pin.t),
      transaction: transaction,
    );
  }

  Future<Pin> updateRow(
    _i1.Session session,
    Pin row, {
    _i1.ColumnSelections<PinTable>? columns,
    _i1.Transaction? transaction,
  }) async {
    return session.db.updateRow<Pin>(
      row,
      columns: columns?.call(Pin.t),
      transaction: transaction,
    );
  }

  Future<List<Pin>> delete(
    _i1.Session session,
    List<Pin> rows, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.delete<Pin>(
      rows,
      transaction: transaction,
    );
  }

  Future<Pin> deleteRow(
    _i1.Session session,
    Pin row, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.deleteRow<Pin>(
      row,
      transaction: transaction,
    );
  }

  Future<List<Pin>> deleteWhere(
    _i1.Session session, {
    required _i1.WhereExpressionBuilder<PinTable> where,
    _i1.Transaction? transaction,
  }) async {
    return session.db.deleteWhere<Pin>(
      where: where(Pin.t),
      transaction: transaction,
    );
  }

  Future<int> count(
    _i1.Session session, {
    _i1.WhereExpressionBuilder<PinTable>? where,
    int? limit,
    _i1.Transaction? transaction,
  }) async {
    return session.db.count<Pin>(
      where: where?.call(Pin.t),
      limit: limit,
      transaction: transaction,
    );
  }
}

class PinAttachRowRepository {
  const PinAttachRowRepository._();

  Future<void> iotDevice(
    _i1.Session session,
    Pin pin,
    _i2.IotDevice iotDevice, {
    _i1.Transaction? transaction,
  }) async {
    if (pin.id == null) {
      throw ArgumentError.notNull('pin.id');
    }
    if (iotDevice.id == null) {
      throw ArgumentError.notNull('iotDevice.id');
    }

    var $pin = pin.copyWith(iotDeviceId: iotDevice.id);
    await session.db.updateRow<Pin>(
      $pin,
      columns: [Pin.t.iotDeviceId],
      transaction: transaction,
    );
  }

  Future<void> state(
    _i1.Session session,
    Pin pin,
    _i5.PinState state, {
    _i1.Transaction? transaction,
  }) async {
    if (pin.id == null) {
      throw ArgumentError.notNull('pin.id');
    }
    if (state.id == null) {
      throw ArgumentError.notNull('state.id');
    }

    var $pin = pin.copyWith(stateId: state.id);
    await session.db.updateRow<Pin>(
      $pin,
      columns: [Pin.t.stateId],
      transaction: transaction,
    );
  }
}
