// ignore_for_file: depend_on_referenced_packages
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:travel_app/core/helper/spacing.dart';
import 'package:travel_app/core/theme/app_color.dart';
import 'package:travel_app/core/theme/styles.dart';
import 'package:travel_app/feature/add_travel/data/model/trip_model.dart';
import 'package:intl/intl.dart';

class TripDetailsColumn extends StatelessWidget {
  const TripDetailsColumn({
    super.key,
    required this.trip,
  });

  final TripModel trip;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            trip.tripType == TripType.specialTrip ? 'رحلة خاصة' : 'شحن أغراض',
            style: Styles.font16BlackBold(context),
          ),
          heightBox(4),
          Text(
            trip.destinationName,
            style: Styles.font14GreyExtraBold(context),
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          ),
          heightBox(8),
          Row(
            children: [
              Icon(
                Icons.calendar_today,
                size: 14.sp,
                color: AppColors.getPrimaryColor(context),
              ),
              widthBox(4),
              Text(
                DateFormat('yyyy-MM-dd').format(trip.tripDate),
                style: Styles.font12GreyExtraBold(context),
              ),
            ],
          ),
          heightBox(4),
          Row(
            children: [
              Icon(
                Icons.attach_money,
                size: 14.sp,
                color: Colors.green,
              ),
              Text(
                '${trip.price} جنيه',
                style: Styles.font12GreyExtraBold(context).copyWith(
                  color: Colors.green,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
