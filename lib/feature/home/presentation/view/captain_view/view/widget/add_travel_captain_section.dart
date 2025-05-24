import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:travel_app/core/helper/spacing.dart';
import 'package:travel_app/core/theme/app_color.dart';
import 'package:travel_app/core/theme/styles.dart';
import 'package:travel_app/feature/add_travel/data/model/trip_model.dart';

class AddTravelCaptainSection extends StatelessWidget {
  const AddTravelCaptainSection({
    super.key,
    required this.trip,
  });

  final TripModel trip;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 5.h),
      child: Container(
        width: double.infinity,
        height: 200.h,
        decoration: BoxDecoration(
          border: Border.all(color: AppColors.white, width: 3.w),
          borderRadius: BorderRadius.circular(10.r),
          boxShadow: [
            BoxShadow(
              color: AppColors.black.withOpacity(0.2),
              blurRadius: 4,
              spreadRadius: 1,
            ),
          ],
        ),
        child: Stack(
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(10.r),
              child: Image.network(
                trip.imageUrl,
                width: double.infinity,
                height: double.infinity,
                fit: BoxFit.cover,
                loadingBuilder: (context, child, loadingProgress) {
                  if (loadingProgress == null) return child;
                  return Center(
                    child: CircularProgressIndicator(
                      value: loadingProgress.expectedTotalBytes != null
                          ? loadingProgress.cumulativeBytesLoaded /
                              loadingProgress.expectedTotalBytes!
                          : null,
                    ),
                  );
                },
                errorBuilder: (context, error, stackTrace) {
                  return Container(
                    color: Colors.grey[300],
                    child: Icon(
                      Icons.image_not_supported,
                      size: 50.sp,
                      color: Colors.grey[600],
                    ),
                  );
                },
              ),
            ),
            Positioned(
              top: 8.h,
              right: 8.w,
              child: Container(
                padding: EdgeInsets.symmetric(
                  horizontal: 12.w,
                  vertical: 4.h,
                ),
                decoration: BoxDecoration(
                  color: _getTripTypeColor(trip.tripType).withOpacity(0.8),
                  borderRadius: BorderRadius.circular(5.r),
                ),
                child: Text(
                  _getTripTypeText(trip.tripType),
                  style: Styles.font12GreyExtraBold.copyWith(
                    color: AppColors.grey,
                  ),
                ),
              ),
            ),
            Positioned(
              bottom: 5,
              left: 5,
              right: 5,
              child: Container(
                padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 6.h),
                decoration: BoxDecoration(
                  color: Colors.white60,
                  borderRadius: BorderRadius.circular(10.r),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      trip.destinationName,
                      style: Styles.font16BlackBold.copyWith(
                        fontWeight: FontWeight.w900,
                      ),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                    heightBox(5),
                    Row(
                      children: [
                        Icon(
                          Icons.location_on,
                          size: 15.sp,
                        ),
                        widthBox(5),
                        Expanded(
                          child: Text(
                            trip.departureLocation,
                            style: Styles.font12GreyExtraBold.copyWith(
                              color: AppColors.black,
                            ),
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                        Icon(
                          Icons.star,
                          color: Colors.amber,
                          size: 15.sp,
                        ),
                        widthBox(5),
                        Text(
                          '5.0',
                          style: Styles.font12GreyExtraBold.copyWith(
                            color: AppColors.black,
                          ),
                        ),
                      ],
                    ),
                    heightBox(4),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          '${trip.price} ج.م',
                          style: Styles.font16BlackBold.copyWith(
                            color: AppColors.primaryColor,
                            fontWeight: FontWeight.w900,
                          ),
                        ),
                        Text(
                          _formatDate(trip.tripDate),
                          style: Styles.font12GreyExtraBold.copyWith(
                            color: AppColors.black,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

String getPeriodOfDay(TimeOfDay time) {
  return time.hour < 12 ? 'صباحًا' : 'مساءً';
}

Color _getTripTypeColor(TripType type) {
  switch (type) {
    case TripType.specialTrip:
      return Colors.blue;
    case TripType.cargoShipping:
      return Colors.orange;
  }
}

String _getTripTypeText(TripType type) {
  switch (type) {
    case TripType.specialTrip:
      return 'رحلة خاصة';
    case TripType.cargoShipping:
      return 'شحن بضائع';
  }
}

String _formatDate(DateTime date) {
  return '${date.day}/${date.month}/${date.year}';
}
