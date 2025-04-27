import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:travel_app/feature/trip_booking/presentation/view/widget/trip_booking_view_body.dart';

class TripBookingView extends StatelessWidget {
  const TripBookingView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 10.w),
          child: const TripBookingViewBody(),
        ),
      ),
    );
  }
}
