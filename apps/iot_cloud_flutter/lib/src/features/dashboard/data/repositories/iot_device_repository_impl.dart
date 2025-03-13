import 'package:fpdart/fpdart.dart';
import 'package:iot_cloud_client/iot_cloud_client.dart';
import 'package:iot_cloud_flutter/src/core/error/failure.dart';
import 'package:iot_cloud_flutter/src/features/iot_device/data/datasources/remote/iot_device_remote_datasource.dart';
import 'package:iot_cloud_flutter/src/features/iot_device/domain/repositories/iot_device_repository.dart';

class IotDeviceRepositoryImpl implements IotDeviceRepository {
  final IotDeviceRemoteDatasource datasource;

  IotDeviceRepositoryImpl({required this.datasource});

  @override
  Future<Either<Failure, List<IotDevice>>> list() async {
    try {
      return right(await datasource.list());
    } on ServerException catch (e) {
      return left(Failure.server(message: e.message));
    }
  }

  @override
  Future<Either<Failure, IotDevice>> retrieve(int id) async {
    try {
      return right(await datasource.retrieve(id));
    } on ServerException catch (e) {
      return left(Failure.server(message: e.message));
    }
  }
}
