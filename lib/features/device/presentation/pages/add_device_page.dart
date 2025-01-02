import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:grow_in_app/injection.dart';

import '../bloc/device_bloc.dart';

class AddDevicePage extends StatelessWidget {
  const AddDevicePage({super.key});

  @override
  Widget build(BuildContext context) {
    final TextEditingController deviceController = TextEditingController();

    void clearText() {
      deviceController.clear();
    }

    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.surface,
      appBar: AppBar(
        title: const Text("Add Device"),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            mainAxisSize: MainAxisSize.min,
            spacing: 16,
            children: [
              TextField(
                controller: deviceController,
                decoration: InputDecoration(
                  labelText: "Device ID",
                  hintText: "Enter device ID",
                  border: const OutlineInputBorder(),
                  suffixIcon: IconButton(
                    onPressed: clearText,
                    icon: const Icon(Icons.clear),
                  ),
                ),
                onSubmitted: (value) {
                  // context.read<DeviceBloc>().add(GetDeviceEvent(value));
                },
              ),
              BlocBuilder<DeviceBloc, DeviceState>(
                bloc: locator.get<DeviceBloc>()..add(GetDeviceEvent("000001")),
                builder: (context, state) {
                  if (state is DeviceLoadedInProgress) {
                    return const Center(
                      child: CircularProgressIndicator(),
                    );
                  } else if (state is DeviceLoadedFailure) {
                    return Center(
                      child: Text(state.message),
                    );
                  } else if (state is DeviceLoadedSuccess) {
                    return Center(
                      child: Text(
                        'Device successfully added!',
                        overflow: TextOverflow.ellipsis,
                        maxLines: 1,
                        style: TextStyle(
                          color: Theme.of(context).colorScheme.onSecondary,
                          fontSize: 14,
                          fontWeight: FontWeight.normal,
                          height: 1.5,
                          letterSpacing: 0.15,
                          wordSpacing: 0,
                          decoration: TextDecoration.none,
                        ),
                      ),
                    );
                  } else {
                    return ElevatedButton(
                      onPressed: () {
                        final deviceId = deviceController.text;
                        if (deviceId.isNotEmpty) {
                          // deviceBloc.add(DeviceFetchData(deviceId));
                        } else {
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                              content: Text('Please enter a device ID'),
                              backgroundColor: Colors.red,
                              duration: Duration(seconds: 2),
                            ),
                          );
                        }
                      },
                      child: const Text("Add Device"),
                    );
                  }
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
