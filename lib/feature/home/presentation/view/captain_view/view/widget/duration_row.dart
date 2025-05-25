import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:travel_app/core/theme/styles.dart';
import 'package:travel_app/feature/add_travel/data/model/trip_model.dart';

class DurationRow extends StatelessWidget {
  const DurationRow({
    super.key,
    required this.trip,
  });

  final TripModel trip;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        const Icon(Icons.time_to_leave, size: 16),
        SizedBox(width: 4.w),
        Text(
          trip.duration,
          style: Styles.font14GreyExtraBold(context),
        ),
      ],
    );
  }
}
