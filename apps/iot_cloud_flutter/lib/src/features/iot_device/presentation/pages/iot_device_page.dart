import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:iot_cloud_flutter/src/core/routes/router.gr.dart';
import 'package:iot_cloud_flutter/src/core/widgets/app_drawer.dart';
import 'package:iot_cloud_flutter/src/features/iot_device/presentation/widgets/iot_device_list_widget.dart';

@RoutePage()
class IotDevicePage extends StatelessWidget {
  const IotDevicePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Dispositivi"), backgroundColor: Colors.blue),
      drawer: AppDrawer(
        menuItems: [
          AppDrawerItem(
            title: "Dashboard",
            icon: Icons.dashboard,
            routeInfo:
                const DashboardRoute(), // Sostituisci con la tua rotta effettiva
          ),
          AppDrawerItem(
            title: "Dispositivi",
            icon: Icons.devices,
            routeInfo: const IotDeviceRoute(),
          ),
        ],
        header: AppDrawerHeader(
          userName: "Utente IoT",
          userEmail: "user@example.com",
        ),
      ),
      body: IotDeviceListWidget(),
    );
  }
}
