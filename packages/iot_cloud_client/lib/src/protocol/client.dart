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
import 'dart:async' as _i2;
import 'package:iot_cloud_client/src/protocol/io_module/io_module.dart' as _i3;
import 'package:iot_cloud_client/src/protocol/iot_device/iot_device.dart'
    as _i4;
import 'protocol.dart' as _i5;

/// {@category Endpoint}
class EndpointIoModule extends _i1.EndpointRef {
  EndpointIoModule(_i1.EndpointCaller caller) : super(caller);

  @override
  String get name => 'ioModule';

  _i2.Future<bool> insert(_i3.IoModule ioModule) =>
      caller.callServerEndpoint<bool>(
        'ioModule',
        'insert',
        {'ioModule': ioModule},
      );

  _i2.Future<bool> attach(
    _i4.IotDevice iotDevice,
    _i3.IoModule ioModule,
  ) =>
      caller.callServerEndpoint<bool>(
        'ioModule',
        'attach',
        {
          'iotDevice': iotDevice,
          'ioModule': ioModule,
        },
      );
}

/// {@category Endpoint}
class EndpointIotDevice extends _i1.EndpointRef {
  EndpointIotDevice(_i1.EndpointCaller caller) : super(caller);

  @override
  String get name => 'iotDevice';

  _i2.Future<bool> register(_i4.IotDevice iotDevice) =>
      caller.callServerEndpoint<bool>(
        'iotDevice',
        'register',
        {'iotDevice': iotDevice},
      );
}

class Client extends _i1.ServerpodClientShared {
  Client(
    String host, {
    dynamic securityContext,
    _i1.AuthenticationKeyManager? authenticationKeyManager,
    Duration? streamingConnectionTimeout,
    Duration? connectionTimeout,
    Function(
      _i1.MethodCallContext,
      Object,
      StackTrace,
    )? onFailedCall,
    Function(_i1.MethodCallContext)? onSucceededCall,
    bool? disconnectStreamsOnLostInternetConnection,
  }) : super(
          host,
          _i5.Protocol(),
          securityContext: securityContext,
          authenticationKeyManager: authenticationKeyManager,
          streamingConnectionTimeout: streamingConnectionTimeout,
          connectionTimeout: connectionTimeout,
          onFailedCall: onFailedCall,
          onSucceededCall: onSucceededCall,
          disconnectStreamsOnLostInternetConnection:
              disconnectStreamsOnLostInternetConnection,
        ) {
    ioModule = EndpointIoModule(this);
    iotDevice = EndpointIotDevice(this);
  }

  late final EndpointIoModule ioModule;

  late final EndpointIotDevice iotDevice;

  @override
  Map<String, _i1.EndpointRef> get endpointRefLookup => {
        'ioModule': ioModule,
        'iotDevice': iotDevice,
      };

  @override
  Map<String, _i1.ModuleEndpointCaller> get moduleLookup => {};
}
