import 'package:action_slider/action_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:travel_app/core/theme/app_color.dart';
import 'package:travel_app/core/theme/styles.dart';

class ActionSliderButton extends StatelessWidget {
  const ActionSliderButton({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return ActionSlider.standard(
      backgroundColor: AppColors.primaryColor,
      backgroundBorderRadius: BorderRadius.circular(20.r),
      height: 55.h,
      toggleColor: AppColors.grey,
      child: Text(
        'تاكيد الحجز',
        style: Styles.font16BlackBold,
      ),
      // action: (controller) async {
      //   controller.loading();
      //   await Future.delayed(const Duration(seconds: 2));
      //   controller.success();
      // },
    );
  }
}
