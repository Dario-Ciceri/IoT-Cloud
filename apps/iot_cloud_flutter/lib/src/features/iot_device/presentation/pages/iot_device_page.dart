import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:iot_cloud_flutter/src/features/iot_device/presentation/widgets/iot_device_list_widget.dart';

@RoutePage()
class IotDevicePage extends StatelessWidget {
  const IotDevicePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("Dispostivi"),
          backgroundColor: Colors.blue,
        ),
        body: IotDeviceListWidget());
  }
}
