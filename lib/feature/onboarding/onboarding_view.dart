import 'package:flutter/material.dart';
import 'package:travel_app/feature/onboarding/widget/onboarding_view_body.dart';

class OnboardingView extends StatelessWidget {
  const OnboardingView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: const OnboardingViewBody(),
    );
  }
}
