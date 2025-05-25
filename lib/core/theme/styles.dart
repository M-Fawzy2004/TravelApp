import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:travel_app/core/theme/app_color.dart';
import 'package:travel_app/core/theme/font_weight_helper.dart';

class Styles {
  static TextStyle font30ExtraBlackBold(BuildContext context) => TextStyle(
    fontSize: 30.sp,
    fontWeight: FontWeightHelper.extraBold,
    color: AppColors.getTextColor(context),
  );

  static TextStyle font20ExtraBlackBold(BuildContext context) => TextStyle(
    fontSize: 20.sp,
    fontWeight: FontWeightHelper.extraBold,
    color: AppColors.getTextColor(context),
  );

  static TextStyle font20BlackBold(BuildContext context) => TextStyle(
    fontSize: 20.sp,
    fontWeight: FontWeightHelper.bold,
    color: AppColors.getTextColor(context),
  );

  static TextStyle font18BlackBold(BuildContext context) => TextStyle(
    fontSize: 18.sp,
    fontWeight: FontWeightHelper.bold,
    color: AppColors.getTextColor(context),
  );

  static TextStyle font14DarkGreyBold(BuildContext context) => TextStyle(
    fontSize: 14.sp,
    fontWeight: FontWeightHelper.semiBold,
    color: AppColors.getDarkGreyColor(context),
  );

  static TextStyle font12RedError = TextStyle(
    color: Colors.red,
    fontSize: 12.sp,
  );

  static TextStyle font14DarkGreyExtraBold(BuildContext context) => TextStyle(
    fontSize: 14.sp,
    fontWeight: FontWeightHelper.extraBold,
    color: AppColors.getDarkGreyColor(context),
  );

  static TextStyle font14GreyExtraBold(BuildContext context) => TextStyle(
    fontSize: 14.sp,
    fontWeight: FontWeightHelper.black,
    color: AppColors.getGreyShade600(context),
  );

  static TextStyle font14BlackExtraBold(BuildContext context) => TextStyle(
    fontSize: 14.sp,
    fontWeight: FontWeightHelper.black,
    color: AppColors.getTextColor(context),
  );

  static TextStyle font12GreyExtraBold(BuildContext context) => TextStyle(
    fontSize: 12.sp,
    fontWeight: FontWeightHelper.black,
    color: AppColors.getGreyShade600(context),
  );

  static TextStyle font16BlackBold(BuildContext context) => TextStyle(
    fontSize: 16.sp,
    fontWeight: FontWeightHelper.bold,
    color: AppColors.getTextColor(context),
  );

  static TextStyle font16WhiteBold(BuildContext context) => TextStyle(
    fontSize: 16.sp,
    fontWeight: FontWeightHelper.bold,
    color: AppColors.getSurfaceColor(context),
  );
}