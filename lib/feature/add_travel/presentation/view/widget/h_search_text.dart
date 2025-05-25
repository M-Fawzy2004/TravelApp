import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:travel_app/core/theme/app_color.dart';

class HSearchText extends StatelessWidget {
  const HSearchText({
    super.key,
    required int currentSearchCount,
  }) : _currentSearchCount = currentSearchCount;

  final int _currentSearchCount;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 4.h),
      decoration: BoxDecoration(
        color: AppColors.getPrimaryColor(context).withOpacity(0.1),
        borderRadius: BorderRadius.circular(12.r),
      ),
      child: Text(
        'البحث #$_currentSearchCount',
        style: TextStyle(
          fontSize: 10.sp,
          color: AppColors.getPrimaryColor(context),
          fontWeight: FontWeight.w600,
        ),
      ),
    );
  }
}
