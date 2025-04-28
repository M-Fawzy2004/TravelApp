import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:travel_app/core/theme/app_color.dart';

class CustomFavDetails extends StatelessWidget {
  const CustomFavDetails({super.key});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {},
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 300),
        padding: EdgeInsets.symmetric(
          horizontal: 10.w,
          vertical: 12.h,
        ),
        decoration: BoxDecoration(
          color: AppColors.grey,
          borderRadius: BorderRadius.circular(10.r),
          boxShadow: [
            BoxShadow(
              color: AppColors.black.withOpacity(.3),
              blurRadius: 6,
              spreadRadius: 0,
              offset: const Offset(0, 1),
            ),
          ],
        ),
        child: const Icon(
          FontAwesomeIcons.heart,
          color: AppColors.primaryColor,
        ),
      ),
    );
  }
}
