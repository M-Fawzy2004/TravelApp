import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:travel_app/core/helper/spacing.dart';
import 'package:travel_app/core/theme/app_color.dart';
import 'package:travel_app/core/widget/details_info_row.dart';
import 'package:travel_app/feature/add_travel/data/model/trip_model.dart';

class DetailsCenterCard extends StatelessWidget {
  const DetailsCenterCard({super.key, required this.trip});

  final TripModel trip;

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(25.r),
      child: Container(
        decoration: BoxDecoration(
          color: AppColors.getBackgroundColor(context).withOpacity(0.2),
          borderRadius: BorderRadius.circular(25.r),
          border: Border.all(
            color: AppColors.getSurfaceColor(context),
            width: 1.5,
          ),
        ),
        padding: EdgeInsets.all(20.w),
        child: Column(
          children: [
            Container(
              width: double.infinity,
              padding: EdgeInsets.symmetric(vertical: 12.h, horizontal: 16.w),
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [
                    Colors.teal.withOpacity(0.3),
                    Colors.cyan.withOpacity(0.3),
                  ],
                ),
                borderRadius: BorderRadius.circular(25.r),
              ),
              child: Text(
                'معلومات السائق والرحلة',
                style: TextStyle(
                  fontSize: 18.sp,
                  fontWeight: FontWeight.bold,
                  color: AppColors.getTextColor(context),
                ),
                textAlign: TextAlign.center,
              ),
            ),
            heightBox(20),
            DetailsInfoRow(
              icon: Icons.person,
              label: 'الاسم الاول / اسم الشركة',
              value: trip.creatorFirstName,
              color: Colors.indigo,
            ),
            _glassDivider(context),
            DetailsInfoRow(
              icon: Icons.person_outline,
              label: 'الاسم التانى',
              value: trip.creatorLastName,
              color: Colors.deepPurple,
            ),
            _glassDivider(context),
            const DetailsInfoRow(
              icon: Icons.star,
              label: 'تقييم السائق',
              value: '4.8',
              color: Colors.amber,
            ),
            _glassDivider(context),
            DetailsInfoRow(
              icon: FontAwesomeIcons.clock,
              label: 'مدة الرحلة المتوقعة',
              value: trip.duration,
              color: Colors.teal,
            ),
            _glassDivider(context),
            DetailsInfoRow(
              icon: Icons.event_seat,
              label: 'عدد المقاعد المتوفرة',
              value: '${trip.availableSeats} مقعد',
              color: Colors.green,
            ),
            _glassDivider(context),
            DetailsInfoRow(
              icon: Icons.price_change,
              label: 'سعر الرحلة',
              value: '${trip.price} جنيه',
              color: Colors.red,
            ),
            _glassDivider(context),
            DetailsInfoRow(
              icon: Icons.directions_bus,
              label: 'نوع الرحلة',
              value: trip.getTripTypeArabicText(),
              color: Colors.blue,
            ),
          ],
        ),
      ),
    );
  }

  Widget _glassDivider(BuildContext context) => Padding(
        padding: EdgeInsets.symmetric(vertical: 8.h),
        child: Container(
          height: 1,
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [
                Colors.transparent,
                AppColors.getPrimaryColor(context).withOpacity(0.3),
                Colors.transparent,
              ],
            ),
          ),
        ),
      );

  String formatPhoneNumber(String phoneNumber) {
    if (phoneNumber.startsWith('+20')) {
      return phoneNumber.substring(3);
    }
    return phoneNumber;
  }
}
