import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:travel_app/core/helper/spacing.dart';
import 'package:travel_app/core/theme/styles.dart';
import 'package:travel_app/generated/locale_keys.g.dart';

class OnboardingDescriptionSection extends StatelessWidget {
  const OnboardingDescriptionSection({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0),
      child: Column(
        children: [
          Text(
            textAlign: TextAlign.center,
            LocaleKeys.OnboardingView_details.tr(),
            style: Styles.body14PrimarySemiBold(context),
          ),
          heightBox(10),
          Text(
            textAlign: TextAlign.center,
            LocaleKeys.OnboardingView_details2.tr(),
            style: Styles.body14PrimarySemiBold(context),
          ),
        ],
      ),
    );
  }
}
