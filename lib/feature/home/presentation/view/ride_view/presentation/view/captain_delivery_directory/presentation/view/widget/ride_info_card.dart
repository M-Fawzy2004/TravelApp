import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:slide_to_act/slide_to_act.dart';
import 'package:travel_app/core/helper/spacing.dart';
import 'package:travel_app/core/theme/app_color.dart';
import 'package:travel_app/core/theme/styles.dart';

class RideInfoCard extends StatelessWidget {
  const RideInfoCard({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 10.w),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20.r),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            blurRadius: 10,
            offset: const Offset(0, -5),
          ),
        ],
      ),
      child: Padding(
        padding: EdgeInsets.all(15.sp),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text('محمد فوزى', style: Styles.font16BlackBold(context)),
                Text(
                  'من 10,00 ج.م • 00:28',
                  style: Styles.font14GreyExtraBold(context),
                ),
              ],
            ),
            heightBox(15),
            Container(
              padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 8.h),
              decoration: BoxDecoration(
                color: AppColors.getLightGreyColor(context),
                borderRadius: BorderRadius.circular(8.r),
              ),
              child: Row(
                children: [
                  Icon(
                    Icons.location_on_outlined,
                    size: 18.sp,
                  ),
                  widthBox(5),
                  Text(
                    'كوبرى قصر النيل القاهره',
                    style: Styles.font16WhiteBold(context).copyWith(),
                  ),
                ],
              ),
            ),
            heightBox(15),
            Row(
              children: [
                Expanded(
                  child: Container(
                    height: 50.h,
                    decoration: BoxDecoration(
                      color: AppColors.getLightGreyColor(context),
                      borderRadius: BorderRadius.circular(12.r),
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          FontAwesomeIcons.solidMessage,
                          color: AppColors.getSurfaceColor(context),
                          size: 18.sp,
                        ),
                        heightBox(5),
                        Text(
                          'محادثة',
                          style: Styles.font12GreyExtraBold(context).copyWith(
                            color: AppColors.getSurfaceColor(context),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                widthBox(10),
                Expanded(
                  child: Container(
                    height: 50.h,
                    decoration: BoxDecoration(
                      color: AppColors.getLightGreyColor(context),
                      borderRadius: BorderRadius.circular(12.r),
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          FontAwesomeIcons.route,
                          color: AppColors.getSurfaceColor(context),
                          size: 18.sp,
                        ),
                        heightBox(5),
                        Text(
                          'التنقل',
                          style: Styles.font12GreyExtraBold(context).copyWith(
                            color: AppColors.getSurfaceColor(context),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
            heightBox(15),
            SlideAction(
              height: 55.h,
              sliderButtonIconPadding: 10.w,
              sliderButtonIcon: const Icon(
                FontAwesomeIcons.arrowRight,
                color: AppColors.darkGrey,
              ),
              animationDuration: const Duration(milliseconds: 500),
              borderRadius: 15.r,
              outerColor: AppColors.getPrimaryColor(context),
              innerColor: AppColors.getBackgroundColor(context),
              sliderRotate: false,
              elevation: 6,
              onSubmit: () {
                Future.delayed(const Duration(seconds: 2), () {
                  return null;
                });
                return null;
              },
              child: Text(
                'ابدأ الرحلة',
                style: Styles.font16WhiteBold(context),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
