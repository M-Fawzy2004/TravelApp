// CategoryFilterItem.dart
// ignore_for_file: deprecated_member_use

import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:travel_app/core/theme/app_color.dart';
import 'package:travel_app/core/theme/styles.dart';

class CategoryFilterItem extends StatelessWidget {
  const CategoryFilterItem({
    super.key,
    required this.text,
    required this.isSelected,
  });

  final String text;
  final bool isSelected;

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Padding(
      padding: EdgeInsets.only(left: 10.w),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 500),
        width: 110.w,
        height: 50.h,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(25.r),
          border: Border.all(
            color: isSelected
                ? AppColors.primaryColor.withOpacity(0.4)
                : isDark
                    ? Colors.white.withOpacity(0.2)
                    : Colors.white.withOpacity(0.7),
            width: isSelected ? 1.5 : 1.0,
          ),
          boxShadow: [
            BoxShadow(
              color: isSelected
                  ? AppColors.primaryColor.withOpacity(0.2)
                  : isDark
                      ? Colors.black.withOpacity(0.3)
                      : Colors.black.withOpacity(0.08),
              blurRadius: isSelected ? 15 : 10,
              offset: const Offset(0, 4),
            ),
            if (!isSelected)
              BoxShadow(
                color: isDark
                    ? Colors.white.withOpacity(0.02)
                    : Colors.white.withOpacity(0.1),
                blurRadius: 8,
                offset: const Offset(-2, -2),
              ),
          ],
        ),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(25.r),
          child: BackdropFilter(
            filter: ImageFilter.blur(
              sigmaX: 4.0,
              sigmaY: 4.0,
            ),
            child: Container(
              decoration: BoxDecoration(
                color: isSelected
                    ? AppColors.darkPrimaryColor.withOpacity(0.1)
                    : Colors.white10,
                borderRadius: BorderRadius.circular(25.r),
              ),
              child: Center(
                child: AnimatedDefaultTextStyle(
                  duration: const Duration(milliseconds: 300),
                  style: isSelected
                      ? Styles.font14GreyExtraBold(context).copyWith(
                          fontFamily: 'font',
                          color: AppColors.primaryColor,
                          fontWeight: FontWeight.w800,
                        )
                      : Styles.font14BlackExtraBold(context).copyWith(
                          fontFamily: 'font',
                          color: isDark
                              ? Colors.white.withOpacity(0.8)
                              : Colors.black.withOpacity(0.7),
                          fontWeight: FontWeight.w600,
                        ),
                  child: Text(text),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
