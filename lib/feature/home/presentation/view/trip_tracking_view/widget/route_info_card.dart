import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:travel_app/core/helper/spacing.dart';
import 'package:travel_app/core/theme/app_color.dart';
import 'package:travel_app/core/theme/styles.dart';

class RouteInfoCard extends StatelessWidget {
  const RouteInfoCard({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(
        horizontal: 10.w,
        vertical: 8.h,
      ),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10.r),
        color: AppColors.primaryColor.withOpacity(.1),
      ),
      child: Column(
        children: [
          Row(
            children: [
              const Icon(Icons.location_on, color: Colors.green),
              widthBox(8),
              Expanded(
                child: Text(
                  'من : باب اللوق',
                  style: Styles.font16BlackBold,
                ),
              ),
            ],
          ),
          heightBox(8),
          Row(
            children: [
              const Icon(Icons.location_on, color: Colors.red),
              widthBox(8),
              Expanded(
                child: Text(
                  'إلى : المعادي',
                  style: Styles.font16BlackBold,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
