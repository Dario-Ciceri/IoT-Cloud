import 'package:auto_route/auto_route.dart';
import 'package:iot_cloud_flutter/src/core/routes/router.gr.dart';

@AutoRouterConfig()
class AppRouter extends RootStackRouter {
  @override
  RouteType get defaultRouteType => RouteType.material();

  @override
  List<AutoRoute> get routes => [
        AutoRoute(
            page: DashboardRoute.page, path: '/', initial: true), // Nuove rotte
        AutoRoute(
          path: '/devices-map',
          page: DevicesMapRoute.page,
        ),
        AutoRoute(
          path: '/notifications',
          page: NotificationsRoute.page,
        ),
        AutoRoute(
          path: '/account',
          page: AccountRoute.page,
        ),
        AutoRoute(
          path: '/settings',
          page: SettingsRoute.page,
        ),
        AutoRoute(
          path: '/help',
          page: HelpRoute.page,
        ),
        AutoRoute(
          path: '/firmare-update',
          page: FirmwareUpdateRoute.page,
        ),
        AutoRoute(
          path: '/ide',
          page: CodeEditorRoute.page,
        ),
      ];
}
