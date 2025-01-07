import 'package:equatable/equatable.dart';

class Growth extends Equatable {
  final double? daysToHarvest;
  final String? description;
  final String? sowing;
  final double? phMaximum;
  final double? phMinimum;
  final int? light;
  final int? atmosphericHumidity;
  final List<String>? growthMonths;
  final List<String>? bloomMonths;
  final List<String>? fruitMonths;
  final Map<String, dynamic>? rowSpacing;
  final Map<String, dynamic>? spread;
  final Map<String, dynamic>? minimumPrecipitation;
  final Map<String, dynamic>? maximumPrecipitation;
  final Map<String, dynamic>? minimumRootDepth;
  final Map<String, dynamic>? minimumTemperature;
  final Map<String, dynamic>? maximumTemperature;
  final int? soilNutriments;
  final int? soilSalinity;
  final int? soilTexture;
  final int? soilHumidity;

  const Growth({
    this.daysToHarvest,
    this.description,
    this.sowing,
    this.phMaximum,
    this.phMinimum,
    this.light,
    this.atmosphericHumidity,
    this.growthMonths,
    this.bloomMonths,
    this.fruitMonths,
    this.rowSpacing,
    this.spread,
    this.minimumPrecipitation,
    this.maximumPrecipitation,
    this.minimumRootDepth,
    this.minimumTemperature,
    this.maximumTemperature,
    this.soilNutriments,
    this.soilSalinity,
    this.soilTexture,
    this.soilHumidity,
  });

  @override
  List<Object?> get props => [
        daysToHarvest,
        description,
        sowing,
        phMaximum,
        phMinimum,
        light,
        atmosphericHumidity,
        growthMonths,
        bloomMonths,
        fruitMonths,
        rowSpacing,
        spread,
        minimumPrecipitation,
        maximumPrecipitation,
        minimumRootDepth,
        minimumTemperature,
        maximumTemperature,
        soilNutriments,
        soilSalinity,
        soilTexture,
        soilHumidity,
      ];
}
