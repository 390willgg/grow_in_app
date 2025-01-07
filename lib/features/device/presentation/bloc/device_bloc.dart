import 'package:bloc/bloc.dart';
import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';

import '../../../../error/failure.dart';
import '../../domain/entities/device/device.dart';
import '../../domain/usecases/get_device.dart';

part 'device_event.dart';
part 'device_state.dart';

class DeviceBloc extends Bloc<DeviceEvent, DeviceState> {
  final GetDevice getDevice;

  DeviceBloc({required this.getDevice}) : super(DeviceStateEmpty()) {
    on<GetDeviceEvent>(
      (event, emit) async {
        emit(DeviceLoadedInProgress());
        Either<Failure, Device?> resultGetDevice =
            await getDevice.execute(event.deviceId);

        resultGetDevice.fold(
          (failure) => emit(DeviceLoadedFailure("Failed to get device")),
          (device) => emit(DeviceLoadedSuccess(device)),
        );
      },
    );
  }
}
