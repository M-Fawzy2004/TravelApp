import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:pin_code_text_field/pin_code_text_field.dart';
import 'package:travel_app/core/helper/spacing.dart';
import 'package:travel_app/core/theme/styles.dart';
import 'package:travel_app/core/widget/custom_button.dart';
import 'package:travel_app/core/widget/icon_back.dart';

class OtpVerificationViewBody extends StatelessWidget {
  const OtpVerificationViewBody({super.key});

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
              "أدخل رمز التحقق المكون من 6 أرقام الذي تم إرساله إليك ",
              style: Styles.font14DarkGreyExtraBold,
              textAlign: TextAlign.center,
            ),
            heightBox(30),
            PinCodeTextField(
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
              highlightAnimationEndColor: Colors.white12,
              keyboardType: TextInputType.number,
            ),
            heightBox(30),
            CustomButton(
              buttonText: "تحقق",
              onPressed: () {
                // تحقق من الكود هنا
              },
              textStyle: Styles.font16WhiteBold,
            ),
          ],
        ),
      ),
    );
  }
}
