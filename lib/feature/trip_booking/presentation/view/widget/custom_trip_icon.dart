import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:travel_app/core/theme/app_color.dart';

class CustomTripIcon extends StatelessWidget {
  const CustomTripIcon({super.key, this.onPressed, required this.icon});

  final void Function()? onPressed;
  final IconData icon;

  @override
  Widget build(BuildContext context) {
    return IconButton(
      onPressed: onPressed,
      icon: Icon(
        size: 30.sp,
        icon,
        color: AppColors.primaryColor,
      ),
    );
  }
}
