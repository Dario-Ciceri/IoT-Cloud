part of 'iot_device_bloc.dart';

enum IotDeviceBlocStatus {
  initial,
  loading,
  success,
  failure;

  bool get isInitial => this == IotDeviceBlocStatus.initial;
  bool get isLoading => this == IotDeviceBlocStatus.loading;
  bool get isSuccess => this == IotDeviceBlocStatus.success;
  bool get isFailure => this == IotDeviceBlocStatus.failure;
}

@freezed
class IotDeviceBlocState with _$IotDeviceBlocState {
  const factory IotDeviceBlocState({
    @Default(IotDeviceBlocStatus.initial) IotDeviceBlocStatus status,
    @Default("") String errorMessage,
    @Default([]) List<IotDevice> iotDevices,
  }) = _IotDeviceBlocState;
}
