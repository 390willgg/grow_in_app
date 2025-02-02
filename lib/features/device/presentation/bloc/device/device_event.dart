part of 'device_bloc.dart';

abstract class DeviceEvent extends Equatable {}

class GetDeviceEvent extends DeviceEvent {
  final String deviceId;
  GetDeviceEvent(this.deviceId);

  @override
  List<Object?> get props => [deviceId];
}
