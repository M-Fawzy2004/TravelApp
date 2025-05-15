import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:travel_app/core/theme/app_color.dart';
import 'package:travel_app/core/theme/styles.dart';
import 'package:travel_app/core/utils/assets.dart';

class FeaturedTravel extends StatelessWidget {
  const FeaturedTravel({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 130.w,
      height: 130.h,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10.r),
      ),
      child: Stack(
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(10.r),
            child: Image.asset(
              Assets.imagesFeatureTravel,
              width: 130.w,
              height: 130.h,
              fit: BoxFit.cover,
            ),
          ),
          Container(
            width: double.infinity,
            height: 30.h,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.vertical(top: Radius.circular(10.r)),
              color: AppColors.white,
            ),
            alignment: Alignment.center,
            child: Text(
              'شرم الشيخ',
              style: Styles.font14GreyExtraBold,
            ),
          ),
        ],
      ),
    );
  }
}
