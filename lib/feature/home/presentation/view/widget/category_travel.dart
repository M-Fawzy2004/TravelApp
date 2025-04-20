import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';
import 'package:travel_app/core/helper/spacing.dart';
import 'package:travel_app/core/theme/app_color.dart';
import 'package:travel_app/core/theme/styles.dart';
import 'package:travel_app/feature/add_travel/data/model/trip_model.dart';

class CategoryTravel extends StatelessWidget {
  final TripModel trip;

  // Define the same gradient list as in AddTravelForm
  static const List<LinearGradient> _gradientsList = [
    LinearGradient(colors: [Color(0xFFE3F2FD), Color(0xFF90CAF9)]), // Blue
    LinearGradient(colors: [Color(0xFFFCE4EC), Color(0xFFF48FB1)]), // Pink
    LinearGradient(colors: [Color(0xFFE8F5E9), Color(0xFFA5D6A7)]), // Green
    LinearGradient(colors: [Color(0xFFFFF3E0), Color(0xFFFFCC80)]), // Orange
  ];

  const CategoryTravel({super.key, required this.trip});

  String _formatTripType(TripType type) {
    switch (type) {
      case TripType.delivery:
        return 'توصيل';
      case TripType.cargoShipping:
        return 'شحن';
      case TripType.specialTrip:
        return 'رحلة خاصة';
    }
  }

  String _getWeekdayInArabic(DateTime date) {
    switch (date.weekday) {
      case 1:
        return 'الاثنين';
      case 2:
        return 'الثلاثاء';
      case 3:
        return 'الاربعاء';
      case 4:
        return 'الخميس';
      case 5:
        return 'الجمعة';
      case 6:
        return 'السبت';
      case 7:
        return 'الاحد';
      default:
        return 'الاحد';
    }
  }

  @override
  Widget build(BuildContext context) {
    // Get the gradient from the index, or use the first one as default
    final gradient =
        trip.gradientIndex >= 0 && trip.gradientIndex < _gradientsList.length
            ? _gradientsList[trip.gradientIndex]
            : _gradientsList[0];

    return Container(
      height: 150.h,
      decoration: BoxDecoration(
        gradient: gradient,
        borderRadius: BorderRadius.circular(15.r),
        border: Border.all(
          width: 4.w,
          color: AppColors.primaryColor,
        ),
      ),
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 10.h),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              '${_formatTripType(trip.tripType)}: ${trip.departureLocation} الى ${trip.arrivalLocation}',
              style: Styles.font16BlackBold,
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
            ),
            heightBox(10),
            Text(
              DateFormat('yyyy/MM/dd').format(trip.tripDate),
              style: Styles.font14DarkGreyBold,
            ),
            heightBox(5),
            Text(
              'يوم الرحلة: ${_getWeekdayInArabic(trip.tripDate)}',
              style: Styles.font14DarkGreyBold.copyWith(
                fontWeight: FontWeight.w900,
              ),
            ),
            heightBox(5),
            Text(
              'عدد المقاعد: ${trip.availableSeats}',
              style: Styles.font14DarkGreyBold.copyWith(
                fontWeight: FontWeight.w900,
              ),
            ),
            heightBox(10),
            Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(10.r),
                  bottomRight: Radius.circular(10.r),
                ),
                color: AppColors.grey.withOpacity(0.7),
              ),
              child: Text(
                'السعر: ${trip.price} جنيه',
                style: Styles.font14DarkGreyBold,
              ),
            ),
            Spacer(),
            Container(
              padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 7.h),
              decoration: BoxDecoration(
                color: AppColors.primaryColor,
                borderRadius: BorderRadius.circular(10.r),
              ),
              child: Center(
                child: Text(
                  'أنقر للتفاصيل',
                  style: Styles.font14DarkGreyBold,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
