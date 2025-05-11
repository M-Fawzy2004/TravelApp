import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:travel_app/feature/home/presentation/view/captain_view/view/widget/add_travel_captain.dart';
import 'package:travel_app/feature/home/presentation/view/widget/no_trips.dart';

class CustomTripGrid extends StatelessWidget {
  const CustomTripGrid({
    super.key,
    required this.trips,
    this.index,
  });

  final List trips;
  final int? index;

  @override
  Widget build(BuildContext context) {
    if (trips.isEmpty) {
      return const NoTrips();
    }
    return SliverPadding(
      padding: EdgeInsets.only(bottom: 80.h),
      sliver: SliverGrid(
        delegate: SliverChildBuilderDelegate(
          (context, index) {
            final trip = trips[index];
            return Padding(
              padding: EdgeInsets.symmetric(vertical: 4.w),
              child: AddTravelCaptain(
                trip: trip,
                index: index,
              ),
            );
          },
          childCount: trips.length,
        ),
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 1,
          crossAxisSpacing: 5.w,
          mainAxisExtent: 210.h,
        ),
      ),
    );
  }
}
