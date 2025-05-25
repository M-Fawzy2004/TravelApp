import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:travel_app/core/helper/spacing.dart';
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
        Icon(
          Icons.location_on_outlined,
          size: 16.sp,
        ),
        widthBox(5),
        Expanded(
          child: Text(
            '${trip.departureLocation} - ${trip.arrivalLocation}',
            style: Styles.font14GreyExtraBold(context),
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          ),
        ),
      ],
    );
  }
}
