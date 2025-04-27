import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:travel_app/core/theme/app_color.dart';
import 'package:travel_app/core/utils/assets.dart';
import 'package:travel_app/feature/home/presentation/view/widget/share_location_button.dart';

class CustomTripLocation extends StatelessWidget {
  const CustomTripLocation({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 150.h,
      width: double.infinity,
      padding: EdgeInsets.symmetric(horizontal: 5.w, vertical: 5.h),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10.r),
        color: AppColors.primaryColor,
        boxShadow: [
          BoxShadow(
            color: AppColors.black.withOpacity(.2),
            blurRadius: 6,
            spreadRadius: 0,
            offset: const Offset(0, 3),
          ),
        ],
        image: const DecorationImage(
          image: AssetImage(Assets.imagesLoactionMap),
          fit: BoxFit.fill,
        ),
      ),
      child: const ShareLocationButton(
        title: 'معرفه موقع تحرك الرحله',
      ),
    );
  }
}
