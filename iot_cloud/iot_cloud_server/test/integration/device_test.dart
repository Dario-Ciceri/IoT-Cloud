import 'package:iot_cloud_server/src/generated/protocol.dart';
import 'package:test/test.dart';
import 'test_tools/serverpod_test_tools.dart';

void main() {
  withServerpod('Given Example endpoint', (sessionBuilder, endpoints) {
    var session = sessionBuilder.build();

    setUp(
      () async {
        IotDeviceState iotDeviceState = IotDeviceState(
          status: IotDeviceStatus.Online,
          cpuLoad: 30,
          temp: 25.5,
          mem: 67,
          heartBeat: DateTime.now(),
          createdAt: DateTime.now(),
          updatedAt: DateTime.now(),
        );

        iotDeviceState = await IotDeviceState.db.insertRow(
          session,
          iotDeviceState,
        );

        IotDevice iotDevice = IotDevice(
          serialId: "test",
          type: IotDeviceType.ArduinoR4WiFi,
          name: "test",
          fwVersion: "test",
          stateId: iotDeviceState.id!,
          state: iotDeviceState,
          createdAt: DateTime.now(),
          updatedAt: DateTime.now(),
          attachedModules: [],
        );

        IoModuleState ioModuleState = IoModuleState(
          value: "12.6",
          unit: UnitType.Celsius,
          createdAt: DateTime.now(),
          updatedAt: DateTime.now(),
        );

        ioModuleState = await IoModuleState.db.insertRow(
          session,
          ioModuleState,
        );

        var res = await endpoints.iotDevice.register(
          sessionBuilder,
          iotDevice,
        );

        if (res) {
          final device = await IotDevice.db.findFirstRow(session);
          if (device != null) {
            iotDevice = device;
          }
        }

        IoModule ioModule = IoModule(
          serialId: "test",
          name: "test",
          type: IoModuleType.Sensor,
          subtype: IoModuleSubType.Temperature,
          stateId: ioModuleState.id!,
          state: ioModuleState,
          createdAt: DateTime.now(),
          updatedAt: DateTime.now(),
          iotDeviceId: iotDevice.id!,
        );

        res = await endpoints.ioModule.insert(sessionBuilder, ioModule);

        if (res) {
          final module = await IoModule.db.findFirstRow(session);
          if (module != null) {
            ioModule = module;
          }
        }

        await IoModule.db.attachRow.state(
          session,
          ioModule,
          ioModuleState,
        );

        await IotDevice.db.attachRow.state(
          session,
          iotDevice,
          iotDeviceState,
        );
      },
    );

    test('test dispositivi e moduli', () async {
      var iotDevice = await IotDevice.db.findFirstRow(
        session,
        include: IotDevice.include(
          state: IotDeviceState.include(),
        ),
      );

      var ioModule = await IoModule.db.findFirstRow(
        session,
        include: IoModule.include(
          state: IoModuleState.include(),
        ),
      );

      print(iotDevice?.state);
      print(ioModule?.state);

      print(iotDevice?.attachedModules);

      final res = await endpoints.ioModule.attach(
        sessionBuilder,
        iotDevice!,
        ioModule!,
      );

      iotDevice = await IotDevice.db.findFirstRow(
        session,
        include: IotDevice.include(
          attachedModules: IoModule.includeList(
            include: IoModule.include(
              state: IoModuleState.include(),
            ),
          ),
        ),
      );
      expect(res, true);
    });
  });
}
