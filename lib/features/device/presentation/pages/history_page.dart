import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';

import '../../../../utils/constants/text_strings.dart';
import '../../../../utils/extensions/soil_humidity_extensions.dart';
import '../../domain/entities/soil_measurement/soil_measurement.dart';
import '../bloc/device/device_bloc.dart';
import '../widgets/average_quality_score.dart';

class HistoryPage extends StatefulWidget {
  const HistoryPage({super.key});

  @override
  State<HistoryPage> createState() => _HistoryPageState();
}

class _HistoryPageState extends State<HistoryPage> {
  DateTime? selectedDate;

  List<SoilMeasurement> getMeasurementsByDate(
      List<SoilMeasurement> measurements, DateTime date) {
    return measurements.where(
      (measurement) {
        return measurement.date.year == date.year &&
            measurement.date.month == date.month &&
            measurement.date.day == date.day;
      },
    ).toList();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<DeviceBloc, DeviceState>(
      builder: (context, state) {
        if (state is DeviceLoadedSuccess) {
          final device = state.device;
          if (device == null) {
            return const Center(
              child: Text(noDeviceFound),
            );
          }

          if (selectedDate == null && device.data.isNotEmpty) {
            selectedDate = device.data.first.date;
          }

          List<SoilMeasurement> measurements = getMeasurementsByDate(
            device.data,
            selectedDate!,
          );

          measurements.sort(
            (a, b) {
              return a.time.compareTo(b.time);
            },
          );

          final averageMoisture = measurements.isNotEmpty
              ? measurements.map((e) => e.moisture).reduce((a, b) => a + b) /
                  measurements.length
              : 0.0;

          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            key: widget.key,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              CalendarDatePicker(
                firstDate: device.data.last.date,
                lastDate: device.data.first.date,
                initialDate: device.data.first.date,
                onDateChanged: (date) {
                  setState(
                    () {
                      selectedDate = date;
                      measurements = getMeasurementsByDate(
                        device.data,
                        selectedDate!,
                      );
                    },
                  );
                },
              ),
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.only(left: 16, right: 16),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    spacing: 16.0,
                    key: const Key("HistoryPage"),
                    children: [
                      AverageQualityScore(
                        score: averageMoisture,
                        grade: SoilHumidityGradeExtension.fromAverageMoisture(
                          averageMoisture,
                        ),
                      ),
                      Expanded(
                        child: Container(
                          padding: const EdgeInsets.all(16.0),
                          decoration: BoxDecoration(
                            color: Theme.of(context).colorScheme.surface,
                            borderRadius: BorderRadius.circular(8.0),
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "Date: ${DateFormat('d MMMM y').format(selectedDate!)}",
                                style: const TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              Expanded(
                                child: ListView.builder(
                                  itemCount: measurements.length,
                                  itemBuilder: (context, index) {
                                    return ListTile(
                                      title: Text(
                                        "Time ${measurements[index].time}",
                                      ),
                                      subtitle: Text(
                                        "Moisture ${measurements[index].moisture.toInt()}%",
                                      ),
                                      onTap: () {},
                                    );
                                  },
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          );
        } else if (state is DeviceLoadedFailure) {
          return Center(
            child: Text(
              state.message.toString(),
              style: const TextStyle(color: Colors.red),
            ),
          );
        } else {
          return const Center(
            child: Text(deviceNotYetPairing),
          );
        }
      },
    );
  }
}
