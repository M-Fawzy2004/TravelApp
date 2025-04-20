import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:travel_app/feature/add_travel/data/model/trip_model.dart';
import 'package:travel_app/feature/home/presentation/view/widget/details_trip_view_body.dart';

class DetailsTripView extends StatelessWidget {
  const DetailsTripView({super.key, required this.trip});

  final TripModel trip;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 16.w),
          child: DetailsTripViewBody(
            trip: trip,
          ),
        ),
      ),
    );
  }
}
