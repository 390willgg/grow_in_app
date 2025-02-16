import 'dart:convert';

import 'package:dartz/dartz.dart';
import 'package:firebase_database/firebase_database.dart';

import '../../../../utils/error/exceptions.dart';
import '../../domain/entities/device/device.dart';
import '../models/device/device_model.dart';

abstract class DeviceRemoteDataSource {
  Future<Device?> getDevice(String deviceId);
  Future<Unit> saveUserDeviceID(String? deviceID, String? userId);
  Future<Unit> updateMoistureThreshold(int threshold, String deviceId);
  Stream<int?> getMoistureThreshold(String deviceId);
}

class DeviceRemoteDataSourceImplementation implements DeviceRemoteDataSource {
  final DatabaseReference ref;

  DeviceRemoteDataSourceImplementation({required this.ref});

  @override
  Future<Device?> getDevice(String deviceId) async {
    DataSnapshot snapshot = await ref.child('devices/$deviceId').get();
    final map = Map<String, dynamic>.from(
      jsonDecode(jsonEncode(snapshot.value)),
    );
    if (snapshot.exists) {
      return DeviceModel.fromJson(map, deviceId);
    } else {
      throw const EmptyException(message: 'Device not found in devices');
    }
  }

  @override
  Future<Unit> saveUserDeviceID(String? deviceID, String? userId) async {
    try {
      await ref.child('user/$userId').update({'device_id': deviceID});
      return unit;
    } catch (e) {
      throw Exception('Failed to save user device ID: $e');
    }
  }

  @override
  Future<Unit> updateMoistureThreshold(int threshold, String deviceId) async {
    try {
      await ref
          .child('devices/$deviceId')
          .update({'moistureThreshold': threshold});
      return unit;
    } catch (e) {
      throw Exception('Failed to update moisture threshold: $e');
    }
  }

  @override
  Stream<int?> getMoistureThreshold(String deviceId) {
    try {
      return ref.child('devices/$deviceId/moistureThreshold').onValue.map(
        (event) {
          final value = event.snapshot.value;
          if (value is int) {
            return value;
          } else {
            throw Exception('Invalid moisture threshold value');
          }
        },
      );
    } catch (e) {
      throw ServerException(message: 'Failed to get moisture threshold: $e');
    }
  }
}
