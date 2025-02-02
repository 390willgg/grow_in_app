import 'package:dartz/dartz.dart';
import 'package:hive/hive.dart';

import '../../../../utils/common/helpers/network_helper.dart';
import '../../../../utils/error/failure.dart';
import '../../domain/entities/device/device.dart';
import '../../domain/repositories/device_repository.dart';
import '../datasources/local_datasources.dart';
import '../datasources/remote_datasources.dart';

class DeviceRepositoryImplementation extends DeviceRepository {
  final DeviceRemoteDataSource remoteDataSource;
  final DeviceLocalDataSource localDataSource;
  final Box box;

  DeviceRepositoryImplementation({
    required this.remoteDataSource,
    required this.localDataSource,
    required this.box,
  });

  @override
  Future<Either<Failure, Device?>> getDevice(String deviceId) async {
    try {
      bool isConnected = await NetworkHelper.isConnected();
      if (isConnected) {
        final Device? remoteDevice = await remoteDataSource.getDevice(deviceId);
        if (remoteDevice != null) {
          box.put(deviceId, remoteDevice);
          return Right(remoteDevice);
        } else {
          return Left(ServerFailure());
        }
      } else {
        final Device? localDevice = await localDataSource.getDevice(deviceId);
        if (localDevice != null) {
          return Right(localDevice);
        } else {
          return Left(ServerFailure());
        }
      }
    } catch (e) {
      return Left(OfflineFailure());
    }
  }

  @override
  Future<Either<Failure, Unit>> saveUserDeviceID(
    String? deviceID,
    String? userId,
  ) async {
    try {
      bool isConnected = await NetworkHelper.isConnected();
      if (isConnected) {
        await remoteDataSource.saveUserDeviceID(deviceID, userId);
        return Right(unit);
      } else {
        return Left(ServerFailure());
      }
    } catch (e) {
      return Left(OfflineFailure());
    }
  }
}
