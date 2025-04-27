import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:travel_app/core/theme/app_color.dart';
import 'package:travel_app/core/theme/styles.dart';

InputDecoration customInputDecoration({String? labelText}) {
  return InputDecoration(
    labelText: labelText,
    labelStyle: Styles.font16BlackBold,
    border: OutlineInputBorder(
      borderRadius: BorderRadius.circular(10.r),
      borderSide: const BorderSide(
        color: AppColors.grey,
      ),
    ),
    filled: true,
    fillColor: AppColors.grey,
    focusedBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(10.r),
      borderSide: BorderSide(
        color: AppColors.primaryColor,
        width: 2.w,
      ),
    ),
    enabledBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(10.r),
      borderSide: BorderSide(
        color: AppColors.grey,
        width: 2.w,
      ),
    ),
    contentPadding: EdgeInsets.symmetric(
      vertical: 15.h,
      horizontal: 16.w,
    ),
  );
}
