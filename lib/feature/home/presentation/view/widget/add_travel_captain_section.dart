import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:travel_app/core/helper/spacing.dart';
import 'package:travel_app/core/theme/app_color.dart';
import 'package:travel_app/core/theme/styles.dart';
import 'package:travel_app/feature/add_travel/data/model/trip_model.dart';
import 'package:travel_app/core/widget/details_info_row.dart';

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
          Center(
            child: Text(
              trip.destinationName,
              style: Styles.font20ExtraBlackBold,
              textAlign: TextAlign.center,
            ),
          ),
          heightBox(20),
          DetailsInfoRow(
            icon: FontAwesomeIcons.locationArrow,
            label: 'مكان التحرك',
            value: trip.departureLocation,
          ),
          _divider(),
          DetailsInfoRow(
            icon: FontAwesomeIcons.flag,
            label: 'مكان الوصول',
            value: trip.arrivalLocation,
          ),
          _divider(),
          DetailsInfoRow(
            icon: FontAwesomeIcons.timesRectangle,
            label: 'تاريخ الرحلة',
            value: trip.tripDate.toString().split(' ')[0],
          ),
          _divider(),
          DetailsInfoRow(
            icon: FontAwesomeIcons.flag,
            label: 'توقيت الرحلة',
            value:
                '${trip.tripTime.hour}:${trip.tripTime.minute.toString().padLeft(2, '0')} ${getPeriodOfDay(trip.tripTime)}',
          ),
          _divider(),
          DetailsInfoRow(
            icon: FontAwesomeIcons.flag,
            label: 'سعر الرحله',
            value: '${trip.price} جنيه',
          ),
        ],
      ),
    );
  }
}

Widget _divider() => Padding(
      padding: EdgeInsets.symmetric(vertical: 1.h),
      child: const Divider(color: AppColors.grey, thickness: 2),
    );

String getPeriodOfDay(TimeOfDay time) {
  return time.hour < 12 ? 'صباحًا' : 'مساءً';
}
