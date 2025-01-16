import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

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
        final result = await getDevice.call(
          event.deviceId,
        );

        result.fold(
          (failure) async => emit(
            DeviceLoadedFailure(message: "Failed to get device"),
          ),
          (device) async => emit(DeviceLoadedSuccess(device)),
        );
      },
    );
  }
}
