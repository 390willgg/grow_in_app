part of 'device_bloc.dart';

abstract class DeviceEvent extends Equatable {}

class GetDeviceEvent extends DeviceEvent {
  final String deviceId;
  GetDeviceEvent(this.deviceId);

  @override
  List<Object?> get props => [deviceId];
}

class MoistureThresholdChangedEvent extends DeviceEvent {
  final int? moistureThreshold;

  MoistureThresholdChangedEvent(this.moistureThreshold);

  @override
  List<Object?> get props => [moistureThreshold];
}

class UpdateMoistureThresholdEvent extends DeviceEvent {
  final int moistureThreshold;

  UpdateMoistureThresholdEvent({required this.moistureThreshold});

  @override
  List<Object?> get props => [moistureThreshold];
}
