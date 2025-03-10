import 'package:injectable/injectable.dart';
import 'package:iot_cloud_client/iot_cloud_client.dart';
import 'package:iot_cloud_flutter/src/core/config/injector.dart';
import 'package:iot_cloud_flutter/src/features/iot_device/data/datasources/remote/iot_device_remote_datasource.dart';
import 'package:iot_cloud_flutter/src/features/iot_device/data/repositories/iot_device_repository_impl.dart';
import 'package:iot_cloud_flutter/src/features/iot_device/domain/repositories/iot_device_repository.dart';
import 'package:iot_cloud_flutter/src/features/iot_device/domain/usecases/list_iot_devices.dart';
import 'package:iot_cloud_flutter/src/features/iot_device/domain/usecases/retrieve_iot_device.dart';
import 'package:serverpod_flutter/serverpod_flutter.dart';

@module
abstract class ApiModule {
  //* Connectivity monitor
  @lazySingleton
  FlutterConnectivityMonitor provideConnectivityMonitor() {
    return FlutterConnectivityMonitor();
  }

  //* Client
  @dev
  @lazySingleton
  Client provideClient() {
    final client = Client('http://localhost:8080/');
    client.connectivityMonitor = resolve<FlutterConnectivityMonitor>();
    return client;
  }

  //* Datasources
  @dev
  @factoryMethod
  IotDeviceRemoteDatasource provideIotDeviceRemoteDatasource() {
    return IotDeviceRemoteDatasourceImpl(client: resolve<Client>());
  }

  //* Repositories
  @dev
  @factoryMethod
  IotDeviceRepository provideIotDeviceRepository() {
    return IotDeviceRepositoryImpl(
      datasource: resolve<IotDeviceRemoteDatasource>(),
    );
  }

  //* Use cases
  @dev
  @factoryMethod
  ListIotDevicesUseCase provideListIotDevicesUseCase() {
    return ListIotDevicesUseCase(
      iotDeviceRepository: resolve<IotDeviceRepository>(),
    );
  }

  @dev
  @factoryMethod
  RetrieveIotDevicesUseCase provideFetchIotDevicesUseCase() {
    return RetrieveIotDevicesUseCase(
      iotDeviceRepository: resolve<IotDeviceRepository>(),
    );
  }
}
