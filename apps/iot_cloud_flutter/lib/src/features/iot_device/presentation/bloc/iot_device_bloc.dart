import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:iot_cloud_client/iot_cloud_client.dart';
import 'package:iot_cloud_flutter/src/core/usecases/usecase.dart';
import 'package:iot_cloud_flutter/src/features/iot_device/domain/usecases/list_iot_devices.dart';

part 'iot_device_event.dart';
part 'iot_device_state.dart';
part 'iot_device_bloc.freezed.dart';

class IotDeviceBloc extends Bloc<IotDeviceEvent, IotDeviceBlocState> {
  IotDeviceBloc({required this.listIotDevices})
      : super(const IotDeviceBlocState()) {
    on<_List>(_onList);
  }

  final ListIotDevicesUseCase listIotDevices;

  FutureOr<void> _onList(_, emit) async {
    emit(state.copyWith(status: IotDeviceBlocStatus.loading));
    final res = await listIotDevices(NoParams());

    res.fold(
      (l) => emit(
        state.copyWith(
          status: IotDeviceBlocStatus.failure,
        ),
      ),
      (r) => emit(
        state.copyWith(
          iotDevices: r,
          status: IotDeviceBlocStatus.success,
        ),
      ),
    );
  }
}
