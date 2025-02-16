import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import '../../../../utils/constants/image_strings.dart';
import '../../../../utils/routes/routes.dart';
import '../bloc/device/device_bloc.dart';

class AddDevicePage extends StatefulWidget {
  const AddDevicePage({super.key});

  @override
  State<AddDevicePage> createState() => _AddDevicePageState();
}

class _AddDevicePageState extends State<AddDevicePage> {
  final _formKey = GlobalKey<FormState>();
  final _deviceIDController = TextEditingController();
  final FocusNode _deviceIDFocusNode = FocusNode();

  @override
  void dispose() {
    _deviceIDController.dispose();
    _deviceIDFocusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    void clearText() {
      _deviceIDController.clear();
    }

    return Scaffold(
      appBar: AppBar(
        title: const Text("Add Device"),
      ),
      body: SingleChildScrollView(
        child: Center(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Form(
              key: _formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                mainAxisSize: MainAxisSize.min,
                spacing: 16,
                children: [
                  Image(
                    image: AssetImage(iotImage),
                  ),
                  Text(
                    "Add a device to monitor your plants",
                    style: Theme.of(context).textTheme.bodyMedium,
                  ),
                  TextFormField(
                    controller: _deviceIDController,
                    focusNode: _deviceIDFocusNode,
                    decoration: InputDecoration(
                      labelText: "Device ID",
                      hintText: "Enter device ID",
                      suffixIcon: IconButton(
                        onPressed: clearText,
                        icon: const Icon(Icons.clear),
                      ),
                    ),
                    keyboardType: TextInputType.text,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter a device ID';
                      }
                      return null;
                    },
                  ),
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                      onPressed: () {
                        if (_formKey.currentState!.validate()) {
                          context.read<DeviceBloc>().add(
                                GetDeviceEvent(
                                  _deviceIDController.text,
                                ),
                              );
                        }
                      },
                      style: ButtonStyle(
                        shape: WidgetStateProperty.all(
                          RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8),
                          ),
                        ),
                      ),
                      child: const Text("Add Device"),
                    ),
                  ),
                  BlocConsumer<DeviceBloc, DeviceState>(
                    listener: (context, state) {
                      if (state is DeviceLoadedSuccess) {
                        context.go(AppRoute.initialRoute);
                      }
                    },
                    builder: (context, state) {
                      if (state is DeviceLoadedInProgress) {
                        return const Center(
                          child: CircularProgressIndicator(),
                        );
                      } else if (state is DeviceLoadedFailure) {
                        return Center(
                          child: Text(
                            state.message.toString(),
                            style: TextStyle(color: Colors.red),
                          ),
                        );
                      }
                      return const SizedBox.shrink();
                    },
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
