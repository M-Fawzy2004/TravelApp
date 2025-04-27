import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:travel_app/core/theme/app_color.dart';
import 'package:travel_app/core/theme/font_weight_helper.dart';

class Styles {
  static TextStyle font30ExtraBlackBold = TextStyle(
    fontSize: 30.sp,
    fontWeight: FontWeightHelper.extraBold,
    color: AppColors.black,
  );
  static TextStyle font20ExtraBlackBold = TextStyle(
    fontSize: 20.sp,
    fontWeight: FontWeightHelper.extraBold,
    color: AppColors.black,
  );
  static TextStyle font20BlackBold = TextStyle(
    fontSize: 20.sp,
    fontWeight: FontWeightHelper.bold,
    color: AppColors.black,
  );
  static TextStyle font18BlackBold = TextStyle(
    fontSize: 18.sp,
    fontWeight: FontWeightHelper.bold,
    color: AppColors.black,
  );
  static TextStyle font14DarkGreyBold = TextStyle(
    fontSize: 14.sp,
    fontWeight: FontWeightHelper.semiBold,
    color: AppColors.darkGrey,
  );
  static TextStyle font12RedError = TextStyle(
    color: Colors.red,
    fontSize: 12.sp,
  );
  static TextStyle font14DarkGreyExtraBold = TextStyle(
    fontSize: 14.sp,
    fontWeight: FontWeightHelper.extraBold,
    color: AppColors.darkGrey,
  );
  static TextStyle font14GreyExtraBold = TextStyle(
    fontSize: 14.sp,
    fontWeight: FontWeightHelper.black,
    color: Colors.grey.shade600,
  );
  static TextStyle font12GreyExtraBold = TextStyle(
    fontSize: 12.sp,
    fontWeight: FontWeightHelper.black,
    color: Colors.grey.shade600,
  );
  static TextStyle font16BlackBold = TextStyle(
    fontSize: 16.sp,
    fontWeight: FontWeightHelper.bold,
    color: AppColors.black,
  );
  static TextStyle font16WhiteBold = TextStyle(
    fontSize: 16.sp,
    fontWeight: FontWeightHelper.bold,
    color: AppColors.white,
  );
}
