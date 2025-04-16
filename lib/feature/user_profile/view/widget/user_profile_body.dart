import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:travel_app/core/helper/app_router.dart';
import 'package:travel_app/core/helper/spacing.dart';
import 'package:travel_app/core/theme/styles.dart';
import 'package:travel_app/core/widget/custom_button.dart';
import 'package:travel_app/core/widget/custom_text_form_field.dart';
import 'package:travel_app/core/widget/icon_back.dart';
import 'package:travel_app/feature/login/presentation/view/widget/phone_number_input_section.dart';
import 'package:travel_app/feature/user_profile/view/widget/role_dropdown_text_field.dart';

class UserProfileBody extends StatefulWidget {
  const UserProfileBody({super.key});

  @override
  State<UserProfileBody> createState() => _UserProfileBodyState();
}

class _UserProfileBodyState extends State<UserProfileBody> {
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
    return SingleChildScrollView(
      physics: BouncingScrollPhysics(),
      child: Column(
        children: [
          Align(
            alignment: Alignment.topRight,
            child: IconBack(),
          ),
          heightBox(20),
          Row(
            children: [
              Expanded(
                child: CustomTextFormField(
                  hintText: 'الإسم الاول',
                ),
              ),
              widthBox(10),
              Expanded(
                child: CustomTextFormField(
                  hintText: 'الاسم الثاني',
                ),
              ),
            ],
          ),
          heightBox(20),
          Align(
            alignment: Alignment.centerRight,
            child: Text(
              'المدينة',
              style: Styles.font16BlackBold,
            ),
          ),
          heightBox(10),
          CustomTextFormField(
            hintText: 'مثال : الغربيه / المحله الكبري',
          ),
          heightBox(20),
          PhoneNumberInputSection(
            onPhoneChanged: _onPhoneChanged,
          ),
          heightBox(20),
          RoleDropdownTextField(),
          heightBox(20),
          CustomButton(
            buttonText: 'استمرار',
            textStyle: Styles.font16WhiteBold,
            onPressed: _continueToVerification,
          ),
        ],
      ),
    );
  }
}
