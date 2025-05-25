import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:travel_app/core/helper/spacing.dart';
import 'package:travel_app/core/theme/app_color.dart';
import 'package:travel_app/core/theme/styles.dart';

class SwipeToStartCard extends StatelessWidget {
  const SwipeToStartCard({
    super.key,
    required this.dragOffset,
    required this.canComplete,
    required this.progress,
  });

  final double dragOffset;
  final bool canComplete;
  final double progress;

  @override
  Widget build(BuildContext context) {
    return Transform.translate(
      offset: Offset(dragOffset, 0),
      child: Container(
        width: 130.w,
        height: 200.h,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12.r),
          border: Border.all(
            color: canComplete
                ? AppColors.getPrimaryColor(context)
                : AppColors.getLightGreyColor(context),
            width: progress > 0.5 ? 2 : 1,
          ),
          color: AppColors.getSurfaceColor(context),
          boxShadow: [
            BoxShadow(
              color: AppColors.getPrimaryColor(context).withOpacity(0.2),
              blurRadius: 8 + (progress * 8),
              offset: const Offset(0, 4),
            ),
          ],
        ),
        padding: EdgeInsets.all(12.r),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Transform.rotate(
              angle: progress * 6.28,
              child: Icon(
                canComplete ? Icons.rocket_launch : FontAwesomeIcons.arrowRight,
                size: (24 + progress * 8).sp,
                color: canComplete
                    ? AppColors.getPrimaryColor(context)
                    : AppColors.getLightGreyColor(context),
              ),
            ),
            heightBox(10),
            Text(
              canComplete ? 'اترك للانطلاق!' : 'اسحب الى اليمين',
              style: Styles.font14GreyExtraBold(context),
              textAlign: TextAlign.center,
            ),
            heightBox(10),
            Text(
              'وشاهد جميع الرحلات المميزة',
              style: Styles.font12GreyExtraBold(context),
              textAlign: TextAlign.center,
            ),
            heightBox(10),
            Container(
              height: 3.h,
              width: double.infinity,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(2.r),
                color: AppColors.getBackgroundColor(context).withOpacity(0.3),
              ),
              child: FractionallySizedBox(
                alignment: Alignment.centerLeft,
                widthFactor: progress,
                child: Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(2.r),
                    color: canComplete
                        ? AppColors.getPrimaryColor(context)
                        : AppColors.getLightGreyColor(context),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
