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

abstract class IotDeviceHwState implements _i1.SerializableModel {
  IotDeviceHwState._({
    required this.cpuLoad,
    required this.temp,
    required this.mem,
  });

  factory IotDeviceHwState({
    required int cpuLoad,
    required double temp,
    required double mem,
  }) = _IotDeviceHwStateImpl;

  factory IotDeviceHwState.fromJson(Map<String, dynamic> jsonSerialization) {
    return IotDeviceHwState(
      cpuLoad: jsonSerialization['cpuLoad'] as int,
      temp: (jsonSerialization['temp'] as num).toDouble(),
      mem: (jsonSerialization['mem'] as num).toDouble(),
    );
  }

  int cpuLoad;

  double temp;

  double mem;

  IotDeviceHwState copyWith({
    int? cpuLoad,
    double? temp,
    double? mem,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      'cpuLoad': cpuLoad,
      'temp': temp,
      'mem': mem,
    };
  }

  @override
  String toString() {
    return _i1.SerializationManager.encode(this);
  }
}

class _IotDeviceHwStateImpl extends IotDeviceHwState {
  _IotDeviceHwStateImpl({
    required int cpuLoad,
    required double temp,
    required double mem,
  }) : super._(
          cpuLoad: cpuLoad,
          temp: temp,
          mem: mem,
        );

  @override
  IotDeviceHwState copyWith({
    int? cpuLoad,
    double? temp,
    double? mem,
  }) {
    return IotDeviceHwState(
      cpuLoad: cpuLoad ?? this.cpuLoad,
      temp: temp ?? this.temp,
      mem: mem ?? this.mem,
    );
  }
}
