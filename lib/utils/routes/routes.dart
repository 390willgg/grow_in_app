import 'package:flutter/cupertino.dart';
import 'package:go_router/go_router.dart';

import '../../features/auth/presentation/pages/sign_in_page.dart';
import '../../features/auth/presentation/pages/sign_up_page.dart';
import '../../features/device/presentation/pages/about_page.dart';
import '../../features/device/presentation/pages/add_device_page.dart';
import '../../features/device/presentation/pages/bottom_navigation_state_page.dart';
import '../../features/device/presentation/pages/history_page.dart';
import '../../features/device/presentation/pages/home_page.dart';
import '../../features/device/presentation/pages/setting_page.dart';
import '../../features/device/presentation/pages/soil_moisture_setting_page.dart';
import '../constants/text_strings.dart';

final _rootNavigatorKey = GlobalKey<NavigatorState>(
  debugLabel: 'Root Navigator',
);

final _shellNavigatorKey = GlobalKey<NavigatorState>(
  debugLabel: 'Shell Navigator',
);

final router = GoRouter(
  navigatorKey: _rootNavigatorKey,
  initialLocation: AppRoute.initialRoute,
  debugLogDiagnostics: true,
  routes: <RouteBase>[
    ShellRoute(
      navigatorKey: _shellNavigatorKey,
      builder: (context, state, child) => BottomNavigationState(child: child),
      routes: [
        GoRoute(
          path: AppRoute.initialRoute,
          name: homeTitle,
          parentNavigatorKey: _shellNavigatorKey,
          pageBuilder: (context, state) => const NoTransitionPage(
            child: HomePage(),
          ),
        ),
        GoRoute(
          path: AppRoute.historyRoute,
          name: historyTitle,
          parentNavigatorKey: _shellNavigatorKey,
          pageBuilder: (context, state) => const NoTransitionPage(
            child: HistoryPage(),
          ),
        ),
      ],
    ),
    GoRoute(
      path: AppRoute.loginRoute,
      name: loginTitle,
      pageBuilder: (context, state) => const NoTransitionPage(
        child: SignInPage(),
      ),
    ),
    GoRoute(
      path: AppRoute.registerRoute,
      name: signUpTitle,
      pageBuilder: (context, state) => const NoTransitionPage(
        child: SignUpPage(),
      ),
    ),
    GoRoute(
      path: AppRoute.addDeviceRoute,
      pageBuilder: (context, state) => const NoTransitionPage(
        child: AddDevicePage(),
      ),
    ),
    GoRoute(
      path: AppRoute.settingSoilMoistureDeviceRoute,
      pageBuilder: (context, state) => const NoTransitionPage(
        child: SoilMoistureSettingPage(),
      ),
    ),
    GoRoute(
      path: AppRoute.aboutRoute,
      name: 'about page',
      pageBuilder: (context, state) => const NoTransitionPage(
        child: AboutPage(),
      ),
    ),
    GoRoute(
      path: AppRoute.settingsRoute,
      name: 'settings page',
      pageBuilder: (context, state) => const NoTransitionPage(
        child: SettingPage(),
      ),
    ),
  ],
);

class AppRoute {
  AppRoute._();

  static const String initialRoute = '/';

  static const String homeRoute = '/home';
  static const String historyRoute = '/history';
  static const String historyDetailRoute = 'detail-history';

  static const String loginRoute = '/login';
  static const String registerRoute = '/register';

  static const String addDeviceRoute = '/add-device';

  static const String settingsRoute = '/settings';
  static const String aboutRoute = '/about';
  static const String settingSoilMoistureDeviceRoute = '/soil-moisture';
}
