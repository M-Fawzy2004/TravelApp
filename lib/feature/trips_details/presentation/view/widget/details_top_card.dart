import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:travel_app/core/helper/spacing.dart';
import 'package:travel_app/core/theme/app_color.dart';
import 'package:travel_app/feature/add_travel/data/model/trip_model.dart';
import 'package:travel_app/core/widget/details_info_row.dart';

class DetailsTopCard extends StatelessWidget {
  const DetailsTopCard({
    super.key,
    required this.trip,
    this.index,
  });

  final TripModel trip;
  final int? index;

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(25.r),
      child: Container(
        decoration: BoxDecoration(
          color: AppColors.getBackgroundColor(context).withOpacity(0.2),
          borderRadius: BorderRadius.circular(25.r),
          border: Border.all(
            color: AppColors.getSurfaceColor(context),
            width: 1.5,
          ),
        ),
        child: Padding(
          padding: EdgeInsets.all(15.w),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                width: double.infinity,
                padding: EdgeInsets.symmetric(vertical: 12.h, horizontal: 16.w),
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: [
                      Colors.blue.withOpacity(0.3),
                      Colors.purple.withOpacity(0.3),
                    ],
                  ),
                  borderRadius: BorderRadius.circular(25.r),
                ),
                child: Text(
                  'تفاصيل الرحلة',
                  style: TextStyle(
                    fontSize: 18.sp,
                    fontWeight: FontWeight.bold,
                    color: AppColors.getTextColor(context),
                  ),
                  textAlign: TextAlign.center,
                ),
              ),
              heightBox(20),
              DetailsInfoRow(
                icon: Icons.location_on,
                label: 'مكان التحرك',
                value: trip.departureLocation,
                color: Colors.green,
              ),
              _glassDivider(context),
              DetailsInfoRow(
                icon: Icons.flag,
                label: 'مكان الوصول',
                value: trip.arrivalLocation,
                color: Colors.red,
              ),
              _glassDivider(context),
              DetailsInfoRow(
                icon: Icons.date_range,
                label: 'تاريخ الرحله',
                value:
                    '${trip.tripDate.day} / ${trip.tripDate.month} / ${trip.tripDate.year}',
                color: Colors.blue,
              ),
              _glassDivider(context),
              DetailsInfoRow(
                icon: Icons.access_time,
                label: 'توقيت الرحله',
                value:
                    '${trip.tripTime.hour}:${trip.tripTime.minute.toString().padLeft(2, '0')} ${getPeriodOfDay(trip.tripTime)}',
                color: Colors.orange,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

Widget _glassDivider(BuildContext context) => Padding(
      padding: EdgeInsets.symmetric(vertical: 8.h),
      child: Container(
        height: 1,
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [
              Colors.transparent,
              AppColors.getPrimaryColor(context).withOpacity(0.3),
              Colors.transparent,
            ],
          ),
        ),
      ),
    );

String getPeriodOfDay(TimeOfDay time) {
  return time.hour < 12 ? 'صباحًا' : 'مساءً';
}
