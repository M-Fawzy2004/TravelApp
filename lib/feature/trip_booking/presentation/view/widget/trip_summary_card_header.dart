import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:travel_app/core/helper/spacing.dart';
import 'package:travel_app/core/theme/app_color.dart';
import 'package:travel_app/feature/trip_booking/domain/entity/booking_item_entity.dart';

class TripSummaryCardHeader extends StatelessWidget {
  const TripSummaryCardHeader({
    super.key,
    required this.bookingItemEntity,
  });

  final BookingItemEntity bookingItemEntity;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Container(
          padding: EdgeInsets.all(10.w),
          decoration: BoxDecoration(
            color: AppColors.primaryColor.withOpacity(0.1),
            borderRadius: BorderRadius.circular(12.r),
          ),
          child: Icon(
            FontAwesomeIcons.car,
            color: AppColors.primaryColor,
            size: 28.sp,
          ),
        ),
        widthBox(12),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                bookingItemEntity.trip.destinationName,
                style: TextStyle(
                  fontSize: 16.sp,
                  fontWeight: FontWeight.bold,
                  color: AppColors.primaryColor,
                ),
              ),
              heightBox(4),
              Text(
                'مدة الرحلة: ${bookingItemEntity.trip.duration}',
                style: TextStyle(
                  fontSize: 12.sp,
                  color: Colors.grey,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
