import 'package:injectable/injectable.dart';
import 'package:iot_cloud_client/iot_cloud_client.dart';
import 'package:iot_cloud_flutter/src/features/iot_device/data/datasources/remote/iot_device_remote_datasource.dart';
import 'package:iot_cloud_flutter/src/features/iot_device/data/repositories/iot_device_repository_impl.dart';
import 'package:iot_cloud_flutter/src/features/iot_device/domain/repositories/iot_device_repository.dart';
import 'package:iot_cloud_flutter/src/features/iot_device/domain/usecases/list_iot_devices.dart';
import 'package:iot_cloud_flutter/src/features/iot_device/domain/usecases/retrieve_iot_device.dart';
import 'package:serverpod_auth_shared_flutter/serverpod_auth_shared_flutter.dart';
import 'package:serverpod_flutter/serverpod_flutter.dart';

@module
abstract class ApiModule {
  //* Connectivity monitor
  @dev
  @lazySingleton
  FlutterConnectivityMonitor provideConnectivityMonitor() {
    return FlutterConnectivityMonitor();
  }

  //* Authentication manager
  @dev
  @lazySingleton
  FlutterAuthenticationKeyManager provideAuthenticationManager() {
    return FlutterAuthenticationKeyManager();
  }

  //* Session manager
  @dev
  @lazySingleton
  Future<SessionManager> provideSessionManager(Client client) async {
    final SessionManager sessionManager = SessionManager(
      caller: client.modules.auth,
    );
    final result = await sessionManager.initialize();
    if (result) {
      return sessionManager;
    }
    throw UnexpectedException(
      message: "Session manager non inizializzato correttamente.",
    );
  }

  //* Client
  @dev
  @lazySingleton
  Client provideClient(
    FlutterAuthenticationKeyManager authManager,
    FlutterConnectivityMonitor connectivityMonitor,
  ) {
    final client = Client(
      'http://localhost:8080/',
      authenticationKeyManager: authManager,
    );
    client.connectivityMonitor = connectivityMonitor;
    return client;
  }

  //* Datasources
  @dev
  @factoryMethod
  IotDeviceRemoteDatasource provideIotDeviceRemoteDatasource(Client client) {
    return IotDeviceRemoteDatasourceImpl(client: client);
  }

  //* Repositories
  @dev
  @factoryMethod
  IotDeviceRepository provideIotDeviceRepository(
    IotDeviceRemoteDatasource datasource,
  ) {
    return IotDeviceRepositoryImpl(datasource: datasource);
  }

  //* Use cases
  @dev
  @factoryMethod
  ListIotDevicesUseCase provideListIotDevicesUseCase(
    IotDeviceRepository iotDeviceRepository,
  ) {
    return ListIotDevicesUseCase(iotDeviceRepository: iotDeviceRepository);
  }

  @dev
  @factoryMethod
  RetrieveIotDevicesUseCase provideFetchIotDevicesUseCase(
    IotDeviceRepository iotDeviceRepository,
  ) {
    return RetrieveIotDevicesUseCase(iotDeviceRepository: iotDeviceRepository);
  }
}
