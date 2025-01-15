import 'package:flutter/cupertino.dart';
import 'package:go_router/go_router.dart';

import '../../features/auth/presentation/pages/sign_in_page.dart';
import '../../features/auth/presentation/pages/sign_up_page.dart';
import '../../features/device/presentation/pages/add_device_page.dart';
import '../../features/device/presentation/pages/dashboard_page.dart';
import '../../features/history/presentation/pages/history_page.dart';
import '../../features/profile/presentation/pages/all_user_page.dart';
import '../../features/profile/presentation/pages/detail_user_page.dart';

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
          path: AppRoute.homeRoute,
          name: 'home',
          parentNavigatorKey: _shellNavigatorKey,
          pageBuilder: (context, state) => const NoTransitionPage(
            child: HomePage(),
          ),
        ),
        GoRoute(
          path: AppRoute.historyRoute,
          name: 'history',
          parentNavigatorKey: _shellNavigatorKey,
          pageBuilder: (context, state) => const NoTransitionPage(
            child: HistoryPage(),
          ),
        ),
      ],
    ),
    GoRoute(
      path: AppRoute.allUsersRoute,
      name: 'all_users',
      pageBuilder: (context, state) => const NoTransitionPage(
        child: AllUsersPage(),
      ),
      routes: [
        GoRoute(
          path: AppRoute.detailUserRoute,
          name: "detail_user",
          pageBuilder: (context, state) => NoTransitionPage(
            child: DetailUserPage(
              state.extra as int,
            ),
          ),
        ),
      ],
    ),
    GoRoute(
      path: AppRoute.initialRoute,
      name: 'login page',
      pageBuilder: (context, state) => const NoTransitionPage(
        child: SignInPage(),
      ),
    ),
    GoRoute(
      path: AppRoute.registerRoute,
      name: 'register page',
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
      path: AppRoute.settingsRoute,
      name: 'settings page',
      pageBuilder: (context, state) => const NoTransitionPage(
        child: SettingPage(),
      ),
      routes: [
        GoRoute(
          path: AppRoute.aboutRoute,
          name: 'about page',
          pageBuilder: (context, state) => const NoTransitionPage(
            child: AboutPage(),
          ),
        ),
      ],
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

  static const String allUsersRoute = '/all_users';
  static const String detailUserRoute = 'detail-user';

  static const String settingsRoute = '/settings';
  static const String aboutRoute = '/about';
}
