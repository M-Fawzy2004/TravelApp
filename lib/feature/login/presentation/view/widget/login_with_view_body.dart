import 'package:flutter/material.dart';
import 'package:travel_app/core/theme/styles.dart';
import 'package:travel_app/core/widget/custom_text_form_field.dart';
import 'package:travel_app/core/widget/custom_button.dart';
import 'package:travel_app/core/helper/spacing.dart';
import 'package:travel_app/core/widget/icon_back.dart';

class LoginWithEmailViewBody extends StatefulWidget {
  const LoginWithEmailViewBody({super.key});

  @override
  State<LoginWithEmailViewBody> createState() => _LoginWithEmailViewBodyState();
}

class _LoginWithEmailViewBodyState extends State<LoginWithEmailViewBody> {
  @override
  Widget build(BuildContext context) {
    final emailController = TextEditingController();
    final formKey = GlobalKey<FormState>();
    AutovalidateMode autovalidateMode = AutovalidateMode.disabled;

    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: formKey,
          autovalidateMode: autovalidateMode,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              heightBox(40),
              IconBack(),
              heightBox(15),
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
                buttonText: 'التحقق من البريد',
                onPressed: () {},
                textStyle: Styles.font16WhiteBold,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
