// ignore_for_file: depend_on_referenced_packages

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:travel_app/core/helper/app_router.dart';
import 'package:travel_app/core/helper/spacing.dart';
import 'package:travel_app/core/theme/app_color.dart';
import 'package:travel_app/core/theme/styles.dart';
import 'package:travel_app/core/widget/custom_button.dart';
import 'package:travel_app/feature/add_travel/data/model/trip_model.dart';
import 'package:travel_app/feature/home/presentation/view/widget/info_row.dart';

class CategoryTravel extends StatelessWidget {
  final TripModel trip;
  final int index;
  static const List<LinearGradient> _gradientsList = [
    LinearGradient(colors: [Color(0xFFE3F2FD), Color(0xFF90CAF9)]), // Blue
    LinearGradient(colors: [Color(0xFFFCE4EC), Color(0xFFF48FB1)]), // Pink
    LinearGradient(colors: [Color(0xFFE8F5E9), Color(0xFFA5D6A7)]), // Green
    LinearGradient(colors: [Color(0xFFFFF3E0), Color(0xFFFFCC80)]), // Orange
  ];

  const CategoryTravel({
    super.key,
    required this.trip,
    required this.index,
  });

  @override
  Widget build(BuildContext context) {
    final gradient =
        trip.gradientIndex >= 0 && trip.gradientIndex < _gradientsList.length
            ? _gradientsList[trip.gradientIndex]
            : _gradientsList[0];
    final tag = '${trip.id}_$index';
    return Hero(
      tag: tag,
      flightShuttleBuilder: (flightContext, animation, flightDirection,
          fromHeroContext, toHeroContext) {
        return flightDirection == HeroFlightDirection.pop
            ? fromHeroContext.widget
            : toHeroContext.widget;
      },
      child: Material(
        color: Colors.transparent,
        child: Container(
          decoration: BoxDecoration(
            gradient: gradient,
            borderRadius: BorderRadius.circular(15.r),
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
                  buttonText: 'تفاصيل الرحله',
                  textStyle: Styles.font16WhiteBold,
                  onPressed: () {
                    context.push(
                      AppRouter.detailsTrip,
                      extra: {
                        'trip': trip,
                        'index': index,
                      },
                    );
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

String getPeriodOfDay(TimeOfDay time) {
  return time.hour < 12 ? 'صباحًا' : 'مساءً';
}
