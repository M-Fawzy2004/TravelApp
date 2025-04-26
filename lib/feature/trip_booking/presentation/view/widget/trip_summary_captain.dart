import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:travel_app/core/helper/spacing.dart';
import 'package:travel_app/core/theme/app_color.dart';
import 'package:travel_app/core/theme/styles.dart';

class TripSummaryCaptain extends StatelessWidget {
  const TripSummaryCaptain({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 8.h),
      padding: EdgeInsets.all(16.w),
      decoration: BoxDecoration(
        color: AppColors.primaryColor.withOpacity(0.1),
        borderRadius: BorderRadius.circular(20.r),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(Icons.person, color: AppColors.primaryColor, size: 24.sp),
              widthBox(8),
              Text(
                'اسم الراكب: محمد أحمد',
                style: TextStyle(
                  fontSize: 16.sp,
                  fontWeight: FontWeight.bold,
                  color: AppColors.primaryColor,
                ),
              ),
            ],
          ),
          heightBox(5),
          Text(
            'رقم الهاتف: 01012345678',
            style: Styles.font12GreyExtraBold,
          ),
          heightBox(5),
          Text(
            'عدد التذاكر: 2',
            style: Styles.font12GreyExtraBold,
          ),
          Row(
            children: [
              Text(
                'السعر الإجمالي: 300 ج.م',
                style: Styles.font12GreyExtraBold,
              ),
              Spacer(),
              IconButton(
                onPressed: () {},
                icon: Icon(Icons.phone, color: AppColors.primaryColor),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
