import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:travel_app/core/helper/spacing.dart';
import 'package:travel_app/core/theme/app_color.dart';
import 'package:travel_app/core/theme/styles.dart';
import 'package:travel_app/feature/position_bus/data/model/governorate_model.dart';

class RouteListTile extends StatelessWidget {
  final RouteModel route;

  const RouteListTile({
    super.key,
    required this.route,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(bottom: 4.h),
      padding: EdgeInsets.all(16.w),
      decoration: BoxDecoration(
        color: AppColors.getSurfaceColor(context),
        borderRadius: BorderRadius.circular(25.r),
      ),
      child: Row(
        children: [
          Container(
            padding: EdgeInsets.all(12.w),
            decoration: BoxDecoration(
              color: AppColors.primaryColor.withOpacity(0.1),
              borderRadius: BorderRadius.circular(25.r),
            ),
            child: Icon(
              Icons.directions_bus,
              color: AppColors.primaryColor,
              size: 20.sp,
            ),
          ),
          widthBox(12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  route.destination.isNotEmpty ? route.destination : 'غير محدد',
                  style: Styles.font14GreyExtraBold(context),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
                heightBox(4),
                Row(
                  children: [
                    Icon(
                      Icons.access_time,
                      size: 14.sp,
                      color: AppColors.primaryColor,
                    ),
                    widthBox(4),
                    Text(
                      'الوقت المتوقع : ',
                      style: Styles.font12GreyExtraBold(context),
                    ),
                    widthBox(4),
                    Text(
                      route.duration.isNotEmpty ? route.duration : 'غير محدد',
                      style: Styles.font12GreyExtraBold(context),
                    ),
                  ],
                ),
              ],
            ),
          ),
          Container(
            padding: EdgeInsets.symmetric(horizontal: 15.w, vertical: 10.h),
            decoration: BoxDecoration(
              color: AppColors.primaryColor.withOpacity(0.1),
              borderRadius: BorderRadius.circular(25.r),
            ),
            child: Text(
              '${route.price} ج.م',
              style: Styles.font12GreyExtraBold(context).copyWith(
                color: AppColors.primaryColor,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
