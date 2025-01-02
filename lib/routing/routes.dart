import 'package:go_router/go_router.dart';
import 'package:grow_in_app/features/device/presentation/pages/dashboard_page.dart';

import '../features/profile/presentation/pages/detail_user_page.dart';

class MyRouter {
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
                path: "detail-user",
                name: "detail_user",
                pageBuilder: (context, state) => NoTransitionPage(
                  child: DetailUserPage(
                    state.extra as int,
                  ),
                ),
              ),
            ],
          ),
        ],
      );
}
