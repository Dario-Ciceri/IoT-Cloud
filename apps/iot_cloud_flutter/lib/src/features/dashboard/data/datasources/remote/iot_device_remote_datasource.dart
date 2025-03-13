import 'package:iot_cloud_client/iot_cloud_client.dart';

abstract interface class IotDeviceRemoteDatasource {
  Future<List<IotDevice>> list();
  Future<IotDevice> retrieve(int id);
}

class IotDeviceRemoteDatasourceImpl extends IotDeviceRemoteDatasource {
  final Client client;
  //todo final SessionManager sessionManager;

  IotDeviceRemoteDatasourceImpl({required this.client});

  @override
  Future<List<IotDevice>> list() async {
    try {
      return await client.iotDevice.list();
    } catch (e) {
      throw ServerException(message: e.toString());
    }
  }

  @override
  Future<IotDevice> retrieve(int id) async {
    try {
      final res = await client.iotDevice.retrieve(id);
      if (res == null) {
        throw ServerException(message: "IoT device not found");
      }
      return res;
    } catch (e) {
      throw ServerException(message: e.toString());
    }
  }
}
