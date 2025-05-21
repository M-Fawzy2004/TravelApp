import 'package:flutter/material.dart';
import 'package:travel_app/core/helper/spacing.dart';
import 'package:travel_app/core/theme/styles.dart';
import 'package:travel_app/feature/add_travel/data/model/trip_model.dart';

class DateTimeRow extends StatelessWidget {
  const DateTimeRow({
    super.key,
    required this.trip,
  });

  final TripModel trip;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          children: [
            const Icon(Icons.calendar_today_outlined, size: 16),
            widthBox(4),
            Text(
              _formatDate(trip.tripDate),
              style: Styles.font14GreyExtraBold,
            ),
          ],
        ),
      ],
    );
  }
}

String _formatDate(DateTime date) {
  return '${date.day}/${date.month}/${date.year}';
}
