import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:travel_app/core/helper/spacing.dart';
import 'package:travel_app/core/theme/app_color.dart';
import 'package:travel_app/core/theme/styles.dart';
import 'package:travel_app/feature/add_travel/data/model/trip_model.dart';

class TravelCard extends StatelessWidget {
  const TravelCard({
    super.key,
    required this.trip,
  });

  final TripModel trip;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 6.h),
      decoration: BoxDecoration(
        color: AppColors.getBackgroundColor(context).withOpacity(0.5),
        borderRadius: BorderRadius.circular(10.r),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            trip.destinationName,
            style: Styles.font16BlackBold(context).copyWith(
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
                  style: Styles.font12GreyExtraBold(context).copyWith(
                    color: AppColors.getTextColor(context),
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
                style: Styles.font12GreyExtraBold(context).copyWith(
                  color: AppColors.getTextColor(context),
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
                style: Styles.font16BlackBold(context).copyWith(
                  color: AppColors.getPrimaryColor(context),
                  fontWeight: FontWeight.w900,
                ),
              ),
              Text(
                _formatDate(trip.tripDate),
                style: Styles.font12GreyExtraBold(context).copyWith(
                  color: AppColors.getTextColor(context),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  String _formatDate(DateTime date) {
    return '${date.day}/${date.month}/${date.year}';
  }
}
