import 'package:fpdart/fpdart.dart';
import 'package:iot_cloud_client/iot_cloud_client.dart';
import 'package:iot_cloud_flutter/src/core/error/failure.dart';
import 'package:iot_cloud_flutter/src/core/usecases/usecase.dart';
import 'package:iot_cloud_flutter/src/features/iot_device/domain/repositories/iot_device_repository.dart';

class RetrieveIotDevicesUseCase
    implements UseCase<IotDevice, RetrieveIotDeviceParams> {
  final IotDeviceRepository iotDeviceRepository;

  RetrieveIotDevicesUseCase({required this.iotDeviceRepository});

  @override
  Future<Either<Failure, IotDevice>> call(
      RetrieveIotDeviceParams params) async {
    return await iotDeviceRepository.retrieve(params.id);
  }
}

class RetrieveIotDeviceParams {
  final int id;

  RetrieveIotDeviceParams({required this.id});
}
