import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:transittrack/core/routes/route_path.dart';
import 'package:transittrack/core/widgets/scaffold_with_nav_bar_widget.dart';
import 'package:transittrack/features/authentication/presentation/pages/change_password_page.dart';
import 'package:transittrack/features/authentication/presentation/pages/login_page.dart';
import 'package:transittrack/features/authentication/presentation/pages/signup_page.dart';
import 'package:transittrack/features/home/domain/entities/bus.dart';
import 'package:transittrack/features/my_route/presentation/pages/my_route.dart';
import 'package:transittrack/features/home/presentation/pages/home_page.dart';
import 'package:transittrack/features/home/presentation/pages/real_time_vehicle_tracking_page.dart';
import 'package:transittrack/features/notification/presentation/pages/notification_page.dart';
import 'package:transittrack/features/onboarding/presentation/pages/onboarding_page.dart';
import 'package:transittrack/features/profile/presentation/pages/profile_page.dart';
import 'package:transittrack/features/tickets/presentation/pages/payment_page.dart';
import 'package:transittrack/features/tickets/presentation/pages/ticket_page.dart';

class AppRouter {
  static final GoRouter router =
      GoRouter(initialLocation: AppPath.login, routes: <RouteBase>[
    StatefulShellRoute.indexedStack(
      builder: (BuildContext context, GoRouterState state,
              StatefulNavigationShell navigationShell) =>
          ScaffoldWithNavBar(navigationShell: navigationShell),
      branches: [
        StatefulShellBranch(
          routes: <RouteBase>[
            GoRoute(
                path: AppPath.home,
                name: AppPath.home,
                builder: (BuildContext context, GoRouterState state) {
                  return const HomePage();
                }),
          ],
        ),
        StatefulShellBranch(
          routes: <RouteBase>[
            GoRoute(
                path: AppPath.my_route,
                name: AppPath.my_route,
                builder: (BuildContext context, GoRouterState state) {
                  return const MyRoute();
                }),
          ],
        ),
        StatefulShellBranch(
          routes: <RouteBase>[
            GoRoute(
                path: AppPath.ticket,
                name: AppPath.ticket,
                builder: (BuildContext context, GoRouterState state) {
                  return const TicketPage();
                }),
          ],
        ),
        StatefulShellBranch(
          routes: <RouteBase>[
            GoRoute(
                path: AppPath.profile,
                name: AppPath.profile,
                builder: (BuildContext context, GoRouterState state) {
                  return const ProfilePage();
                }),
          ],
        ),
      ],
    ),
    GoRoute(
        path: AppPath.onboarding,
        name: AppPath.onboarding,
        builder: (BuildContext context, GoRouterState state) {
          return const OnboardingPage();
        }),
    GoRoute(
        path: AppPath.login,
        name: AppPath.login,
        builder: (BuildContext context, GoRouterState state) {
          return const LoginPage();
        }),
    GoRoute(
        path: AppPath.signup,
        name: AppPath.signup,
        builder: (BuildContext context, GoRouterState state) {
          return const SignupPage();
        }),
    GoRoute(
        path: AppPath.changePassword,
        name: AppPath.changePassword,
        builder: (BuildContext context, GoRouterState state) {
          return const ChangePasswordPage();
        }),
    GoRoute(
        path: AppPath.notification,
        name: AppPath.notification,
        builder: (BuildContext context, GoRouterState state) {
          return const NotificationPage();
        }),
    GoRoute(
        path: AppPath.realTimeVehicleTracking,
        name: AppPath.realTimeVehicleTracking,
        builder: (BuildContext context, GoRouterState state) {
          final Map<String, dynamic> extra =
              state.extra as Map<String, dynamic>;
          final BusEntity bus = extra['bus'] as BusEntity;
          return RealTimeVehicleTrackingPage(bus: bus);
        }),
    GoRoute(
        path: AppPath.payment,
        name: AppPath.payment,
        builder: (BuildContext context, GoRouterState state) {
          final Map<String, dynamic> extra =
              state.extra as Map<String, dynamic>;
          final BusEntity bus = extra['bus'] as BusEntity;
          return PaymentPage(bus: bus);
          // return TicketPage();
        }),
  ]);
}
