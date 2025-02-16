import 'package:dartz/dartz.dart';
import 'package:grow_in_app/utils/error/failure.dart';

import '../repositories/device_repository.dart';

class GetMoistureThresholdUseCases {
  final DeviceRepository repository;

  GetMoistureThresholdUseCases({required this.repository});

  Stream<Either<Failure, int?>> call(String deviceId) {
    return repository.getMoistureThreshold(deviceId);
  }
}
