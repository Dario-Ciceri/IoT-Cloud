// dart format width=80
// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:get_it/get_it.dart' as _i174;
import 'package:injectable/injectable.dart' as _i526;
import 'package:iot_cloud_client/iot_cloud_client.dart' as _i740;
import 'package:iot_cloud_flutter/src/core/api/api_module.dart' as _i344;
import 'package:iot_cloud_flutter/src/core/bloc/bloc_module.dart' as _i298;
import 'package:iot_cloud_flutter/src/core/routes/route_module.dart' as _i0;
import 'package:iot_cloud_flutter/src/core/routes/router.dart' as _i589;
import 'package:iot_cloud_flutter/src/features/iot_device/data/datasources/remote/iot_device_remote_datasource.dart'
    as _i503;
import 'package:iot_cloud_flutter/src/features/iot_device/domain/repositories/iot_device_repository.dart'
    as _i619;
import 'package:iot_cloud_flutter/src/features/iot_device/domain/usecases/list_iot_devices.dart'
    as _i594;
import 'package:iot_cloud_flutter/src/features/iot_device/domain/usecases/retrieve_iot_device.dart'
    as _i88;
import 'package:iot_cloud_flutter/src/features/iot_device/presentation/bloc/iot_device_bloc.dart'
    as _i434;
import 'package:serverpod_flutter/serverpod_flutter.dart' as _i730;

const String _dev = 'dev';

extension GetItInjectableX on _i174.GetIt {
  // initializes the registration of main-scope dependencies inside of GetIt
  _i174.GetIt init({
    String? environment,
    _i526.EnvironmentFilter? environmentFilter,
  }) {
    final gh = _i526.GetItHelper(this, environment, environmentFilter);
    final apiModule = _$ApiModule();
    final blocModule = _$BlocModule();
    final routeModule = _$RouteModule();
    gh.lazySingleton<_i730.FlutterConnectivityMonitor>(
      () => apiModule.provideConnectivityMonitor(),
    );
    gh.lazySingleton<_i740.Client>(
      () => apiModule.provideClient(),
      registerFor: {_dev},
    );
    gh.lazySingleton<_i434.IotDeviceBloc>(
      () => blocModule.provideIotDeviceBloc(),
      registerFor: {_dev},
    );
    gh.factory<_i503.IotDeviceRemoteDatasource>(
      () => apiModule.provideIotDeviceRemoteDatasource(),
      registerFor: {_dev},
    );
    gh.factory<_i619.IotDeviceRepository>(
      () => apiModule.provideIotDeviceRepository(),
      registerFor: {_dev},
    );
    gh.factory<_i594.ListIotDevicesUseCase>(
      () => apiModule.provideListIotDevicesUseCase(),
      registerFor: {_dev},
    );
    gh.factory<_i88.RetrieveIotDevicesUseCase>(
      () => apiModule.provideFetchIotDevicesUseCase(),
      registerFor: {_dev},
    );
    gh.lazySingleton<_i589.AppRouter>(
      () =>
          routeModule.provideAppRouter(gh<_i730.FlutterConnectivityMonitor>()),
      registerFor: {_dev},
    );
    return this;
  }
}

class _$ApiModule extends _i344.ApiModule {}

class _$BlocModule extends _i298.BlocModule {}

class _$RouteModule extends _i0.RouteModule {}
