import '../generated/protocol.dart';
import 'package:serverpod/serverpod.dart';

class IotDeviceEndpoint extends Endpoint {
  Future<List<IotDevice>> list(Session session) async {
    // await IotDevice.db.attachRow.state(
    //   session,
    //   (await IotDevice.db.findById(session, 1))!,
    //   (await IotDeviceState.db.findById(session, 1))!,
    // );
    return await IotDevice.db.find(
      session,
      include: IotDevice.include(
        state: IotDeviceState.include(),
        attachedModules: IoModule.includeList(),
        pins: Pin.includeList(),
      ),
    );
  }

  Future<IotDevice?> retrieve(Session session, int id) async {
    return await IotDevice.db.findById(session, id);
  }
}
