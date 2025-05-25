import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:travel_app/core/theme/app_color.dart';
import 'package:travel_app/core/theme/styles.dart';

InputDecoration customInputDecoration({required BuildContext context,String? labelText}) {
  return InputDecoration(
    labelText: labelText,
    labelStyle: Styles.font16BlackBold(context),
    border: OutlineInputBorder(
      borderRadius: BorderRadius.circular(10.r),
      borderSide:  BorderSide(
        color: AppColors.getBackgroundColor(context),
      ),
    ),
    filled: true,
    fillColor: AppColors.getBackgroundColor(context),
    focusedBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(10.r),
      borderSide: BorderSide(
        color: AppColors.getPrimaryColor(context),
        width: 2.w,
      ),
    ),
    enabledBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(10.r),
      borderSide: BorderSide(
        color: AppColors.getBackgroundColor(context),
        width: 2.w,
      ),
    ),
    contentPadding: EdgeInsets.symmetric(
      vertical: 15.h,
      horizontal: 16.w,
    ),
  );
}
