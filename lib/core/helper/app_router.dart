import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:travel_app/feature/login/presentation/view/login_view.dart';
import 'package:travel_app/feature/onboarding/onboarding_view.dart';

abstract class AppRouter {
  static const loginView = '/loginView';
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
    ],
  );
}
