import 'dart:io';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:travel_app/core/helper/app_router.dart';
import 'package:travel_app/core/helper/spacing.dart';
import 'package:travel_app/core/theme/styles.dart';
import 'package:travel_app/core/utils/assets.dart';
import 'package:travel_app/core/widget/custom_button.dart';
import 'package:travel_app/feature/login/presentation/view/widget/or_login.dart';
import 'package:travel_app/feature/login/presentation/view/widget/phone_number_input_section.dart';
import 'package:travel_app/feature/login/presentation/view/widget/social_login.dart';

class LoginForm extends StatefulWidget {
  const LoginForm({super.key});

  @override
  State<LoginForm> createState() => _LoginFormState();
}

class _LoginFormState extends State<LoginForm> {
  String fullPhoneNumber = '';
  bool isPhoneValid = false;

  void _onPhoneChanged(String phone) {
    setState(() {
      fullPhoneNumber = phone;
      isPhoneValid = phone.isNotEmpty;
    });
  }

  void _continueToVerification() {
    if (isPhoneValid) {
      context.push(AppRouter.otpVerf, extra: fullPhoneNumber);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        heightBox(28),
        PhoneNumberInputSection(
          onPhoneChanged: _onPhoneChanged,
        ),
        heightBox(15),
        CustomButton(
          onPressed: _continueToVerification,
          buttonText: 'الاستمرار',
          textStyle: Styles.font16WhiteBold,
          isEnabled: isPhoneValid,
        ),
        heightBox(10),
        const OrLogin(),
        heightBox(10),
        if (Platform.isIOS) ...[
          SocialLogin(
            onTap: () {},
            image: Assets.imagesAppleLogo,
            text: 'الدخول بواسطه ابل',
          ),
          heightBox(10),
        ],
        SocialLogin(
          onTap: () {},
          image: Assets.imagesGoogleLogo,
          text: 'الدخول بواسطه جوجل',
        ),
        heightBox(10),
        SocialLogin(
          onTap: () {
            context.push(AppRouter.loginwithEmail);
          },
          image: Assets.imagesMailLogo,
          text: 'الدخول بواسطه البريد الالكتروني',
        ),
      ],
    );
  }
}
