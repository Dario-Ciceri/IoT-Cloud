import 'package:fpdart/fpdart.dart';
import 'package:iot_cloud_client/iot_cloud_client.dart';
import 'package:iot_cloud_flutter/src/core/error/failure.dart';

abstract interface class IotDeviceRepository {
  Future<Either<Failure, List<IotDevice>>> list();
  Future<Either<Failure, IotDevice>> retrieve(int id);
}
