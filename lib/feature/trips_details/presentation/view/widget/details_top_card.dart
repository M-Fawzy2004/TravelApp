import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:travel_app/core/theme/app_color.dart';
import 'package:travel_app/core/theme/styles.dart';
import 'package:travel_app/feature/add_travel/data/model/trip_model.dart';
import 'package:travel_app/feature/trips_details/presentation/view/widget/details_info_row.dart';

class DetailsTopCard extends StatelessWidget {
  const DetailsTopCard({
    super.key,
    required this.trip,
    this.index,
  });

  final TripModel trip;
  final int? index;
  static const List<LinearGradient> _gradientsList = [
    LinearGradient(colors: [Color(0xFFE3F2FD), Color(0xFF90CAF9)]), // Blue
    LinearGradient(colors: [Color(0xFFFCE4EC), Color(0xFFF48FB1)]), // Pink
    LinearGradient(colors: [Color(0xFFE8F5E9), Color(0xFFA5D6A7)]), // Green
    LinearGradient(colors: [Color(0xFFFFF3E0), Color(0xFFFFCC80)]), // Orange
  ];

  @override
  Widget build(BuildContext context) {
    final gradient =
        trip.gradientIndex >= 0 && trip.gradientIndex < _gradientsList.length
            ? _gradientsList[trip.gradientIndex]
            : _gradientsList[0];
    // final tag = '${trip.id}_$index';

    return Material(
      color: Colors.transparent,
      child: Container(
        decoration: BoxDecoration(
          gradient: gradient,
          borderRadius: BorderRadius.circular(15.r),
          boxShadow: [
            BoxShadow(
              color: AppColors.black.withOpacity(.2),
              blurRadius: 6,
              spreadRadius: 0,
              offset: Offset(0, 1),
            ),
          ],
        ),
        child: Padding(
          padding: EdgeInsets.all(16.w),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Center(
                child: Text(
                  trip.destinationName,
                  style: Styles.font18BlackBold.copyWith(
                    fontSize: 20.sp,
                    color: AppColors.black,
                  ),
                  textAlign: TextAlign.center,
                ),
              ),
              _divider(),
              DetailsInfoRow(
                icon: Icons.location_on,
                label: 'مكان التحرك',
                value: trip.departureLocation,
              ),
              _divider(),
              DetailsInfoRow(
                icon: Icons.flag,
                label: 'مكان الوصول',
                value: trip.arrivalLocation,
              ),
              _divider(),
              DetailsInfoRow(
                icon: Icons.date_range,
                label: 'تاريخ الرحله',
                value:
                    '${trip.tripDate.day} / ${trip.tripDate.month} / ${trip.tripDate.year}',
              ),
              _divider(),
              DetailsInfoRow(
                icon: Icons.access_time,
                label: 'توقيت الرحله',
                value:
                    '${trip.tripTime.hour}:${trip.tripTime.minute.toString().padLeft(2, '0')} ${getPeriodOfDay(trip.tripTime)}',
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _divider() => Padding(
        padding: EdgeInsets.symmetric(vertical: 10.h),
        child: Divider(color: AppColors.grey, thickness: 1),
      );
}

String getPeriodOfDay(TimeOfDay time) {
  return time.hour < 12 ? 'صباحًا' : 'مساءً';
}
