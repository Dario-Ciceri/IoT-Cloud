import 'package:iot_cloud_server/src/generated/protocol.dart';
import 'package:test/test.dart';
import 'test_tools/serverpod_test_tools.dart';

void main() {
  withServerpod(
    'IoT Device Insert',
    (sessionBuilder, endpoints) {
      var session = sessionBuilder.build();

      final IotDeviceInfo iotDeviceInfo = IotDeviceInfo(
        serialId: "test",
        type: IotDeviceType.ArduinoR4WiFi,
        name: "test",
        fwVersion: "test",
        heartBeat: DateTime.now(),
      );

      final IotDeviceHwState iotDeviceHwState = IotDeviceHwState(
        cpuLoad: 30,
        temp: 25.5,
        mem: 67,
      );

      final IotDeviceState iotDeviceState = IotDeviceState(
        status: IotDeviceStatus.Online,
        hwState: iotDeviceHwState,
      );

      final IoModuleInfo ioModuleInfo = IoModuleInfo(
        serialId: "test",
        name: "test",
        type: IoModuleType.Sensor,
        subtype: IoModuleSubType.Temperature,
      );

      final IoModuleState ioModuleState = IoModuleState(
        value: "12.6",
        unit: UnitType.Celsius,
      );

      final IoModule ioModule = IoModule(
        info: ioModuleInfo,
        state: ioModuleState,
      );

      final IotDevice iotDevice = IotDevice(
        info: iotDeviceInfo,
        state: iotDeviceState,
        attachedModules: [ioModule],
      );

      test('when calling `register` the device is inserted into the db',
          () async {
        final res =
            await endpoints.iotDevice.register(sessionBuilder, iotDevice);
        expect(res, true);
      });
    },
    rollbackDatabase: RollbackDatabase.disabled,
  );
}
