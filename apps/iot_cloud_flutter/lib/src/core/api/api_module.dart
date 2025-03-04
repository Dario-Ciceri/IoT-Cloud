import 'package:injectable/injectable.dart';
import 'package:iot_cloud_client/iot_cloud_client.dart';
import 'package:serverpod_flutter/serverpod_flutter.dart';

@module
abstract class ApiModule {
  @lazySingleton
  FlutterConnectivityMonitor provideConnectivityMonitor() =>
      FlutterConnectivityMonitor();

  @Environment('dev')
  @lazySingleton
  Client provideClient(FlutterConnectivityMonitor monitor) {
    final client = Client('http://localhost:8080/');
    client.connectivityMonitor = monitor;
    return client;
  }
}
