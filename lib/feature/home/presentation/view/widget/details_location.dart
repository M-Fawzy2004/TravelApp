// ignore_for_file: deprecated_member_use

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:travel_app/core/helper/get_user.dart';
import 'package:travel_app/core/helper/spacing.dart';
import 'package:travel_app/core/theme/app_color.dart';
import 'package:travel_app/core/theme/styles.dart';
import 'package:travel_app/core/utils/assets.dart';
import 'package:travel_app/feature/home/presentation/view/widget/share_location_button.dart';

class DetailsLocation extends StatelessWidget {
  const DetailsLocation({super.key});

  @override
  Widget build(BuildContext context) {
    if (getUser()?.locationName == null) {
      return Container(
        margin: EdgeInsets.symmetric(horizontal: 4.w),
        width: double.infinity,
        height: 130.h,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          color: AppColors.grey,
          boxShadow: [
            BoxShadow(
              color: AppColors.black.withOpacity(.2),
              offset: const Offset(0, 0),
              blurRadius: 10,
            ),
          ],
          image: const DecorationImage(
            image: AssetImage(Assets.imagesLoactionMap),
            fit: BoxFit.fill,
          ),
        ),
        child: const ShareLocationButton(
          title: 'شارك موقعك',
        ),
      );
    } else {
      return Container(
        padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 10.h),
        margin: EdgeInsets.symmetric(horizontal: 10.w),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(5.r),
          color: AppColors.white,
        ),
        child: Row(
          children: [
            const Icon(
              Icons.location_on,
              color: AppColors.primaryColor,
              size: 25,
            ),
            widthBox(10),
            Text(
              getUser()!.locationName!,
              style: Styles.font16BlackBold,
            ),
            const Spacer(),
            const ShareLocationButton(
              title: 'تعديل الموقع',
            ),
          ],
        ),
      );
    }
  }
}
