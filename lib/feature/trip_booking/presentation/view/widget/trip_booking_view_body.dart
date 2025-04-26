import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:travel_app/core/helper/spacing.dart';
import 'package:travel_app/feature/trip_booking/presentation/view/widget/action_slider_button.dart';
import 'package:travel_app/feature/trip_booking/presentation/view/widget/trip_booking_header.dart';
import 'package:travel_app/feature/trip_booking/presentation/view/widget/trip_summary_card.dart';

class TripBookingViewBody extends StatelessWidget {
  const TripBookingViewBody({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          SizedBox(
            height: MediaQuery.of(context).size.height,
            child: SingleChildScrollView(
              dragStartBehavior: DragStartBehavior.down,
              padding: EdgeInsets.only(bottom: 150.h),
              physics: const BouncingScrollPhysics(),
              child: Column(
                children: [
                  heightBox(10),
                  TripBookingHeader(),
                  const TripSummaryCard(),
                  const TripSummaryCard(),
                  const TripSummaryCard(),
                ],
              ),
            ),
          ),
          Positioned(
            right: 0,
            left: 0,
            bottom: 90.h,
            child: ActionSliderButton(),
          ),
        ],
      ),
    );
  }
}
