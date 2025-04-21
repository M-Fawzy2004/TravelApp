import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:travel_app/core/theme/app_color.dart';
import 'package:travel_app/feature/add_travel/data/model/trip_model.dart';
import 'package:travel_app/feature/home/presentation/view/widget/info_row.dart';

class DetailsCenterCard extends StatelessWidget {
  const DetailsCenterCard({
    super.key,
    required this.trip,
  });

  final TripModel trip;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(15.r),
        color: AppColors.grey,
        boxShadow: [
          BoxShadow(
            color: AppColors.black.withOpacity(.2),
            blurRadius: 6,
            spreadRadius: 0,
            offset: Offset(0, 1),
          ),
        ],
      ),
      child: Padding(
        padding: EdgeInsets.all(16.w),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            InfoRow(
              icon: FontAwesomeIcons.mapMarkerAlt,
              label: 'مدة الرحله المتوقعه',
              value: trip.duration,
            ),
            InfoRow(
              icon: Icons.flag,
              label: 'عدد المقاعد المتوفره',
              value: '${trip.availableSeats} مقعد',
            ),
            InfoRow(
              icon: Icons.date_range,
              label: 'سعر الرحله',
              value: '${trip.price}جنيه',
            ),
            InfoRow(
              icon: Icons.merge_type,
              label: 'نوع الرحله',
              value: trip.getTripTypeArabicText(),
            ),
          ],
        ),
      ),
    );
  }
}
