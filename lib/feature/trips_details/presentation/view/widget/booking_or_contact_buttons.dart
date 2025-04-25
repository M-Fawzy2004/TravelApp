import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:travel_app/core/helper/spacing.dart';
import 'package:travel_app/core/theme/app_color.dart';
import 'package:travel_app/core/widget/custom_button.dart';
import 'package:travel_app/feature/trips_details/presentation/view/widget/custom_fav_details.dart';

class BookingOrContactButtons extends StatelessWidget {
  const BookingOrContactButtons({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 10.h),
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(10.r),
          topRight: Radius.circular(10.r),
        ),
        boxShadow: [
          BoxShadow(
            color: AppColors.black.withOpacity(.3),
            blurRadius: 6,
            spreadRadius: 0,
            offset: Offset(0, 1),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          Row(
            children: [
              Expanded(
                flex: 6,
                child: CustomButton(
                  onPressed: () {},
                  buttonText: 'حجز الرحلة',
                ),
              ),
              widthBox(10),
              Expanded(
                flex: 1,
                child: CustomFavDetails(),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
