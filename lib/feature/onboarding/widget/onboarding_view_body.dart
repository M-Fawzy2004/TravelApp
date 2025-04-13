import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:travel_app/core/helper/spacing.dart';
import 'package:travel_app/core/theme/styles.dart';
import 'package:travel_app/core/utils/assets.dart';
import 'package:travel_app/core/widget/custom_button.dart';
import 'package:travel_app/feature/onboarding/widget/onboarding_description_section.dart';
import 'package:travel_app/generated/locale_keys.g.dart';

class OnboardingViewBody extends StatelessWidget {
  const OnboardingViewBody({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Image.asset(
          Assets.imagesOnboardingImage,
        ),
        heightBox(40),
        Text(
          LocaleKeys.OnboardingView_welcome.tr(),
          style: Styles.font20ExtraBlackBold,
        ),
        heightBox(20),
        OnboardingDescriptionSection(),
        Spacer(),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          child: CustomButton(
            buttonText: LocaleKeys.OnboardingView_start.tr(),
            textStyle: Styles.font16BlackBold,
            onPressed: () {},
          ),
        ),
        heightBox(40),
      ],
    );
  }
}
