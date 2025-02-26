import 'package:iot_cloud_server/src/generated/protocol.dart';
import 'package:serverpod/serverpod.dart';

class IoModuleEndpoint extends Endpoint {
  Future<bool> insert(Session session, IoModule ioModule) async {
    try {
      await IoModule.db.insertRow(session, ioModule);
      return true;
    } catch (e) {
      return false;
    }
  }

  Future<bool> attach(
    Session session,
    IotDevice iotDevice,
    IoModule ioModule,
  ) async {
    try {
      await IotDevice.db.attachRow.attachedModules(
        session,
        iotDevice,
        ioModule,
      );
      return true;
    } catch (e) {
      return false;
    }
  }
}
