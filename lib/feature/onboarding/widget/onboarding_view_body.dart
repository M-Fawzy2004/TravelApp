import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:travel_app/core/helper/app_router.dart';
import 'package:travel_app/core/helper/spacing.dart';
import 'package:travel_app/core/theme/app_color.dart';
import 'package:travel_app/core/theme/styles.dart';
import 'package:travel_app/core/utils/assets.dart';
import 'package:travel_app/core/widget/custom_button.dart';
import 'package:travel_app/feature/onboarding/widget/onboarding_description_section.dart';

class OnboardingViewBody extends StatelessWidget {
  const OnboardingViewBody({super.key});

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Positioned.fill(
          child: Image.asset(
            fit: BoxFit.cover,
            Assets.imagesOnboardingCarsOnRoad,
          ),
        ),
        Align(
          alignment: Alignment.bottomCenter,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 16),
            child: Container(
              height: 270.h,
              width: double.infinity,
              decoration: BoxDecoration(
                color: AppColors.grey,
                borderRadius: BorderRadius.circular(15.r),
              ),
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16.0),
                child: Column(
                  children: [
                    heightBox(20),
                    Text(
                      'أهلا بك فى تطبيق رحلة',
                      style: Styles.font20ExtraBlackBold,
                    ),
                    heightBox(20),
                    OnboardingDescriptionSection(),
                    Spacer(),
                    CustomButton(
                      onPressed: () {
                        context.push(AppRouter.loginView);
                      },
                      buttonText: 'ابدء رحلتك الان',
                      textStyle: Styles.font16WhiteBold,
                    ),
                    heightBox(25),
                  ],
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
