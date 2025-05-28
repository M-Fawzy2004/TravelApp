import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:travel_app/core/helper/spacing.dart';
import 'package:travel_app/core/theme/app_color.dart';
import 'package:travel_app/core/theme/styles.dart';
import 'package:travel_app/feature/trip_booking/domain/entity/booking_item_entity.dart';
import 'package:travel_app/feature/trip_booking/presentation/view/widget/image_favorite.dart';
import 'package:intl/intl.dart';

class TripSummaryCardHeader extends StatelessWidget {
  const TripSummaryCardHeader({
    super.key,
    required this.bookingItemEntity,
  });

  final BookingItemEntity bookingItemEntity;

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        ImageFavorite(
          trip: bookingItemEntity.trip,
          height: 80.h,
          widget: 80.w,
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
                  color: AppColors.getPrimaryColor(context),
                ),
              ),
              heightBox(4),
              Text(
                DateFormat('yyyy-MM-dd')
                    .format(bookingItemEntity.trip.tripDate),
                style: Styles.font12GreyExtraBold(context),
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
