import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../routes/routes.dart';

class RouterHelper {
  RouterHelper._();

  static onItemTapped(int index, BuildContext context) {
    switch (index) {
      case 0:
        GoRouter.of(context).go(AppRoute.initialRoute);
        break;
      case 1:
        GoRouter.of(context).go(AppRoute.historyRoute);
        break;
      default:
        GoRouter.of(context).go(AppRoute.initialRoute);
        break;
    }
  }

  static int calculateSelectedIndex(BuildContext context) {
    final String location = GoRouterState.of(context).uri.path;
    if (location == AppRoute.homeRoute) {
      return 0;
    }
    if (location.startsWith(AppRoute.historyRoute)) {
      return 1;
    }
    return 0;
  }
}
