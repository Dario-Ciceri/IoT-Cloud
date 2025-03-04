import 'package:flutter/material.dart';
import 'package:iot_cloud_client/iot_cloud_client.dart';
import 'package:iot_cloud_flutter/src/core/config/config.dart';
import 'package:iot_cloud_flutter/src/core/constants/constants.dart';

void main() {
  configureDependencies(enviroment: environment);
  runApp(IotCloudApp());
}

class IotCloudApp extends StatelessWidget {
  const IotCloudApp({super.key});

  @override
  Widget build(BuildContext context) {
    final Client client = resolve<Client>();
    debugPrint(client.iotDevice.name);
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        body: Placeholder(),
      ),
    );
  }
}
