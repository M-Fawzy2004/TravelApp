import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:travel_app/core/helper/spacing.dart';
import 'package:travel_app/core/theme/app_color.dart';
import 'package:travel_app/core/theme/styles.dart';

class CategoryTravel extends StatelessWidget {
  const CategoryTravel({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 150.h,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(15.r),
        border: Border.all(
          width: 4.w,
          color: AppColors.primaryColor,
        ),
      ),
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 10.h),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'توصيل من المحله الى القاهره',
              style: Styles.font16BlackBold,
            ),
            heightBox(10),
            Text(
              '20/4/2025',
              style: Styles.font14DarkGreyBold,
            ),
            heightBox(5),
            Text(
              'يوم الرحله : الأحد ',
              style: Styles.font14DarkGreyBold.copyWith(
                fontWeight: FontWeight.w900,
              ),
            ),
            heightBox(5),
            Text(
              'الاسم : محمد فوزى',
              style: Styles.font14DarkGreyBold.copyWith(
                fontWeight: FontWeight.w900,
              ),
            ),
            heightBox(10),
            Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(10.r),
                  bottomRight: Radius.circular(10.r),
                ),
                color: AppColors.grey.withOpacity(0.7),
              ),
              child: Text(
                'السعر : 200 جنيه',
                style: Styles.font14DarkGreyBold,
              ),
            ),
            Spacer(),
            Container(
              padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 7.h),
              decoration: BoxDecoration(
                color: AppColors.primaryColor,
                borderRadius: BorderRadius.circular(10.r),
              ),
              child: Center(
                child: Text(
                  'أنقر للتفاصيل',
                  style: Styles.font14DarkGreyBold,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
