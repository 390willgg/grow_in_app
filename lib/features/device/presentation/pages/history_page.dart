import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../../../utils/extensions/soil_humidity_extensions.dart';
import '../../../device/presentation/widgets/average_quality_score.dart';

class HistoryPage extends StatelessWidget {
  const HistoryPage({super.key});

  @override
  Widget build(BuildContext context) {
    final sampleData = [
      "23:39:56",
      "00:09:56",
      "00:39:57",
      "01:09:58",
      "01:39:59",
      "02:10:00",
      "02:40:01",
      "03:10:02",
      "03:40:03",
      "04:10:04"
    ];
    final sampleMoistureData = [71, 71, 70, 70, 70, 69, 69, 74, 69, 69];
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      key: key,
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Expanded(
          child: CalendarDatePicker(
            firstDate: DateTime.now().subtract(const Duration(days: 365)),
            lastDate: DateTime(2024, 12, 19),
            initialDate: DateTime(2024, 12, 19),
            onDateChanged: (date) {
              // GoRouter.of(context).go("/history/detail-history", extra: date);
            },
          ),
        ),
        Expanded(
          child: Padding(
            padding: const EdgeInsets.only(left: 16, right: 16),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              key: const Key("HomePage"),
              spacing: 16.0,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                AverageQualityScore(
                  score: 70.2,
                  grade: SoilHumidityGrade.moist.name,
                ),
                Expanded(
                  flex: 2,
                  child: Container(
                    padding: const EdgeInsets.all(16.0),
                    decoration: BoxDecoration(
                      color: Theme.of(context).colorScheme.surface,
                      borderRadius: BorderRadius.circular(8.0),
                    ),
                    child: Column(
                      spacing: 8,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          "Date: 19th Desember 2021",
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Expanded(
                          child: ListView.builder(
                            itemCount: 10, // Replace with actual article count
                            itemBuilder: (context, index) {
                              return ListTile(
                                title: Text("Time ${sampleData[index]}"),
                                subtitle: Text(
                                    "Moisture ${sampleMoistureData[index]}%"),
                                onTap: () {
                                  GoRouter.of(context)
                                      .go("/article/detail-article");
                                },
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
  }
}
