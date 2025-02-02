import '../../features/device/data/models/soil_measurement.dart/soil_measurement_model.dart';

enum SoilHumidityGrade {
  veryDry("Very Dry"),
  dry("Dry"),
  moderate("Moderate"),
  moist("Moist"),
  veryMoist("Very Moist"),
  saturated("Saturated");

  final String name;
  const SoilHumidityGrade(this.name);
}

extension SoilHumidityGradeExtension on SoilHumidityGrade {
  double get min {
    switch (this) {
      case SoilHumidityGrade.veryDry:
        return 0.0;
      case SoilHumidityGrade.dry:
        return 10.0;
      case SoilHumidityGrade.moderate:
        return 20.0;
      case SoilHumidityGrade.moist:
        return 40.0;
      case SoilHumidityGrade.veryMoist:
        return 60.0;
      case SoilHumidityGrade.saturated:
        return 80.0;
    }
  }

  double get max {
    switch (this) {
      case SoilHumidityGrade.veryDry:
        return 10.0;
      case SoilHumidityGrade.dry:
        return 20.0;
      case SoilHumidityGrade.moderate:
        return 40.0;
      case SoilHumidityGrade.moist:
        return 60.0;
      case SoilHumidityGrade.veryMoist:
        return 80.0;
      case SoilHumidityGrade.saturated:
        return 100.0;
    }
  }

  double calculateAverageMoisture(List<SoilMeasurementModel> data) {
    if (data.isEmpty) return 0.0;
    double totalMoisture = data.fold(0, (sum, item) => sum + item.moisture);
    return totalMoisture / data.length;
  }

  static String fromAverageMoisture(double moisture) {
    for (SoilHumidityGrade grade in SoilHumidityGrade.values) {
      if (moisture >= grade.min && moisture < grade.max) {
        return grade.name;
      }
    }
    return SoilHumidityGrade.saturated.name;
  }
}

extension ParseToString on SoilHumidityGrade {
  String toShortString() {
    return toString().split(' ').last;
  }
}
