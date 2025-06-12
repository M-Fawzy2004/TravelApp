import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:travel_app/core/helper/spacing.dart';
import 'package:travel_app/core/theme/app_color.dart';
import 'package:travel_app/core/theme/styles.dart';
import 'package:travel_app/feature/add_travel/data/model/trip_model.dart';

class TravelCard extends StatelessWidget {
  const TravelCard({super.key, required this.trip});

  final TripModel trip;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(10.w),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            Colors.black.withOpacity(0.3),
            Colors.black.withOpacity(0.3),
            Colors.black.withOpacity(0.2),
          ],
          stops: const [0.0, 0.5, 1.0],
        ),
        borderRadius: BorderRadius.circular(25.r),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            trip.destinationName,
            style: Styles.font16BlackBold(context).copyWith(
              fontWeight: FontWeight.w900,
              fontSize: 18.sp,
              color: Colors.white,
              shadows: [
                Shadow(
                  color: Colors.black.withOpacity(0.7),
                  offset: const Offset(0, 2),
                  blurRadius: 4,
                ),
                Shadow(
                  color: Colors.black.withOpacity(0.3),
                  offset: const Offset(1, 1),
                  blurRadius: 8,
                ),
              ],
            ),
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
          ),
          heightBox(8),
          Row(
            children: [
              Container(
                padding: EdgeInsets.all(2.w),
                decoration: BoxDecoration(
                  color: AppColors.getPrimaryColor(context).withOpacity(0.1),
                  borderRadius: BorderRadius.circular(4.r),
                ),
                child: Icon(
                  Icons.location_on,
                  size: 14.sp,
                  color: AppColors.getPrimaryColor(context),
                ),
              ),
              widthBox(6),
              Expanded(
                child: Text(
                  trip.departureLocation,
                  style: Styles.font12GreyExtraBold(context).copyWith(
                    color: Colors.white.withOpacity(0.95),
                    fontSize: 13.sp,
                    fontWeight: FontWeight.w600,
                    shadows: [
                      Shadow(
                        color: Colors.black.withOpacity(0.6),
                        offset: const Offset(0, 1),
                        blurRadius: 3,
                      ),
                    ],
                  ),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
            ],
          ),
          heightBox(10),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                padding: EdgeInsets.symmetric(
                  horizontal: 12.w,
                  vertical: 6.h,
                ),
                decoration: BoxDecoration(
                  color: AppColors.getPrimaryColor(context),
                  borderRadius: BorderRadius.circular(15.r),
                ),
                child: Text(
                  '${trip.price} ج.م',
                  style: Styles.font16BlackBold(context).copyWith(
                    color: Colors.white,
                    fontWeight: FontWeight.w800,
                    fontSize: 15.sp,
                    shadows: [
                      Shadow(
                        color: Colors.black.withOpacity(0.5),
                        offset: const Offset(0, 1),
                        blurRadius: 3,
                      ),
                    ],
                  ),
                ),
              ),
              Container(
                padding: EdgeInsets.symmetric(
                  horizontal: 8.w,
                  vertical: 4.h,
                ),
                decoration: BoxDecoration(
                  color: AppColors.getBackgroundColor(context).withOpacity(0.2),
                  borderRadius: BorderRadius.circular(10.r),
                  border: Border.all(
                    color: Colors.white.withOpacity(0.3),
                    width: 1,
                  ),
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Icon(
                      Icons.calendar_today,
                      size: 13.sp,
                      color:
                          AppColors.getPrimaryColor(context).withOpacity(0.9),
                    ),
                    SizedBox(width: 4.w),
                    Text(
                      _formatDate(trip.tripDate),
                      style: Styles.font12GreyExtraBold(context).copyWith(
                        color: Colors.white.withOpacity(0.9),
                        fontSize: 12.sp,
                        fontWeight: FontWeight.w600,
                        shadows: [
                          Shadow(
                            color: Colors.black.withOpacity(0.5),
                            offset: const Offset(0, 1),
                            blurRadius: 2,
                          ),
                        ],
                      ),
                    ),
                  ],
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
