import 'package:auto_route/auto_route.dart';
import 'package:iot_cloud_flutter/src/core/routes/router.gr.dart';

@AutoRouterConfig()
class AppRouter extends RootStackRouter {
  @override
  RouteType get defaultRouteType => RouteType.material();

  @override
  List<AutoRoute> get routes => [
    AutoRoute(page: DashboardRoute.page, path: '/', initial: true),
    AutoRoute(page: IotDeviceRoute.page, path: '/iotDevices'),
  ];
}
