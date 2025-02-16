import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:grow_in_app/features/device/domain/usecases/get_moisture_threshold.dart';
import 'package:grow_in_app/features/device/domain/usecases/save_user_device_id.dart';
import 'package:grow_in_app/features/device/domain/usecases/update_moisture_threshold.dart';
import 'package:grow_in_app/utils/common/helpers/strings_helper.dart';
import 'package:grow_in_app/utils/error/failure.dart';

import '../../../../../main.dart';
import '../../../domain/entities/device/device.dart';
import '../../../domain/usecases/get_device.dart';

part 'device_event.dart';
part 'device_state.dart';

class DeviceBloc extends Bloc<DeviceEvent, DeviceState> {
  final GetDeviceUseCase getDevice;
  final SaveUserDeviceIdUseCase saveUserDeviceIdUseCase;
  final GetMoistureThresholdUseCases getMoistureThreshold;
  final UpdateMoistureThresholdUseCases updateMoistureThresholdUseCase;
  final User? user;

  StreamSubscription<Either<Failure, int?>>? moistureThresholdSubscription;

  DeviceBloc({
    required this.getDevice,
    required this.saveUserDeviceIdUseCase,
    required this.getMoistureThreshold,
    required this.updateMoistureThresholdUseCase,
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
              if (device != null && user != null) {
                final resultData = await saveUserDeviceIdUseCase.call(
                  device.id,
                  user!.uid,
                );
                await resultData.fold(
                  (failure) async {
                    emit(DeviceLoadedFailure(
                      message: StringsHelper.mapFailureToMessage(failure),
                    ));
                  },
                  (_) async {
                    emit(DeviceLoadedSuccess(
                      device: device,
                      deviceId: event.deviceId,
                      moistureThreshold: null,
                    ));
                    _subscribeToMoistureThreshold(device.id);
                  },
                );
              } else {
                emit(DeviceLoadedFailure(message: "Device or user is null"));
              }
            },
          );
        } catch (e) {
          logger.e(e.toString());
          emit(DeviceLoadedFailure(message: e.toString()));
        }
      },
    );

    on<MoistureThresholdChangedEvent>(
      (event, emit) {
        final currentState = state;
        if (currentState is DeviceLoadedSuccess) {
          emit(
            currentState.copyWith(
              moistureThreshold: event.moistureThreshold,
            ),
          );
        }
      },
    );

    on<UpdateMoistureThresholdEvent>(
      (event, emit) async {
        final currentState = state;
        if (currentState is DeviceLoadedSuccess) {
          final result = await updateMoistureThresholdUseCase.call(
            currentState.deviceId,
            event.moistureThreshold,
          );
          
          await result.fold(
            (failure) async {
              emit(DeviceLoadedFailure(
                message: StringsHelper.mapFailureToMessage(failure),
              ));
            },
            (_) async {
              emit(currentState.copyWith(
                moistureThreshold: event.moistureThreshold,
              ));
            },
          );
        }
      },
    );
  }

  void _subscribeToMoistureThreshold(String deviceId) {
    moistureThresholdSubscription?.cancel();
    moistureThresholdSubscription = getMoistureThreshold(deviceId).listen(
      (result) {
        result.fold(
          (failure) {
            logger.i(failure);
            add(MoistureThresholdChangedEvent(null));
          },
          (threshold) {
            logger.i(threshold);
            add(MoistureThresholdChangedEvent(threshold));
          },
        );
      },
    );
  }

  @override
  Future<void> close() {
    moistureThresholdSubscription?.cancel();
    return super.close();
  }
}
