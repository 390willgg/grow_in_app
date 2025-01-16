import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../../domain/entities/soil_measurement/soil_measurement.dart';

class DeviceDetailsPage extends StatelessWidget {
  final String deviceId;
  final List<SoilMeasurement> measurements;

  const DeviceDetailsPage({
    super.key,
    required this.deviceId,
    required this.measurements,
  });

  // static List<SoilMeasurement> generateRandomMeasurements(int count) {
  //   final random = Random();
  //   final now = DateTime.now();
  //   return List.generate(
  //     count,
  //     (index) {
  //       final date = now.subtract(Duration(minutes: index * 30));
  //       final time = DateTime(
  //         date.year,
  //         date.month,
  //         date.day,
  //         date.hour,
  //         date.minute,
  //         date.second,
  //       );
  //       final moisture = random.nextDouble() * 100;
  //       return SoilMeasurement(
  //         date: date.toString(),
  //         time: time.toString(),
  //         moisture: moisture.toInt(),
  //       );
  //     },
  //   );
  // }

  @override
  Widget build(BuildContext context) {
    // final randomMeasurements = generateRandomMeasurements(20);

    return Scaffold(
      appBar: AppBar(
        title: const Text("Device Details"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Device ID: $deviceId",
              style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 16),
            const Text("Soil Measurements:"),
            const SizedBox(height: 16),
            Expanded(
              child: LineChart(
                LineChartData(
                  gridData: const FlGridData(show: true),
                  titlesData: FlTitlesData(
                    leftTitles: const AxisTitles(
                      sideTitles: SideTitles(showTitles: true),
                    ),
                    bottomTitles: AxisTitles(
                      sideTitles: SideTitles(
                        showTitles: true,
                        getTitlesWidget: (value, meta) {
                          final date = DateTime.fromMillisecondsSinceEpoch(
                            value.toInt(),
                          );
                          return SideTitleWidget(
                            meta: meta,
                            child: Text(
                              DateFormat('MM/dd HH:mm').format(date),
                            ),
                          );
                        },
                      ),
                    ),
                  ),
                  borderData: FlBorderData(
                    show: true,
                    border: Border.all(
                      color: const Color(0xff37434d),
                    ),
                  ),
                  lineBarsData: [
                    // LineChartBarData(
                    //   spots: randomMeasurements
                    //       .map(
                    //         (measurement) => FlSpot(
                    //           50.0,
                    //           measurement.moisture.toDouble(),
                    //         ),
                    //       )
                    //       .toList(),
                    //   isCurved: true,
                    //   color: Colors.blue,
                    //   barWidth: 4,
                    //   belowBarData: BarAreaData(show: false),
                    // ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
