import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:grow_in_app/features/device/domain/usecases/save_user_device_id.dart';
import 'package:grow_in_app/utils/common/helpers/strings_helper.dart';

import '../../../../../main.dart';
import '../../../domain/entities/device/device.dart';
import '../../../domain/usecases/get_device.dart';

part 'device_event.dart';
part 'device_state.dart';

class DeviceBloc extends Bloc<DeviceEvent, DeviceState> {
  final GetDeviceUseCase getDevice;
  final SaveUserDeviceIdUseCase saveUserDeviceIdUseCase;
  final User? user;

  DeviceBloc({
    required this.getDevice,
    required this.saveUserDeviceIdUseCase,
    required this.user,
  }) : super(DeviceStateEmpty()) {
    on<GetDeviceEvent>(
      (event, emit) async {
        emit(DeviceLoadedInProgress());
        try {
          final result = await getDevice.call(event.deviceId);

          await result.fold(
            (failure) async => emit(
              DeviceLoadedFailure(message: "Failed to get device"),
            ),
            (device) async {
              final resultData =
                  await saveUserDeviceIdUseCase.call(device!.id, user!.uid);
              await resultData.fold(
                (failure) async {
                  emit(DeviceLoadedFailure(
                      message: StringsHelper.mapFailureToMessage(failure)));
                },
                (_) async {
                  emit(DeviceLoadedSuccess(device));
                },
              );
            },
          );
        } catch (e) {
          logger.e(e.toString());
          emit(DeviceLoadedFailure(message: e.toString()));
        }
      },
    );
  }
}
