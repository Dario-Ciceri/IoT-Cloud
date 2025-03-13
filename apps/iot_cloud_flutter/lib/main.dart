import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:iot_cloud_flutter/src/core/config/injector.dart';
import 'package:iot_cloud_flutter/src/core/routes/router.dart';
import 'package:iot_cloud_flutter/src/features/iot_device/presentation/bloc/iot_device_bloc.dart';

void main() {
  configureDependencies(enviroment: dev);

  runApp(
    MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (_) {
            return resolve<IotDeviceBloc>();
          },
        ),
      ],
      child: IotCloudApp(appRouter: resolve<AppRouter>()),
    ),
  );
}

class IotCloudApp extends StatelessWidget {
  const IotCloudApp({super.key, required this.appRouter});
  final AppRouter appRouter;

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      debugShowCheckedModeBanner: false,
      theme: ThemeData.dark(),
      routerConfig: appRouter.config(),
    );
  }
}
