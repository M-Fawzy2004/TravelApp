// ignore_for_file: deprecated_member_use

import 'package:flutter/material.dart';
import 'package:travel_app/core/utils/assets.dart';
import 'package:travel_app/feature/onboarding/widget/onboarding_bottom_card.dart';

class OnboardingViewBody extends StatelessWidget {
  const OnboardingViewBody({super.key});

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Positioned.fill(
          child: Image.asset(
            fit: BoxFit.cover,
            Assets.imagesOnboardingImage,
          ),
        ),
        OnBoardingBottomCard(),
      ],
    );
  }
}
