// ignore_for_file: depend_on_referenced_packages

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:travel_app/core/helper/extension.dart';
import 'package:travel_app/core/theme/app_color.dart';
import 'package:travel_app/feature/add_travel/data/model/trip_model.dart';
import 'package:travel_app/feature/home/presentation/view/captain_view/view/widget/add_travel_captain_section.dart';
import 'package:travel_app/feature/trips_details/presentation/view/details_trip_view.dart';

class AddTravelCaptain extends StatelessWidget {
  final TripModel trip;

  const AddTravelCaptain({super.key, required this.trip});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        context.navigateWithSlideTransition(
          DetailsTripView(
            trip: trip,
          ),
        );
      },
      child: Container(
        decoration: BoxDecoration(
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.4),
              spreadRadius: 1,
              blurRadius: 1,
              offset: const Offset(0, 1),
            ),
          ],
          color: AppColors.white,
          borderRadius: BorderRadius.circular(10.r),
        ),
        child: AddTravelCaptainSection(
          trip: trip,
        ),
      ),
    );
  }
}
