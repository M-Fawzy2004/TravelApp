// ignore_for_file: deprecated_member_use

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:travel_app/core/theme/app_color.dart';
import 'package:travel_app/core/theme/styles.dart';

class CategoryFilterItem extends StatelessWidget {
  const CategoryFilterItem({
    super.key,
    required this.text,
    required this.isSelected,
    required this.color,
  });

  final String text;
  final bool isSelected;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(left: 10.w),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 500),
        width: 110.w,
        height: 40.h,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          color: isSelected ? color : AppColors.white,
        ),
        child: Center(
          child: Text(
            text,
            style: isSelected
                ? Styles.font14GreyExtraBold.copyWith(
                    color: AppColors.white,
                  )
                : Styles.font14BlackExtraBold,
          ),
        ),
      ),
    );
  }
}
