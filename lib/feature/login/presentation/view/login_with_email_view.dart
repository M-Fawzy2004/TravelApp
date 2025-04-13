import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:travel_app/core/helper/app_router.dart';
import 'package:travel_app/core/theme/styles.dart';
import 'package:travel_app/core/widget/custom_text_form_field.dart';
import 'package:travel_app/core/widget/custom_button.dart';
import 'package:travel_app/core/helper/spacing.dart';

class LoginWithEmailView extends StatefulWidget {
  const LoginWithEmailView({super.key});

  @override
  State<LoginWithEmailView> createState() => _LoginWithEmailViewState();
}

class _LoginWithEmailViewState extends State<LoginWithEmailView> {
  @override
  Widget build(BuildContext context) {
    final emailController = TextEditingController();

    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            heightBox(40),
            Text("أدخل بريدك الإلكتروني", style: Styles.font20ExtraBlackBold),
            heightBox(20),
            CustomTextFormField(
              textAlign: TextAlign.left,
              controller: emailController,
              hintText: 'example@email.com',
              keyboardType: TextInputType.emailAddress,
            ),
            heightBox(30),
            CustomButton(
              buttonText: 'إرسال الرمز',
              onPressed: () {
                context.push(AppRouter.otpVerf);
              },
              textStyle: Styles.font16WhiteBold,
            ),
          ],
        ),
      ),
    );
  }
}
