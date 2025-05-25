import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:travel_app/feature/home/presentation/view/captain_view/view/widget/add_travel_captain.dart';
import 'package:travel_app/feature/home/presentation/view/widget/no_trips.dart';

class CustomTripGrid extends StatelessWidget {
  const CustomTripGrid({super.key, required this.trips});

  final List trips;

  @override
  Widget build(BuildContext context) {
    if (trips.isEmpty) {
      return const NoTrips();
    }
    return SliverPadding(
      padding: EdgeInsets.only(bottom: 80.h),
      sliver: SliverGrid(
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 1,
          mainAxisExtent: 220.h,
        ),
        delegate: SliverChildBuilderDelegate(
          (context, index) {
            final trip = trips[index];
            return AddTravelCaptain(
              trip: trip,
            );
          },
          childCount: trips.length,
        ),
      ),
    );
  }
}
