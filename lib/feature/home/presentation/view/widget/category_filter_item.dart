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
  });

  final String text;
  final bool isSelected;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(left: 10.w),
      child: AnimatedContainer(
        duration: Duration(milliseconds: 500),
        width: 80.w,
        height: 40.h,
        decoration: BoxDecoration(
          boxShadow: [
            BoxShadow(
              color: AppColors.black.withOpacity(.2),
              offset: Offset(0, 5),
              blurRadius: 10,
            ),
          ],
          borderRadius: BorderRadius.circular(10),
          color: isSelected ? AppColors.primaryColor : AppColors.white,
        ),
        child: Center(
          child: Text(
            text,
            style: isSelected ? Styles.font16WhiteBold : Styles.font16BlackBold,
          ),
        ),
      ),
    );
  }
}
