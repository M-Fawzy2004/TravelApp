import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:travel_app/core/helper/spacing.dart';
import 'package:travel_app/core/theme/app_color.dart';
import 'package:travel_app/core/theme/styles.dart';

class FeaturedTravel extends StatelessWidget {
  final String imagePath;
  final String location;
  final String country;
  final double rating;

  const FeaturedTravel({
    super.key,
    required this.imagePath,
    required this.location,
    required this.country,
    required this.rating,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 220.w,
      decoration: BoxDecoration(
        border: Border.all(color: AppColors.white, width: 3.w),
        borderRadius: BorderRadius.circular(10.r),
        boxShadow: [
          BoxShadow(
            color: AppColors.black.withOpacity(0.2),
            blurRadius: 4,
            spreadRadius: 1,
          ),
        ],
      ),
      child: Stack(
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(10.r),
            child: Image.asset(
              imagePath,
              width: double.infinity,
              height: double.infinity,
              fit: BoxFit.cover,
            ),
          ),
          Positioned(
            bottom: 5,
            left: 5,
            right: 5,
            child: Container(
              padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 6.h),
              decoration: BoxDecoration(
                color: Colors.white60,
                borderRadius: BorderRadius.circular(10.r),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    location,
                    style: Styles.font16BlackBold.copyWith(
                      fontWeight: FontWeight.w900,
                    ),
                  ),
                  heightBox(5),
                  Row(
                    children: [
                      Icon(
                        Icons.location_on,
                        size: 15.sp,
                      ),
                      widthBox(10),
                      Text(
                        country,
                        style: Styles.font12GreyExtraBold.copyWith(
                          color: AppColors.black,
                        ),
                      ),
                      const Spacer(),
                      Icon(
                        Icons.star,
                        color: Colors.amber,
                        size: 15.sp,
                      ),
                      widthBox(5),
                      Text(
                        rating.toString(),
                        style: Styles.font12GreyExtraBold.copyWith(
                          color: AppColors.black,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
