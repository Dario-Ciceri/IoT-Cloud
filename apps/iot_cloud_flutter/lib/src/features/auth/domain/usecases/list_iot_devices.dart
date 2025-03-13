import 'package:fpdart/fpdart.dart';
import 'package:iot_cloud_client/iot_cloud_client.dart';
import 'package:iot_cloud_flutter/src/core/error/failure.dart';
import 'package:iot_cloud_flutter/src/core/usecases/usecase.dart';
import 'package:iot_cloud_flutter/src/features/iot_device/domain/repositories/iot_device_repository.dart';

class ListIotDevicesUseCase implements UseCase<List<IotDevice>, NoParams> {
  final IotDeviceRepository iotDeviceRepository;

  ListIotDevicesUseCase({required this.iotDeviceRepository});

  @override
  Future<Either<Failure, List<IotDevice>>> call(NoParams params) async {
    return await iotDeviceRepository.list();
  }
}
