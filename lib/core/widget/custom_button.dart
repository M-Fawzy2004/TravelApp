import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:travel_app/core/theme/app_color.dart';
import 'package:travel_app/core/theme/styles.dart';

class CustomButton extends StatelessWidget {
  final double? borderRadius;
  final Color? backgroundColor;
  final double? horizontalPadding;
  final double? verticalPadding;
  final double? buttonWidth;
  final double? buttonHeight;
  final String buttonText;
  final void Function()? onPressed;
  final bool isEnabled;

  const CustomButton({
    super.key,
    this.borderRadius,
    this.backgroundColor,
    this.horizontalPadding,
    this.verticalPadding,
    this.buttonHeight,
    this.buttonWidth,
    required this.buttonText,
    required this.onPressed,
    this.isEnabled = true,
  });

  @override
  Widget build(BuildContext context) {
    return TextButton(
      style: ButtonStyle(
        shape: WidgetStateProperty.all<RoundedRectangleBorder>(
          RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(borderRadius ?? 10.0.r),
          ),
        ),
        overlayColor:
            WidgetStateProperty.all(AppColors.darkGrey.withOpacity(.2)),
        backgroundColor: WidgetStatePropertyAll(
          backgroundColor ?? AppColors.getPrimaryColor(context),
        ),
        padding: WidgetStateProperty.all<EdgeInsets>(
          EdgeInsets.symmetric(
            horizontal: horizontalPadding?.w ?? 12.w,
            vertical: verticalPadding?.h ?? 14.h,
          ),
        ),
        fixedSize: WidgetStateProperty.all(
          Size(buttonWidth?.w ?? double.maxFinite, buttonHeight ?? 50.h),
        ),
      ),
      onPressed: isEnabled ? onPressed : null,
      child: FittedBox(
        child: Text(
          buttonText,
          style: Styles.font14DarkGreyBold(context).copyWith(
            color: AppColors.getSurfaceColor(context),
          ),
        ),
      ),
    );
  }
}
