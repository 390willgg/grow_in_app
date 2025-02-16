part of 'device_bloc.dart';

abstract class DeviceState extends Equatable {}

class DeviceStateEmpty extends DeviceState {
  @override
  List<Object?> get props => [];
}

class DeviceLoadedInProgress extends DeviceState {
  @override
  List<Object?> get props => [];
}

class DeviceLoadedSuccess extends DeviceState {
  final Device device;
  final String deviceId;
  final int? moistureThreshold;

  DeviceLoadedSuccess({
    required this.device,
    required this.deviceId,
    required this.moistureThreshold,
  });

  @override
  List<Object?> get props => [device, deviceId, moistureThreshold];

  DeviceLoadedSuccess copyWith({
    Device? device,
    String? deviceId,
    int? moistureThreshold,
  }) {
    return DeviceLoadedSuccess(
      device: device ?? this.device,
      deviceId: deviceId ?? this.deviceId,
      moistureThreshold: moistureThreshold ?? this.moistureThreshold,
    );
  }
}


class DeviceLoadedFailure extends DeviceState {
  final String? message;
  DeviceLoadedFailure({this.message});

  @override
  List<Object?> get props => [message];
}