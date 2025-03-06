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

abstract class PlatformioDevice
    implements _i1.SerializableModel, _i1.ProtocolSerialization {
  PlatformioDevice._({
    required this.port,
    this.description,
    this.hwid,
    this.vendorId,
    this.productId,
  });

  factory PlatformioDevice({
    required String port,
    String? description,
    String? hwid,
    String? vendorId,
    String? productId,
  }) = _PlatformioDeviceImpl;

  factory PlatformioDevice.fromJson(Map<String, dynamic> jsonSerialization) {
    return PlatformioDevice(
      port: jsonSerialization['port'] as String,
      description: jsonSerialization['description'] as String?,
      hwid: jsonSerialization['hwid'] as String?,
      vendorId: jsonSerialization['vendorId'] as String?,
      productId: jsonSerialization['productId'] as String?,
    );
  }

  String port;

  String? description;

  String? hwid;

  String? vendorId;

  String? productId;

  /// Returns a shallow copy of this [PlatformioDevice]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  PlatformioDevice copyWith({
    String? port,
    String? description,
    String? hwid,
    String? vendorId,
    String? productId,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      'port': port,
      if (description != null) 'description': description,
      if (hwid != null) 'hwid': hwid,
      if (vendorId != null) 'vendorId': vendorId,
      if (productId != null) 'productId': productId,
    };
  }

  @override
  Map<String, dynamic> toJsonForProtocol() {
    return {
      'port': port,
      if (description != null) 'description': description,
      if (hwid != null) 'hwid': hwid,
      if (vendorId != null) 'vendorId': vendorId,
      if (productId != null) 'productId': productId,
    };
  }

  @override
  String toString() {
    return _i1.SerializationManager.encode(this);
  }
}

class _Undefined {}

class _PlatformioDeviceImpl extends PlatformioDevice {
  _PlatformioDeviceImpl({
    required String port,
    String? description,
    String? hwid,
    String? vendorId,
    String? productId,
  }) : super._(
          port: port,
          description: description,
          hwid: hwid,
          vendorId: vendorId,
          productId: productId,
        );

  /// Returns a shallow copy of this [PlatformioDevice]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  @override
  PlatformioDevice copyWith({
    String? port,
    Object? description = _Undefined,
    Object? hwid = _Undefined,
    Object? vendorId = _Undefined,
    Object? productId = _Undefined,
  }) {
    return PlatformioDevice(
      port: port ?? this.port,
      description: description is String? ? description : this.description,
      hwid: hwid is String? ? hwid : this.hwid,
      vendorId: vendorId is String? ? vendorId : this.vendorId,
      productId: productId is String? ? productId : this.productId,
    );
  }
}
