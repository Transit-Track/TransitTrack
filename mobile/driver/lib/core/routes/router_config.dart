import 'package:driver/core/routes/app_path.dart';
import 'package:driver/features/authentication/presentation/pages/login_page.dart';
import 'package:driver/features/bus_tracking/presentation/pages/tracking_page.dart';
import 'package:flutter/cupertino.dart';
import 'package:go_router/go_router.dart';

class AppRoute {
  static final GoRouter router =
      GoRouter(initialLocation: AppPath.login, routes: [
    GoRoute(
      path: AppPath.login,
      name: AppPath.login,
      builder: (BuildContext context, GoRouterState state) => const LoginPage(),
    ),
    GoRoute(
      path: AppPath.trackingPage,
      name: AppPath.trackingPage,
      builder: (BuildContext context, GoRouterState state) =>
          const TrackingPage(),
    ),
  ]);
}
