import 'package:dartz/dartz.dart';

import '../../../../utils/error/failure.dart';
import '../entities/device/device.dart';
import '../repositories/device_repository.dart';

class GetDeviceUseCase {
  final DeviceRepository repository;

  GetDeviceUseCase({required this.repository});

  Future<Either<Failure, Device?>> call(String deviceId) async {
    return await repository.getDevice(deviceId);
  }
}
