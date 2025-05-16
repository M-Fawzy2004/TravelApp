import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:travel_app/core/theme/app_color.dart';
import 'package:travel_app/core/theme/styles.dart';

class CustomButtonAccept extends StatelessWidget {
  const CustomButtonAccept({
    super.key,
    this.onAccept,
    required this.title,
    this.backgroundColor,
  });
  final VoidCallback? onAccept;
  final String title;
  final Color? backgroundColor;

  @override
  Widget build(BuildContext context) {
    return TextButton(
      style: ButtonStyle(
        shape: WidgetStateProperty.all<RoundedRectangleBorder>(
          RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10.r),
          ),
        ),
        overlayColor:
            WidgetStateProperty.all(AppColors.darkGrey.withOpacity(.2)),
        backgroundColor: WidgetStatePropertyAll(
          backgroundColor ?? AppColors.primaryColor,
        ),
        padding: WidgetStateProperty.all<EdgeInsets>(
          EdgeInsets.symmetric(vertical: 20.h),
        ),
      ),
      onPressed: onAccept,
      child: FittedBox(
        child: Text(
          title,
          style: Styles.font14DarkGreyBold.copyWith(
            color: AppColors.white,
          ),
        ),
      ),
    );
  }
}
