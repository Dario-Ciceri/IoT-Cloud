import 'package:injectable/injectable.dart';
import 'package:iot_cloud_flutter/src/core/config/injector.dart';
import 'package:iot_cloud_flutter/src/features/iot_device/domain/usecases/list_iot_devices.dart';
import 'package:iot_cloud_flutter/src/features/iot_device/presentation/bloc/iot_device_bloc.dart';

@module
abstract class BlocModule {
  @dev
  @lazySingleton
  IotDeviceBloc provideIotDeviceBloc() {
    return IotDeviceBloc(listIotDevices: resolve<ListIotDevicesUseCase>());
  }
}
