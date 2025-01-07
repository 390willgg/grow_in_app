import 'package:equatable/equatable.dart';
import 'package:hive/hive.dart';

import '../soil_measurement/soil_measurement.dart';

part 'device.g.dart';

@HiveType(typeId: 4)
class Device extends Equatable {
  @HiveField(1)
  final String id;
  @HiveField(2)
  final List<SoilMeasurement> data;

  const Device({
    required this.id,
    required this.data,
  });

  @override
  List<Object?> get props => [id, data];
}
