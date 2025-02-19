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
import '../endpoints/iot_device_endpoint.dart' as _i2;
import 'package:iot_cloud_server/src/generated/iot_device/iot_device.dart'
    as _i3;

class Endpoints extends _i1.EndpointDispatch {
  @override
  void initializeEndpoints(_i1.Server server) {
    var endpoints = <String, _i1.Endpoint>{
      'iotDevice': _i2.IotDeviceEndpoint()
        ..initialize(
          server,
          'iotDevice',
          null,
        )
    };
    connectors['iotDevice'] = _i1.EndpointConnector(
      name: 'iotDevice',
      endpoint: endpoints['iotDevice']!,
      methodConnectors: {
        'register': _i1.MethodConnector(
          name: 'register',
          params: {
            'iotDevice': _i1.ParameterDescription(
              name: 'iotDevice',
              type: _i1.getType<_i3.IotDevice>(),
              nullable: false,
            )
          },
          call: (
            _i1.Session session,
            Map<String, dynamic> params,
          ) async =>
              (endpoints['iotDevice'] as _i2.IotDeviceEndpoint).register(
            session,
            params['iotDevice'],
          ),
        )
      },
    );
  }
}
