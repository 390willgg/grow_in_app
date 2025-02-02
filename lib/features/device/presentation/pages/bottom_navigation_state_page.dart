import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:grow_in_app/features/device/presentation/bloc/device/device_bloc.dart';

import '../../../../utils/common/helpers/router_helper.dart';
import '../../../../utils/constants/text_strings.dart';
import '../../../../utils/routes/routes.dart';

class BottomNavigationState extends StatelessWidget {
  const BottomNavigationState({super.key, required this.child});

  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(homeTitle),
        actions: [
          IconButton(
            onPressed: () async {
              context.push(AppRoute.settingsRoute);
            },
            icon: const Icon(Icons.settings),
          ),
        ],
      ),
      floatingActionButton: BlocBuilder<DeviceBloc, DeviceState>(
        builder: (context, state) {
          if (state is DeviceLoadedSuccess) {
            return SizedBox();
          }
          return FloatingActionButton(
            onPressed: () async {
              context.push(AppRoute.addDeviceRoute);
            },
            child: const Icon(Icons.add),
          );
        },
      ),
      body: child,
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: RouterHelper.calculateSelectedIndex(context),
        onTap: (int idx) => RouterHelper.onItemTapped(idx, context),
        selectedItemColor: Colors.green[200],
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: homeTitle,
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.history),
            label: historyTitle,
          ),
        ],
      ),
    );
  }
}
