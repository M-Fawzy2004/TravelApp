import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:travel_app/core/theme/app_color.dart';

class UserAvatar extends StatelessWidget {
  const UserAvatar({
    super.key,
    this.radius,
  });

  final double? radius;

  @override
  Widget build(BuildContext context) {
    return CircleAvatar(
      radius: radius ?? 30.r,
      backgroundColor: AppColors.getLightGreyColor(context),
      child: Icon(
        Icons.person,
        color: AppColors.getSurfaceColor(context),
        size: 35.sp,
      ),
    );
  }
}
