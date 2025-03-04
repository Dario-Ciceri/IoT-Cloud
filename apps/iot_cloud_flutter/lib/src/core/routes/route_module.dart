import 'package:injectable/injectable.dart';
import 'package:iot_cloud_flutter/src/core/routes/router.dart';
import 'package:serverpod_flutter/serverpod_flutter.dart';

@module
abstract class RouteModule {
  @Environment('dev')
  @lazySingleton
  AppRouter provideAppRouter(FlutterConnectivityMonitor monitor) {
    final appRouter = AppRouter();
    return appRouter;
  }
}
