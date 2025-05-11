import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:travel_app/core/theme/app_color.dart';
import 'package:travel_app/core/theme/styles.dart';

class PassengerNameCard extends StatelessWidget {
  const PassengerNameCard({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(
        horizontal: 10.w,
        vertical: 8.h,
      ),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10.r),
        color: AppColors.primaryColor.withOpacity(.1),
      ),
      child: Center(
        child: Text(
          'الراكب : محمد احمد',
          style: Styles.font18BlackBold,
        ),
      ),
    );
  }
}
