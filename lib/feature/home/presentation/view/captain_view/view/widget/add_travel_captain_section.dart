import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:travel_app/core/theme/app_color.dart';
import 'package:travel_app/core/theme/styles.dart';
import 'package:travel_app/feature/add_travel/data/model/trip_model.dart';
import 'package:travel_app/feature/home/presentation/view/captain_view/view/widget/travel_card.dart';
import 'package:travel_app/feature/home/presentation/view/captain_view/view/widget/travel_image.dart';

class AddTravelCaptainSection extends StatelessWidget {
  const AddTravelCaptainSection({
    super.key,
    required this.trip,
  });

  final TripModel trip;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        TravelImage(trip: trip),
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
              borderRadius: BorderRadius.circular(25.r),
            ),
            child: Text(
              _getTripTypeText(trip.tripType),
              style: Styles.font12GreyExtraBold(context).copyWith(
                color: AppColors.getBackgroundColor(context),
              ),
            ),
          ),
        ),
        Positioned(
          bottom: 5,
          left: 5,
          right: 5,
          child: TravelCard(trip: trip),
        ),
      ],
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
    case TripType.privateDelivery:
      return Colors.orange;
  }
}

String _getTripTypeText(TripType type) {
  switch (type) {
    case TripType.specialTrip:
      return 'رحلة خاصة';
    case TripType.privateDelivery:
      return 'توصيل خاص';
  }
}
