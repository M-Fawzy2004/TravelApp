import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:travel_app/core/helper/spacing.dart';
import 'package:travel_app/core/theme/styles.dart';
import 'package:travel_app/core/utils/assets.dart';
import 'package:travel_app/core/widget/custom_button.dart';
import 'package:travel_app/feature/auth/presentation/manager/cubit/auth_cubit.dart';
import 'package:travel_app/feature/auth/presentation/view/widget/phone_number_input_section.dart';
import 'package:travel_app/feature/auth/presentation/view/widget/social_login.dart';

class LoginForm extends StatefulWidget {
  final bool isLoading;

  const LoginForm({super.key, this.isLoading = false});

  @override
  State<LoginForm> createState() => _LoginFormState();
}

class _LoginFormState extends State<LoginForm> {
  String fullPhoneNumber = '';
  bool isPhoneValid = false;

  void _signInWithPhone() {
    if (isPhoneValid) {
      context.read<AuthCubit>().signInWithPhone(fullPhoneNumber);
    }
  }

  void _signInWithGoogle() {
    context.read<AuthCubit>().signInWithGoogle();
  }

  void _signInWithApple() {
    context.read<AuthCubit>().signInWithApple();
  }

  void _onPhoneChanged(String phone) {
    setState(() {
      fullPhoneNumber = phone;
      isPhoneValid = phone.isNotEmpty;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        heightBox(20),
        PhoneNumberInputSection(onPhoneChanged: _onPhoneChanged),
        heightBox(20),
        CustomButton(
          buttonText: widget.isLoading ? 'جاري التحميل' : 'التالي',
          onPressed:
              widget.isLoading || !isPhoneValid ? null : _signInWithPhone,
        ),
        heightBox(40),
        Row(
          children: [
            const Expanded(child: Divider(color: Colors.grey)),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: Text(
                'أو',
                style: Styles.font14DarkGreyExtraBold(context),
              ),
            ),
            const Expanded(child: Divider(color: Colors.grey)),
          ],
        ),
        heightBox(20),
        SocialLogin(
          image: Assets.imagesGoogleLogo,
          text: 'تسجيل الدخول بحساب Google',
          onTap: widget.isLoading ? null : _signInWithGoogle,
        ),
        heightBox(20),
        if (Platform.isIOS)
          SocialLogin(
            image: Assets.imagesAppleLogo,
            text: 'تسجيل الدخول بحساب Apple',
            onTap: widget.isLoading ? null : _signInWithApple,
          ),
      ],
    );
  }
}
