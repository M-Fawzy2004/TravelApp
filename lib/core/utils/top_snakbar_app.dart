import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:travel_app/core/theme/app_color.dart';
import 'package:travel_app/core/theme/styles.dart';

void showCustomTopSnackBar(
    {required BuildContext context, required String message}) {
  final snackBar = SnackBar(
    content: Text(
      message,
      style: Styles.font16WhiteBold(context),
    ),
    backgroundColor: AppColors.getPrimaryColor(context),
    duration: const Duration(seconds: 3),
    behavior: SnackBarBehavior.floating,
    margin: EdgeInsets.only(
      left: 16.w,
      right: 16.w,
      bottom: 80.h,
    ),
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(10.r),
    ),
    padding: EdgeInsets.symmetric(
      vertical: 15.h,
      horizontal: 16.w,
    ),
    elevation: 8,
    animation: const AlwaysStoppedAnimation(1.0),
  );

  ScaffoldMessenger.of(context).showSnackBar(snackBar);
}
