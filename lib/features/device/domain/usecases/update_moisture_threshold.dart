import 'package:dartz/dartz.dart';

import '../../../../utils/error/failure.dart';
import '../repositories/device_repository.dart';

class UpdateMoistureThresholdUseCases {
  final DeviceRepository repository;

  UpdateMoistureThresholdUseCases({required this.repository});

  Future<Either<Failure, Unit>> call(String deviceId, int threshold) async {
    return await repository.updateMoistureThreshold(threshold, deviceId);
  }
}
