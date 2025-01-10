import 'package:flutter/cupertino.dart';
import 'package:go_router/go_router.dart';
import 'package:grow_in_app/features/device/presentation/pages/add_device_page.dart';
import 'package:grow_in_app/features/device/presentation/pages/dashboard_page.dart';

import '../features/profile/presentation/pages/detail_user_page.dart';

final _rootNavigatorKey = GlobalKey<NavigatorState>(
  debugLabel: 'Root Navigator',
);
final _shellNavigatorKey = GlobalKey<NavigatorState>(
  debugLabel: 'Shell Navigator',
);

final router = GoRouter(
  navigatorKey: _rootNavigatorKey,
  initialLocation: MyRouter.homeRoute,
  debugLogDiagnostics: true,
  routes: <RouteBase>[
    ShellRoute(
      navigatorKey: _shellNavigatorKey,
      builder: (context, state, child) => BottomNavigationState(child: child),
      routes: [
        GoRoute(
          path: MyRouter.homeRoute,
          parentNavigatorKey: _shellNavigatorKey,
          pageBuilder: (context, state) => const NoTransitionPage(
            child: HomePage(),
          ),
        ),
        GoRoute(
          path: MyRouter.historyRoute,
          parentNavigatorKey: _shellNavigatorKey,
          pageBuilder: (context, state) => const NoTransitionPage(
            child: HistoryPage(),
          ),
          routes: [
            GoRoute(
              path: MyRouter.historyDetailRoute,
              parentNavigatorKey: _rootNavigatorKey,
              pageBuilder: (context, state) => NoTransitionPage(
                child: DetailHistoryPage(
                  date: state.extra as DateTime,
                ),
              ),
            ),
          ],
        ),
      ],
    ),
    GoRoute(
      path: MyRouter.addDeviceRoute,
      parentNavigatorKey: _shellNavigatorKey,
      pageBuilder: (context, state) => const NoTransitionPage(
        child: AddDevicePage(),
      ),
    ),
    GoRoute(
      path: MyRouter.settingsRoute,
      parentNavigatorKey: _shellNavigatorKey,
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
  static const String homeRoute = '/';
  static const String addDeviceRoute = '/add-device';

  static const String allUsersRoute = '/all_users';
  static const String detailUserRoute = 'detail-user';

  static const String articleRoute = '/article';
  static const String detailArticleRoute = 'detail-article';

  static const String historyRoute = '/history';
  static const String historyDetailRoute = 'detail-history';

  static const String aboutRoute = '/about';

  static const String settingsRoute = '/settings';

  get router => GoRouter(
        initialLocation: "/",
        routes: [
          GoRoute(
            path: "/",
            name: "all_users",
            pageBuilder: (context, state) => const NoTransitionPage(
              child: DashboardPage(),
            ),
            routes: [
              GoRoute(
                path: detailUserRoute,
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
            path: historyRoute,
            name: 'history',
            pageBuilder: (context, state) => NoTransitionPage(
              child: HistoryPage(),
            ),
            routes: [
              GoRoute(
                path: historyDetailRoute,
                name: "detail-history",
                pageBuilder: (context, state) => NoTransitionPage(
                  child: DetailHistoryPage(
                    date: state.extra as DateTime,
                  ),
                ),
              ),
            ],
          ),
          GoRoute(
            path: aboutRoute,
            name: 'about',
            pageBuilder: (context, state) => NoTransitionPage(
              child: AboutPage(),
            ),
          ),
        ],
      );
}
