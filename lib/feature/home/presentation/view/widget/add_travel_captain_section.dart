import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:travel_app/core/helper/spacing.dart';
import 'package:travel_app/core/theme/styles.dart';
import 'package:travel_app/feature/add_travel/data/model/trip_model.dart';
import 'package:travel_app/feature/home/presentation/view/widget/date_time_row.dart';
import 'package:travel_app/feature/home/presentation/view/widget/duration_row.dart';
import 'package:travel_app/feature/home/presentation/view/widget/location_row.dart';
import 'package:travel_app/feature/home/presentation/view/widget/price_container.dart';

class AddTravelCaptainSection extends StatelessWidget {
  const AddTravelCaptainSection({
    super.key,
    required this.trip,
    this.onPressed,
  });

  final TripModel trip;
  final void Function()? onPressed;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 5.h),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          heightBox(5),
          Container(
            padding: EdgeInsets.symmetric(vertical: 5.h),
            decoration: BoxDecoration(
              color: _getTripTypeColor(trip.tripType),
              borderRadius: BorderRadius.circular(10.r),
            ),
            width: double.infinity,
            child: Text(
              trip.getTripTypeArabicText(),
              style: Styles.font14DarkGreyExtraBold,
              textAlign: TextAlign.center,
            ),
          ),
          Padding(
            padding: EdgeInsets.all(8.r),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  trip.destinationName,
                  style: Styles.font16BlackBold,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
                heightBox(4),
                LocationRow(trip: trip),
                heightBox(4),
                DateTimeRow(trip: trip),
                heightBox(4),
                DurationRow(trip: trip),
                heightBox(20),
                PriceContainer(trip: trip),
              ],
            ),
          ),
        ],
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
    case TripType.delivery:
      return Colors.green;
    case TripType.cargoShipping:
      return Colors.orange;
  }
}
