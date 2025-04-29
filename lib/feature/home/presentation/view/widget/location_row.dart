import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:travel_app/core/theme/styles.dart';
import 'package:travel_app/feature/add_travel/data/model/trip_model.dart';

class LocationRow extends StatelessWidget {
  const LocationRow({
    super.key,
    required this.trip,
  });

  final TripModel trip;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        const Icon(Icons.location_on_outlined, size: 16),
        SizedBox(width: 4.w),
        Expanded(
          child: Text(
            '${trip.departureLocation} - ${trip.arrivalLocation}',
            style: Styles.font14GreyExtraBold,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          ),
        ),
      ],
    );
  }
}
