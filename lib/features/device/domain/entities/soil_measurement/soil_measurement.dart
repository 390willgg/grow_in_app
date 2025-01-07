import 'package:equatable/equatable.dart';
import 'package:hive/hive.dart';

part 'soil_measurement.g.dart';

@HiveType(typeId: 3)
class SoilMeasurement extends Equatable {
  @HiveField(1)
  final String id;
  @HiveField(2)
  final DateTime date;
  @HiveField(3)
  final String time;
  @HiveField(4)
  final double moisture;

  const SoilMeasurement({
    required this.time,
    required this.id,
    required this.date,
    required this.moisture,
  });

  @override
  List<Object?> get props => [id, time, date, moisture];
}
