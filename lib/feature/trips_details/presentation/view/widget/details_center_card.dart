import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:travel_app/core/theme/app_color.dart';
import 'package:travel_app/feature/add_travel/data/model/trip_model.dart';
import 'package:travel_app/feature/trips_details/presentation/view/widget/details_info_row.dart';

class DetailsCenterCard extends StatelessWidget {
  const DetailsCenterCard({super.key, required this.trip});

  final TripModel trip;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: AppColors.grey,
        borderRadius: BorderRadius.circular(20.r),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.2),
            blurRadius: 6,
            offset: Offset(0, 3),
          ),
        ],
      ),
      padding: EdgeInsets.all(16.w),
      child: Column(
        children: [
          DetailsInfoRow(
            icon: Icons.location_on,
            label: 'الاسم الاول / اسم الشركة',
            value: trip.creatorFirstName,
          ),
          _divider(),
          DetailsInfoRow(
            icon: Icons.location_on,
            label: 'الاسم التانى',
            value: trip.creatorLastName,
          ),
          _divider(),
          DetailsInfoRow(
            icon: Icons.location_on,
            label: 'رقم الهاتف',
            value: trip.creatorPhone,
          ),
          _divider(),
          DetailsInfoRow(
            icon: Icons.star,
            label: 'تقييم السائق',
            value: '4.8',
          ),
          _divider(),
          DetailsInfoRow(
            icon: FontAwesomeIcons.clock,
            label: 'مدة الرحلة المتوقعة',
            value: trip.duration,
          ),
          _divider(),
          DetailsInfoRow(
            icon: Icons.event_seat,
            label: 'عدد المقاعد المتوفرة',
            value: '${trip.availableSeats} مقعد',
          ),
          _divider(),
          DetailsInfoRow(
            icon: Icons.price_change,
            label: 'سعر الرحلة',
            value: '${trip.price} جنيه',
          ),
          _divider(),
          DetailsInfoRow(
            icon: Icons.directions_bus,
            label: 'نوع الرحلة',
            value: trip.getTripTypeArabicText(),
          ),
        ],
      ),
    );
  }

  Widget _divider() => Padding(
        padding: EdgeInsets.symmetric(vertical: 10.h),
        child: Divider(color: Colors.grey.shade300, thickness: 1),
      );

  String formatPhoneNumber(String phoneNumber) {
    if (phoneNumber.startsWith('+20')) {
      return phoneNumber.substring(3);
    }
    return phoneNumber;
  }
}
