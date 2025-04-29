import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
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
    return Row(
      children: [
        const Icon(Icons.calendar_today_outlined, size: 16),
        SizedBox(width: 4.w),
        Text(
          '${_formatDate(trip.tripDate)} ${_formatTime(trip.tripTime)}',
          style: Styles.font14GreyExtraBold,
        ),
      ],
    );
  }
}

String _formatDate(DateTime date) {
  return '${date.day}/${date.month}/${date.year}';
}

String _formatTime(TimeOfDay time) {
  return '${time.hour}:${time.minute.toString().padLeft(2, '0')}';
}
