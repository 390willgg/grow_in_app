import 'package:dartz/dartz.dart';

import '../../../../utils/error/failure.dart';
import '../repositories/device_repository.dart';

class SaveUserDeviceIdUseCase {
  final DeviceRepository _deviceRepository;

  SaveUserDeviceIdUseCase(this._deviceRepository);

  Future<Either<Failure, Unit>> call(String? deviceId, String? userId) async {
    return await _deviceRepository.saveUserDeviceID(deviceId, userId);
  }
}
