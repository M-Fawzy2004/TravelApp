// ignore_for_file: deprecated_member_use

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:travel_app/core/helper/extension.dart';
import 'package:travel_app/core/theme/app_color.dart';

class IconBack extends StatelessWidget {
  const IconBack({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 5.w, vertical: 10.h),
      height: 40.h,
      width: 40.w,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10.r),
        color: AppColors.grey,
        boxShadow: [
          BoxShadow(
            color: AppColors.black.withOpacity(.2),
            blurRadius: 6,
            spreadRadius: 0,
            offset: const Offset(0, 1),
          ),
        ],
      ),
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 5.w),
        child: IconButton(
          onPressed: () {
            context.pop();
          },
          icon: const Icon(
            size: 18,
            FontAwesomeIcons.arrowRight,
            color: AppColors.black,
          ),
        ),
      ),
    );
  }
}
