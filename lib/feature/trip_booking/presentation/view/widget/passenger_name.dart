import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:travel_app/core/helper/spacing.dart';
import 'package:travel_app/core/theme/app_color.dart';

class PassengersName extends StatelessWidget {
  const PassengersName({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Icon(Icons.person, color: AppColors.getPrimaryColor(context), size: 24.sp),
        widthBox(8),
        Text(
          'اسم الراكب: محمد أحمد',
          style: TextStyle(
            fontSize: 16.sp,
            fontWeight: FontWeight.bold,
            color: AppColors.getPrimaryColor(context),
          ),
        ),
      ],
    );
  }
}
