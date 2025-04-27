import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:slide_to_act/slide_to_act.dart';
import 'package:travel_app/core/theme/app_color.dart';
import 'package:travel_app/core/theme/styles.dart';

class ActionSliderButton extends StatelessWidget {
  const ActionSliderButton({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return SlideAction(
      sliderButtonIcon: const Icon(
        FontAwesomeIcons.arrowRight,
        color: AppColors.darkGrey,
      ),
      animationDuration: const Duration(milliseconds: 500),
      borderRadius: 20.r,
      outerColor: AppColors.primaryColor,
      innerColor: AppColors.grey,
      sliderRotate: false,
      elevation: 6,
      onSubmit: () {
        return null;
      },
      child: Text(
        'تأكيد الحجز  ',
        style: Styles.font16WhiteBold,
      ),
    );
  }
}
