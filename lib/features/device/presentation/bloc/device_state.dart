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
  final Device? device;
  DeviceLoadedSuccess(this.device);

  @override
  List<Object?> get props => [device];
}

class DeviceLoadedFailure extends DeviceState {
  final String message;
  DeviceLoadedFailure(this.message);

  @override
  List<Object?> get props => [message];
}
