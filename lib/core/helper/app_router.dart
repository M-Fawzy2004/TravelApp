import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:travel_app/feature/home/presentation/view/home_view.dart';
import 'package:travel_app/feature/login/presentation/view/login_view.dart';
import 'package:travel_app/feature/login/presentation/view/otp_verification_view.dart';
import 'package:travel_app/feature/onboarding/onboarding_view.dart';
import 'package:travel_app/feature/user_profile/view/user_profile.dart';

abstract class AppRouter {
  static const loginView = '/loginView';
  static const otpVerf = '/otpVerf';
  static const homeView = '/homeView';
  static const userProfile = '/userProfile';
  static var router = GoRouter(
    routes: [
      GoRoute(
        path: '/',
        builder: (BuildContext context, GoRouterState state) {
          return const OnboardingView();
        },
      ),
      GoRoute(
        path: loginView,
        builder: (BuildContext context, GoRouterState state) {
          return const LoginView();
        },
      ),
      GoRoute(
        path: otpVerf,
        builder: (BuildContext context, GoRouterState state) {
          return const OtpVerificationView();
        },
      ),
      GoRoute(
        path: homeView,
        builder: (BuildContext context, GoRouterState state) {
          return const HomeView();
        },
      ),
      GoRoute(
        path: userProfile,
        builder: (BuildContext context, GoRouterState state) {
          return const UserProfile();
        },
      ),
    ],
  );
}
