import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../utils/common/helpers/date_helper.dart';
import '../../../../utils/constants/text_strings.dart';
import '../../../../utils/extensions/soil_humidity_extensions.dart';
import '../bloc/device/device_bloc.dart';
import '../widgets/average_quality_score.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<DeviceBloc, DeviceState>(
      builder: (context, state) {
        if (state is DeviceLoadedSuccess) {
          final device = state.device;

          final lastDayData = device.getLatestDayMeasurements();
          lastDayData.sort((a, b) => a.time.compareTo(b.time));

          if (lastDayData.isEmpty) {
            return const Center(
              child: Text(noDataAvailable),
            );
          }

          final sampleMoistureData = lastDayData.map((e) => e.moisture).toList();
          final averageMoisture = sampleMoistureData.reduce((a, b) => a + b) / sampleMoistureData.length;

          return Padding(
            padding: const EdgeInsets.only(
              top: 16.0,
              left: 16.0,
              right: 16.0,
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              key: const Key(homeTitle),
              children: [
                AverageQualityScore(
                  score: averageMoisture,
                  grade: SoilHumidityGradeExtension.fromAverageMoisture(
                    averageMoisture,
                  ),
                ),
                Expanded(
                  child: Container(
                    key: const Key("lastDayData"),
                    margin: const EdgeInsets.only(top: 16),
                    decoration: BoxDecoration(
                      color: Theme.of(context).colorScheme.surface,
                      borderRadius: BorderRadius.circular(8),
                    ),
                    padding: const EdgeInsets.all(16),
                    alignment: Alignment.topCenter,
                    child: Column(
                      key: const Key("lastDayDataColumn"),
                      mainAxisAlignment: MainAxisAlignment.start,
                      mainAxisSize: MainAxisSize.min,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      verticalDirection: VerticalDirection.down,
                      textBaseline: TextBaseline.alphabetic,
                      textDirection: TextDirection.ltr,
                      children: [
                        Text(
                          "Date: ${DateHelper.formatDate(lastDayData.first.date)}",
                          style: const TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                          textAlign: TextAlign.start,
                          key: const Key("date"),
                          maxLines: 1,
                        ),
                        const SizedBox(
                          height: 16,
                        ),
                        Flexible(
                          child: ListView.builder(
                            shrinkWrap: true,
                            key: const Key("lastDayDataListView"),
                            itemCount: lastDayData
                                .length, // Replace with actual article count
                            itemBuilder: (context, index) {
                              return ListTile(
                                enableFeedback: false,
                                title: Text(
                                  "Time ${lastDayData[index].time}",
                                ),
                                subtitle: Text(
                                  "Moisture ${lastDayData[index].moisture.toInt()}%",
                                ),
                                onTap: () {},
                              );
                            },
                          ),
                        ),
                      ],
                    ),
                  ),
                )
              ],
            ),
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

