import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:travel_app/core/helper/spacing.dart';
import 'package:travel_app/core/theme/app_color.dart';
import 'package:travel_app/core/theme/styles.dart';
import 'package:travel_app/feature/trips_details/presentation/view/widget/details_trip_view_body.dart';

class DetailsTripsText extends StatelessWidget {
  const DetailsTripsText({
    super.key,
    required this.widget,
  });

  final DetailsTripViewBody widget;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('التفاصيل', style: Styles.font16BlackBold(context)),
        heightBox(10),
        Container(
          padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 10.h),
          width: double.infinity,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10.r),
            color: AppColors.getBackgroundColor(context),
            boxShadow: [
              BoxShadow(
                color: AppColors.getTextColor(context).withOpacity(.2),
                blurRadius: 6,
                spreadRadius: 0,
                offset: const Offset(0, 3),
              ),
            ],
          ),
          child: Text(
            widget.trip.additionalDetails,
            style: Styles.font16BlackBold(context).copyWith(
              color: Colors.grey.shade700,
            ),
          ),
        ),
      ],
    );
  }
}
