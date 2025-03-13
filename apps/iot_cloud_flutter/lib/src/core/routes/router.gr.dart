// dart format width=80
// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// AutoRouterGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:auto_route/auto_route.dart' as _i4;
import 'package:iot_cloud_flutter/src/core/routes/router_tabs.dart' as _i3;
import 'package:iot_cloud_flutter/src/features/dashboard/presentation/pages/dashboard_page.dart'
    as _i1;
import 'package:iot_cloud_flutter/src/features/iot_device/presentation/pages/iot_device_page.dart'
    as _i2;

/// generated route for
/// [_i1.DashboardPage]
class DashboardRoute extends _i4.PageRouteInfo<void> {
  const DashboardRoute({List<_i4.PageRouteInfo>? children})
    : super(DashboardRoute.name, initialChildren: children);

  static const String name = 'DashboardRoute';

  static _i4.PageInfo page = _i4.PageInfo(
    name,
    builder: (data) {
      return const _i1.DashboardPage();
    },
  );
}

/// generated route for
/// [_i2.IotDevicePage]
class IotDeviceRoute extends _i4.PageRouteInfo<void> {
  const IotDeviceRoute({List<_i4.PageRouteInfo>? children})
    : super(IotDeviceRoute.name, initialChildren: children);

  static const String name = 'IotDeviceRoute';

  static _i4.PageInfo page = _i4.PageInfo(
    name,
    builder: (data) {
      return const _i2.IotDevicePage();
    },
  );
}

/// generated route for
/// [_i3.IotDeviceTabPage]
class IotDevicesTab extends _i4.PageRouteInfo<void> {
  const IotDevicesTab({List<_i4.PageRouteInfo>? children})
    : super(IotDevicesTab.name, initialChildren: children);

  static const String name = 'IotDevicesTab';

  static _i4.PageInfo page = _i4.PageInfo(
    name,
    builder: (data) {
      return const _i3.IotDeviceTabPage();
    },
  );
}
