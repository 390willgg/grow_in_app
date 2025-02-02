import 'package:dartz/dartz.dart';

import '../../../../utils/error/failure.dart';
import '../entities/device/device.dart';

abstract class DeviceRepository {
  Future<Either<Failure, Device?>> getDevice(String deviceId);
  Future<Either<Failure, Unit>> saveUserDeviceID(
    String? deviceID,
    String? userId,
  );
}
