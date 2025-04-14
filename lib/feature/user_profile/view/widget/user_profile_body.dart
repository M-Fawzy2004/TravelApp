import 'package:flutter/material.dart';
import 'package:travel_app/core/helper/spacing.dart';
import 'package:travel_app/core/theme/styles.dart';
import 'package:travel_app/core/widget/custom_button.dart';
import 'package:travel_app/core/widget/custom_text_form_field.dart';
import 'package:travel_app/core/widget/icon_back.dart';
import 'package:travel_app/feature/user_profile/view/widget/role_dropdown_text_field.dart';

class UserProfileBody extends StatelessWidget {
  const UserProfileBody({super.key});

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
          RoleDropdownTextField(),
          heightBox(20),
          CustomButton(
            buttonText: 'حفظ البيانات',
            textStyle: Styles.font16WhiteBold,
            onPressed: () {},
          ),
        ],
      ),
    );
  }
}
