import 'dart:convert';

import 'package:firebase_database/firebase_database.dart';

import '../../../../error/exceptions.dart';
import '../../domain/entities/device/device.dart';
import '../models/device/device_model.dart';

abstract class DeviceRemoteDataSource {
  Future<Device?> getDevice(String deviceId);
}

class DeviceRemoteDataSourceImplementation implements DeviceRemoteDataSource {
  final DatabaseReference ref;

  DeviceRemoteDataSourceImplementation({required this.ref});

  @override
  Future<Device?> getDevice(String deviceId) async {
    DataSnapshot snapshot = await ref.child('devices/$deviceId').get();
    final map =
        Map<String, dynamic>.from(jsonDecode(jsonEncode(snapshot.value)));
    if (snapshot.exists) {
      return DeviceModel.fromJson(map, deviceId);
    } else {
      throw const EmptyException(message: 'Device not found in devices');
    }
  }
}
