import 'package:flutter/material.dart';
import 'package:travel_app/core/helper/spacing.dart';
import 'package:travel_app/core/theme/styles.dart';

class OnboardingDescriptionSection extends StatelessWidget {
  const OnboardingDescriptionSection({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(
          textAlign: TextAlign.center,
          'تطبيق يساعدك علي مشاركه رحلاتك مع الاخرين فى منطقتك. سواء كنت سائقا او راكبا.',
          style: Styles.font14DarkGreyExtraBold,
        ),
        heightBox(10),
        Text(
          textAlign: TextAlign.center,
          'اكتشف الرحلات المتاحه وشارك فى التنقل بسهوله وفعاليه',
          style: Styles.font14DarkGreyExtraBold,
        ),
      ],
    );
  }
}
