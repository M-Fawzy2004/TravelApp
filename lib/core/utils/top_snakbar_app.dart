import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:travel_app/core/theme/app_color.dart';
import 'package:travel_app/core/theme/styles.dart';

void showCustomTopSnackBar({
  required BuildContext context,
  String? label,
  required String message,
  VoidCallback? onPressed,
  Color? backgroundColor,
}) {
  final snackBar = SnackBar(
    content: Container(
      height: 60.h,
      alignment: Alignment.centerRight,
      child: Text(
        message,
        style: Styles.font16WhiteBold(context),
      ),
    ),
    action: label != null && label.isNotEmpty
        ? SnackBarAction(
            label: label,
            onPressed: onPressed ?? () {},
          )
        : null,
    backgroundColor: backgroundColor ?? AppColors.getPrimaryColor(context),
    duration: const Duration(seconds: 3),
    behavior: SnackBarBehavior.floating,
    margin: EdgeInsets.only(
      left: 16.w,
      right: 16.w,
      bottom: 80.0,
    ),
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(10.r),
    ),
    padding: const EdgeInsets.symmetric(
      vertical: 0,
      horizontal: 16.0,
    ),
    elevation: 8,
  );

  ScaffoldMessenger.of(context).showSnackBar(snackBar);
}
