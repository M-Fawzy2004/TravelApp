import 'package:flutter/material.dart';
import 'package:travel_app/core/helper/spacing.dart';
import 'package:travel_app/core/theme/styles.dart';
import 'package:travel_app/feature/auth/presentation/view/widget/login_form_bloc_listener.dart';

class LoginViewBody extends StatelessWidget {
  const LoginViewBody({super.key});

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
            const LoginFormBlocListener(),
            heightBox(10),
            Text(
              textAlign: TextAlign.center,
              'من خلال المتابعة، فإنك توافق على تلقي المكالمات أو رسائل WhatsApp أو الرسائل النصية القصيرة/RCS، بما في ذلك الوسائل الآلية، من Rihlaa والشركات التابعة لها إلى الرقم المقدم.',
              style: Styles.font12GreyExtraBold,
            )
          ],
        ),
      ),
    );
  }
}
