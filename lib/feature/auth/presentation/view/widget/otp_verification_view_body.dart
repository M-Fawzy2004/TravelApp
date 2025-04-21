import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:pin_code_text_field/pin_code_text_field.dart';
import 'package:travel_app/core/helper/spacing.dart';
import 'package:travel_app/core/theme/app_color.dart';
import 'package:travel_app/core/theme/styles.dart';
import 'package:travel_app/core/widget/custom_button.dart';
import 'package:travel_app/core/widget/icon_back.dart';
import 'package:travel_app/feature/auth/presentation/manager/cubit/auth_cubit.dart';

class OtpVerificationViewBody extends StatefulWidget {
  const OtpVerificationViewBody({
    super.key,
    required this.verificationId,
    this.isLoading = false,
  });

  final String verificationId;
  final bool isLoading;

  @override
  State<OtpVerificationViewBody> createState() =>
      _OtpVerificationViewBodyState();
}

class _OtpVerificationViewBodyState extends State<OtpVerificationViewBody> {
  final TextEditingController _otpController = TextEditingController();

  @override
  void dispose() {
    _otpController.dispose();
    super.dispose();
  }

  void _verifyOTP() {
    if (_otpController.text.length == 6) {
      context
          .read<AuthCubit>()
          .verifyOTP(widget.verificationId, _otpController.text);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            heightBox(40),
            Align(
              alignment: Alignment.topRight,
              child: IconBack(),
            ),
            heightBox(15),
            Text(
              "أدخل رمز التحقق الذي تم إرساله إليك ",
              style: Styles.font14DarkGreyExtraBold,
              textAlign: TextAlign.center,
            ),
            heightBox(30),
            PinCodeTextField(
              defaultBorderColor: AppColors.grey,
              pinBoxRadius: 10.r,
              controller: _otpController,
              maxLength: 6,
              maskCharacter: "*",
              pinBoxWidth: 40.w,
              pinBoxHeight: 50.h,
              wrapAlignment: WrapAlignment.spaceAround,
              pinBoxDecoration:
                  ProvidedPinBoxDecoration.defaultPinBoxDecoration,
              pinTextStyle: TextStyle(fontSize: 22.sp),
              pinTextAnimatedSwitcherTransition:
                  ProvidedPinBoxTextAnimation.scalingTransition,
              pinTextAnimatedSwitcherDuration: Duration(milliseconds: 300),
              highlightAnimationBeginColor: Colors.black,
              keyboardType: TextInputType.number,
            ),
            heightBox(30),
            CustomButton(
              buttonText: widget.isLoading ? "جاري التحقق" : "تحقق",
              onPressed: widget.isLoading ? null : _verifyOTP,
              textStyle: Styles.font16WhiteBold,
            ),
          ],
        ),
      ),
    );
  }
}
