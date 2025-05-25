// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:travel_app/core/helper/extension.dart';
import 'package:travel_app/core/helper/spacing.dart';
import 'package:travel_app/core/theme/app_color.dart';
import 'package:travel_app/core/theme/styles.dart';
import 'package:travel_app/core/widget/custom_button.dart';
import 'package:travel_app/feature/auth/presentation/view/login_view.dart';
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
            color: AppColors.getSurfaceColor(context),
            boxShadow: [
              BoxShadow(
                // ignore: deprecated_member_use
                color: AppColors.getTextColor(context).withOpacity(0.25),
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
                  'أهلا بك فى تطبيق Rihla',
                  style: Styles.font20ExtraBlackBold(context),
                ),
                heightBox(20),
                const OnboardingDescriptionSection(),
                const Spacer(),
                CustomButton(
                  onPressed: () async {
                    final prefs = await SharedPreferences.getInstance();
                    await prefs.setBool('isFirstTime', false);
                    context.navigateWithSlideTransition(const LoginView());
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
