import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:transittrack/core/routes/route_path.dart';
import 'package:transittrack/features/authentication/presentation/pages/change_password_page.dart';
import 'package:transittrack/features/authentication/presentation/pages/login_page.dart';
import 'package:transittrack/features/authentication/presentation/pages/forget_password_page.dart';
import 'package:transittrack/features/authentication/presentation/pages/otp_verification_page.dart';
import 'package:transittrack/features/authentication/presentation/pages/signup_page.dart';
import 'package:transittrack/features/favorite/presentation/pages/favorite_page.dart';
import 'package:transittrack/features/home/presentation/pages/home_page.dart';
import 'package:transittrack/features/home/presentation/pages/real_time_vehicle_tracking_page.dart';
import 'package:transittrack/features/notification/presentation/pages/notification_page.dart';
import 'package:transittrack/features/onboarding/presentation/pages/onboarding_page.dart';
import 'package:transittrack/features/profile/presentation/pages/profile_page.dart';
import 'package:transittrack/features/tickets/presentation/pages/ticket_page.dart';

class AppRouter {
  static final GoRouter router =
      GoRouter(initialLocation: AppPath.home, routes: <GoRoute>[
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
        path: AppPath.home,
        name: AppPath.home,
        builder: (BuildContext context, GoRouterState state) {
          return const HomePage();
        }),
         GoRoute(
        path: AppPath.otpVerification,
        name: AppPath.otpVerification,
        builder: (BuildContext context, GoRouterState state) {
          return const OtpVerificationPage();
        }),
         GoRoute(
        path: AppPath.forgetPassword,
        name: AppPath.forgetPassword,
        builder: (BuildContext context, GoRouterState state) {
          return const ForgetPasswordPage();
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
        path: AppPath.profile,
        name: AppPath.profile,
        builder: (BuildContext context, GoRouterState state) {
          return const ProfilePage();
        }),
         GoRoute(
        path: AppPath.ticket,
        name: AppPath.ticket,
        builder: (BuildContext context, GoRouterState state) {
          return const TicketPage();
        }),
         GoRoute(
        path: AppPath.favorite,
        name: AppPath.favorite,
        builder: (BuildContext context, GoRouterState state) {
          return const FavoritePage();
        }),
         GoRoute(
        path: AppPath.realTimeVehicleTrackingPage,
        name: AppPath.realTimeVehicleTrackingPage,
        builder: (BuildContext context, GoRouterState state) {
          return const RealTimeVehicleTrackingPage();
        })
  ]);
}
