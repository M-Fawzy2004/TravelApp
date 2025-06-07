import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:travel_app/core/theme/app_color.dart';
import 'package:travel_app/core/theme/styles.dart';

class SearchPoistionBusField extends StatelessWidget {
  const SearchPoistionBusField({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 10.h),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10.r),
        border: Border.all(
          color: AppColors.getLightGreyColor(context).withOpacity(0.2),
        ),
      ),
      child: TextField(
        style: Styles.font16BlackBold(context),
        decoration: InputDecoration(
          contentPadding: EdgeInsets.symmetric(
            vertical: 15.h,
            horizontal: 16.w,
          ),
          fillColor: AppColors.getSurfaceColor(context),
          filled: true,
          hintText: 'ابحث عن موقف',
          hintStyle: Styles.font14DarkGreyExtraBold(context).copyWith(
            fontWeight: FontWeight.w900,
          ),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10.r),
            borderSide: BorderSide.none,
          ),
        ),
      ),
    );
  }
}
