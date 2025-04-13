import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:travel_app/core/helper/app_router.dart';
import 'package:travel_app/core/helper/spacing.dart';
import 'package:travel_app/core/theme/styles.dart';
import 'package:travel_app/core/utils/assets.dart';
import 'package:travel_app/core/widget/custom_button.dart';
import 'package:travel_app/feature/login/presentation/view/widget/or_login.dart';
import 'package:travel_app/feature/login/presentation/view/widget/phone_number_field.dart';
import 'package:travel_app/feature/login/presentation/view/widget/social_login.dart';

class LoginViewBody extends StatefulWidget {
  const LoginViewBody({super.key});

  @override
  State<LoginViewBody> createState() => _LoginViewBodyState();
}

class _LoginViewBodyState extends State<LoginViewBody> {
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      physics: const BouncingScrollPhysics(),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            heightBox(80),
            Align(
              alignment: Alignment.centerRight,
              child: Text(
                'اهلا بك فى تطبيق رحلة ',
                style: Styles.font20ExtraBlackBold,
              ),
            ),
            heightBox(28),
            Text(
              'انضم الان وابدأ مشاركتنا رحلاتك أو انطلق فى رحله جديده \nمع الاخرين فى مدينتك سجل دخولك الان لتجربه تنقل افضل',
              style: Styles.font14DarkGreyExtraBold,
            ),
            heightBox(60),
            Text(
              'من فضلك ادخل رقم هاتفك',
              style: Styles.font20ExtraBlackBold,
            ),
            Column(
              children: [
                heightBox(28),
                PhoneNumberField(),
                heightBox(15),
                CustomButton(
                  buttonText: 'الاستمرار',
                  textStyle: Styles.font16WhiteBold,
                  onPressed: () {},
                ),
                heightBox(10),
                OrLogin(),
                heightBox(10),
                SocialLogin(
                  onTap: () {},
                  image: Assets.imagesAppleLogo,
                  text: 'الدخول بواسطه ابل',
                ),
                heightBox(10),
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
            ),
          ],
        ),
      ),
    );
  }
}
