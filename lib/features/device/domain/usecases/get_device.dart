import 'package:dartz/dartz.dart';

import '../../../../utils/error/failure.dart';
import '../entities/device/device.dart';
import '../repositories/device_repository.dart';

class GetDevice {
  final DeviceRepository repository;

  GetDevice({required this.repository});

  Future<Either<Failure, Device?>> call(String deviceId) async {
    return await repository.getDevice(deviceId);
  }
}
