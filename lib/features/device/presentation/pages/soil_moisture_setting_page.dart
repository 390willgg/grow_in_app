import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../bloc/device/device_bloc.dart';

class SoilMoistureSettingPage extends StatefulWidget {
  const SoilMoistureSettingPage({super.key});

  @override
  State<SoilMoistureSettingPage> createState() =>
      _SoilMoistureSettingPageState();
}

class _SoilMoistureSettingPageState extends State<SoilMoistureSettingPage> {
  double _currentThreshold = 50;

  @override
  void initState() {
    super.initState();
    final deviceBloc = context.read<DeviceBloc>();
    final state = deviceBloc.state;

    if (state is DeviceLoadedSuccess) {
      _currentThreshold = state.moistureThreshold?.toDouble() ?? 50;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Soil Moisture Setting"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              "Set Moisture Threshold",
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 16),
            BlocBuilder<DeviceBloc, DeviceState>(
              builder: (context, state) {
                if (state is DeviceLoadedSuccess) {
                  _currentThreshold = state.moistureThreshold?.toDouble() ?? 50;
                }
                return Column(
                  children: [
                    Row(
                      children: [
                        const Text("50"),
                        Expanded(
                          child: Slider(
                            value: _currentThreshold,
                            min: 50,
                            max: 70,
                            divisions: 20,
                            label: _currentThreshold.round().toString(),
                            onChanged: (value) {
                              setState(() {
                                _currentThreshold = value;
                              });
                            },
                            onChangeEnd: (value) {
                              context.read<DeviceBloc>().add(
                                    UpdateMoistureThresholdEvent(
                                      moistureThreshold: value.toInt(),
                                    ),
                                  );
                            },
                          ),
                        ),
                        const Text("70"),
                      ],
                    ),
                  ],
                );
              },
            ),
            const SizedBox(height: 16),
            Text(
              "Current Threshold: ${_currentThreshold.round()}",
              style: const TextStyle(fontSize: 16),
            ),
          ],
        ),
      ),
    );
  }
}
