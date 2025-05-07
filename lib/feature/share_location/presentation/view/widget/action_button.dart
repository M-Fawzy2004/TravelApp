import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:travel_app/core/theme/app_color.dart';
import 'package:travel_app/core/theme/styles.dart';

class ActionButton extends StatelessWidget {
  final IconData icon;
  final String label;
  final VoidCallback? onPressed;
  final bool isPrimary;
  final bool isFullWidth;

  const ActionButton({
    super.key,
    required this.icon,
    required this.label,
    this.onPressed,
    this.isPrimary = false,
    this.isFullWidth = false,
  });

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onPressed,
      style: ElevatedButton.styleFrom(
        backgroundColor: isPrimary ? AppColors.primaryColor : Colors.white,
        foregroundColor: isPrimary ? Colors.white : AppColors.primaryColor,
        side: isPrimary
            ? null
            : const BorderSide(color: AppColors.primaryColor, width: 1),
        padding: EdgeInsets.symmetric(vertical: 12.h),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8.r),
        ),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(icon, size: 16.sp),
          SizedBox(width: 8.w),
          Text(
            label,
            style: Styles.font14GreyExtraBold.copyWith(
              color: isPrimary ? Colors.white : AppColors.primaryColor,
            ),
          ),
        ],
      ),
    );
  }
}
