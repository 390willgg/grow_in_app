import 'package:flutter/cupertino.dart';
import 'package:go_router/go_router.dart';
import 'package:grow_in_app/features/device/presentation/pages/add_device_page.dart';
import 'package:grow_in_app/features/device/presentation/pages/dashboard_page.dart';
import 'package:grow_in_app/features/profile/presentation/pages/all_user_page.dart';

import '../features/history/presentation/pages/history_page.dart';
import '../features/profile/presentation/pages/detail_user_page.dart';
import '../features/profile/presentation/pages/login_page.dart';

final _rootNavigatorKey = GlobalKey<NavigatorState>(
  debugLabel: 'Root Navigator',
);
final _shellNavigatorKey = GlobalKey<NavigatorState>(
  debugLabel: 'Shell Navigator',
);

final router = GoRouter(
  navigatorKey: _rootNavigatorKey,
  initialLocation: MyRouter.initialRoute,
  debugLogDiagnostics: true,
  routes: <RouteBase>[
    ShellRoute(
      navigatorKey: _shellNavigatorKey,
      builder: (context, state, child) => BottomNavigationState(child: child),
      routes: [
        GoRoute(
          path: MyRouter.homeRoute,
          name: 'home',
          parentNavigatorKey: _shellNavigatorKey,
          pageBuilder: (context, state) => const NoTransitionPage(
            child: HomePage(),
          ),
        ),
        GoRoute(
          path: MyRouter.historyRoute,
          name: 'history',
          parentNavigatorKey: _shellNavigatorKey,
          pageBuilder: (context, state) => const NoTransitionPage(
            child: HistoryPage(),
          ),
        ),
      ],
    ),
    GoRoute(
      path: MyRouter.allUsersRoute,
      name: 'all_users',
      pageBuilder: (context, state) => const NoTransitionPage(
        child: AllUsersPage(),
      ),
      routes: [
        GoRoute(
          path: MyRouter.detailUserRoute,
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
      path: MyRouter.initialRoute,
      name: 'login page',
      pageBuilder: (context, state) => const NoTransitionPage(
        child: LoginPage(),
      ),
    ),
    GoRoute(
      path: MyRouter.registerRoute,
      name: 'register page',
      pageBuilder: (context, state) => const NoTransitionPage(
        child: SignUpTestPage(),
      ),
    ),
    GoRoute(
      path: MyRouter.addDeviceRoute,
      pageBuilder: (context, state) => const NoTransitionPage(
        child: AddDevicePage(),
      ),
    ),
    GoRoute(
      path: MyRouter.settingsRoute,
      name: 'settings page',
      pageBuilder: (context, state) => const NoTransitionPage(
        child: SettingPage(),
      ),
      routes: [
        GoRoute(
          path: MyRouter.aboutRoute,
          name: 'about page',
          pageBuilder: (context, state) => const NoTransitionPage(
            child: AboutPage(),
          ),
        ),
      ],
    ),
  ],
);

class MyRouter {
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
