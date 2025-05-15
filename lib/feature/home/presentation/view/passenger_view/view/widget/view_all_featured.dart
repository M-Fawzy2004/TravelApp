import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:go_router/go_router.dart';
import 'package:travel_app/core/helper/app_router.dart';
import 'package:travel_app/core/helper/spacing.dart';
import 'package:travel_app/core/theme/app_color.dart';
import 'package:travel_app/core/theme/styles.dart';

class ViewAllFeatured extends StatelessWidget {
  const ViewAllFeatured({super.key});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        context.push(AppRouter.featuredHomeView);
      },
      child: Container(
        width: 130.w,
        height: 130.h,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10.r),
          color: AppColors.primaryColor,
        ),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                'عرض الكل',
                style: Styles.font16WhiteBold,
              ),
              heightBox(10),
              Icon(
                FontAwesomeIcons.arrowRight,
                color: AppColors.white,
                size: 16.sp,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
