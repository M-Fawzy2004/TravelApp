import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:travel_app/feature/login/presentation/view/login_view.dart';
import 'package:travel_app/feature/login/presentation/view/login_with_email_view.dart';
import 'package:travel_app/feature/login/presentation/view/otp_verification_view.dart';
import 'package:travel_app/feature/onboarding/onboarding_view.dart';

abstract class AppRouter {
  static const loginView = '/loginView';
  static const loginwithEmail = '/loginwithEmail';
  static const otpVerf = '/otpVerf';
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
        path: loginwithEmail,
        builder: (BuildContext context, GoRouterState state) {
          return const LoginWithEmailView();
        },
      ),
      GoRoute(
        path: otpVerf,
        builder: (BuildContext context, GoRouterState state) {
          return const OtpVerificationView();
        },
      ),
    ],
  );
}
