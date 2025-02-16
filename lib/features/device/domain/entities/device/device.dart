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

  List<SoilMeasurement> getLatestDayMeasurements() {
    if (data.isEmpty) return [];
    data.sort((a, b) => b.date.compareTo(a.date));
    DateTime latestDate = data.first.date;
    return data
        .where((measurement) => isSameDay(measurement.date, latestDate))
        .toList();
  }

  bool isSameDay(DateTime date1, DateTime date2) {
    return date1.year == date2.year &&
        date1.month == date2.month &&
        date1.day == date2.day;
  }

  @override
  List<Object?> get props => [id, data];
}
