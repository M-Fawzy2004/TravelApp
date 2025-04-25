import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:travel_app/core/helper/spacing.dart';
import 'package:travel_app/core/theme/styles.dart';
import 'package:travel_app/core/widget/custom_button.dart';
import 'package:travel_app/feature/add_travel/data/model/trip_model.dart';
import 'package:travel_app/feature/home/presentation/view/widget/info_row.dart';

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
      padding: EdgeInsets.all(16.w),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Center(
            child: Text(
              trip.destinationName,
              style: Styles.font20ExtraBlackBold,
              textAlign: TextAlign.center,
            ),
          ),
          heightBox(12),
          Row(
            children: [
              Expanded(
                child: InfoRow(
                  icon: Icons.location_on,
                  label: 'مكان التحرك',
                  value: trip.departureLocation,
                ),
              ),
              Expanded(
                child: InfoRow(
                  icon: Icons.flag,
                  label: 'مكان الوصول',
                  value: trip.arrivalLocation,
                ),
              ),
            ],
          ),
          InfoRow(
            icon: Icons.date_range,
            label: 'تاريخ الرحله',
            value:
                '${trip.tripDate.day} / ${trip.tripDate.month} / ${trip.tripDate.year}',
          ),
          InfoRow(
            icon: Icons.access_time,
            label: 'توقيت الرحله',
            value:
                '${trip.tripTime.hour}:${trip.tripTime.minute.toString().padLeft(2, '0')} ${getPeriodOfDay(trip.tripTime)}',
          ),
          heightBox(20),
          CustomButton(
            buttonText: 'عرض التفاصيل',
            onPressed: onPressed,
          ),
        ],
      ),
    );
  }
}

String getPeriodOfDay(TimeOfDay time) {
  return time.hour < 12 ? 'صباحًا' : 'مساءً';
}
