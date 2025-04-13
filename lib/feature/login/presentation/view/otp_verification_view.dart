import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:pin_code_text_field/pin_code_text_field.dart';
import 'package:travel_app/core/helper/spacing.dart';
import 'package:travel_app/core/theme/styles.dart';
import 'package:travel_app/core/widget/custom_button.dart';

class OtpVerificationView extends StatelessWidget {
  const OtpVerificationView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            heightBox(40),
            Text(
              "أدخل رمز التحقق المكون من 6 أرقام الذي تم إرساله إلى بريدك",
              style: Styles.font14DarkGreyExtraBold,
              textAlign: TextAlign.center,
            ),
            heightBox(30),
            PinCodeTextField(
              // controller: controller,

              maxLength: 5,
              maskCharacter: "*",
              // onTextChanged: (text) {
              //   setState(() {
              //     hasError = false;
              //   });
              // },
              // onDone: (text) {
              //   print("DONE $text");
              //   print("DONE CONTROLLER ${controller.text}");
              // },
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
