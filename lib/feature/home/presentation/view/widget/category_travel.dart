import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:travel_app/core/helper/spacing.dart';
import 'package:travel_app/core/theme/app_color.dart';
import 'package:travel_app/core/theme/styles.dart';

import '../../../../../core/utils/assets.dart';

class CategoryTravel extends StatelessWidget {
  const CategoryTravel({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 120.h,
      margin: EdgeInsets.only(bottom: 10.h),
      padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 5.h),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        color: AppColors.grey,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.15),
            offset: Offset(0, 4),
            blurRadius: 8,
            spreadRadius: 0,
          ),
        ],
        image: DecorationImage(
          image: AssetImage(Assets.imagesImageDecoration),
          fit: BoxFit.cover,
          colorFilter: ColorFilter.mode(
            Colors.black.withOpacity(0.5),
            BlendMode.dstATop,
          ),
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Text(
                'توصيل من المحله الى القاهره',
                style: Styles.font18BlackBold,
              ),
              Spacer(),
              Text(
                '20/4/2025',
                style: Styles.font14DarkGreyBold,
              ),
            ],
          ),
          heightBox(5),
          Text(
            'الاسم : محمد فوزى',
            style: Styles.font14DarkGreyBold,
          ),
          heightBox(5),
          Spacer(),
          Row(
            children: [
              Align(
                alignment: Alignment.bottomLeft,
                child: Container(
                  padding: EdgeInsets.symmetric(horizontal: 7.w, vertical: 5.h),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: AppColors.primaryColor,
                  ),
                  child: Text(
                    'السعر : 200 جنيه',
                    style: Styles.font14DarkGreyBold,
                  ),
                ),
              ),
              Spacer(),
              Text(
                'أنقر للتفاصيل',
                style: Styles.font16BlackBold,
              ),
            ],
          ),
        ],
      ),
    );
  }
}
