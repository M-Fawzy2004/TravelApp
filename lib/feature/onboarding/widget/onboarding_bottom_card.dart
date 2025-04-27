// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:travel_app/core/helper/app_router.dart';
import 'package:travel_app/core/helper/spacing.dart';
import 'package:travel_app/core/theme/app_color.dart';
import 'package:travel_app/core/theme/styles.dart';
import 'package:travel_app/core/widget/custom_button.dart';
import 'package:travel_app/feature/onboarding/widget/onboarding_description_section.dart';

class OnBoardingBottomCard extends StatelessWidget {
  const OnBoardingBottomCard({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.bottomCenter,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 16),
        child: Container(
          height: 270.h,
          width: double.infinity,
          decoration: BoxDecoration(
            color: AppColors.grey,
            boxShadow: [
              BoxShadow(
                // ignore: deprecated_member_use
                color: AppColors.black.withOpacity(0.25),
                blurRadius: 4,
                offset: const Offset(0, 7),
              ),
            ],
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
                const OnboardingDescriptionSection(),
                const Spacer(),
                CustomButton(
                  onPressed: () async {
                    final prefs = await SharedPreferences.getInstance();
                    await prefs.setBool('isFirstTime', false);
                    context.push(AppRouter.loginView);
                  },
                  buttonText: 'ابدء رحلتك الان',
                ),
                heightBox(25),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
