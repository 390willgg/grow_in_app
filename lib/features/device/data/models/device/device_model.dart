import 'package:hive/hive.dart';

import '../../../domain/entities/device/device.dart';
import '../../../domain/entities/soil_measurement/soil_measurement.dart';
import '../soil_measurement.dart/soil_measurement_model.dart';

part 'device_model.g.dart';

@HiveType(typeId: 5)
class DeviceModel extends Device {
  const DeviceModel({required super.id, required super.data});

  factory DeviceModel.fromJson(Map<String, dynamic> json, String id) {
    List<SoilMeasurementModel> readings = [];
    if (json['readings'] != null) {
      json['readings'].forEach((key, value) {
        readings.add(SoilMeasurementModel.fromJson(value, key));
      });
    }

    return DeviceModel(
      id: id,
      data: readings,
    );
  }

  Map<String, dynamic> toJson() {
    Map<String, dynamic> readingsMap = {};
    for (var reading in data) {
      readingsMap[reading.id] = (reading as SoilMeasurementModel).toJson();
    }

    return {
      'readings': readingsMap,
    };
  }
}
