import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_styled_toast/flutter_styled_toast.dart';
import 'package:travel_app/core/theme/app_color.dart';
import 'package:travel_app/core/theme/styles.dart';

void showCustomTopSnackBar(
    {required BuildContext context, required String message}) {
  showToast(
    message,
    context: context,
    fullWidth: true,
    animation: StyledToastAnimation.fadeScale,
    reverseAnimation: StyledToastAnimation.size,
    position: StyledToastPosition.top,
    duration: const Duration(seconds: 3),
    backgroundColor: AppColors.primaryColor,
    borderRadius: BorderRadius.circular(10.r),
    textStyle: Styles.font16WhiteBold,
    textPadding: EdgeInsets.symmetric(vertical: 15.h),
  );
}
