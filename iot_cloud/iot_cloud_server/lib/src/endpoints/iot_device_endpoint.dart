import 'package:iot_cloud_server/src/generated/protocol.dart';
import 'package:serverpod/serverpod.dart';

class IotDeviceEndpoint extends Endpoint {
  Future<bool> register(Session session, IotDevice iotDevice) async {
    try {
      await IotDevice.db.insertRow(session, iotDevice);
      return true;
    } catch (e) {
      return false;
    }
  }
}
