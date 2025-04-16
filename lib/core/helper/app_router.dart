import 'package:firebase_auth/firebase_auth.dart';
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
    initialLocation: '/',
    redirect: (context, state) {
      final user = FirebaseAuth.instance.currentUser;
      final isLoggedIn = user != null;
      final isAtRoot = state.matchedLocation == '/';
      final isAtLogin = state.matchedLocation == loginView;
      final isAtOtp = state.matchedLocation == otpVerf;

      if (isLoggedIn && (isAtRoot || isAtLogin || isAtOtp)) {
        return homeView;
      }

      if (!isLoggedIn && !isAtLogin && !isAtOtp) {
        return loginView;
      }

      return null;
    },
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
        builder: (context, state) {
          final verificationId = state.extra as String;
          return OtpVerificationView(verificationId: verificationId);
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
