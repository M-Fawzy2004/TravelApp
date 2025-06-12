import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:travel_app/core/helper/spacing.dart';
import 'package:travel_app/core/theme/app_color.dart';
import 'package:travel_app/core/theme/styles.dart';

class IconTextTile extends StatelessWidget {
  const IconTextTile({
    super.key,
    required this.title,
    required this.icon,
    this.color,
    this.backgroundColor,
    this.onTap,
  });

  final String title;
  final IconData icon;
  final Color? color;
  final Color? backgroundColor;
  final Function()? onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        height: 60.h,
        margin: EdgeInsets.only(bottom: 10.h),
        padding: EdgeInsets.symmetric(horizontal: 20.w),
        decoration: BoxDecoration(
          color: backgroundColor?.withOpacity(0.2) ??
              AppColors.getSurfaceColor(context),
          borderRadius: BorderRadius.circular(25.r),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(
              icon,
              color: color ?? AppColors.getLightGreyColor(context),
              size: 20.h,
            ),
            widthBox(15),
            Text(title, style: Styles.font16BlackBold(context)),
            const Spacer(),
            Icon(
              Icons.arrow_forward_ios,
              color: AppColors.getLightGreyColor(context),
              size: 20.h,
            ),
          ],
        ),
      ),
    );
  }
}
