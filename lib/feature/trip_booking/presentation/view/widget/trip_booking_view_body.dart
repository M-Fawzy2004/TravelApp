import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:travel_app/core/helper/get_user.dart';
import 'package:travel_app/core/helper/spacing.dart';
import 'package:travel_app/feature/auth/domain/entity/user_entity.dart';
import 'package:travel_app/feature/trip_booking/presentation/view/widget/action_slider_button.dart';
import 'package:travel_app/feature/trip_booking/presentation/view/widget/trip_booking_header.dart';
import 'package:travel_app/feature/trip_booking/presentation/view/widget/trip_summary_list_view.dart';

class TripBookingViewBody extends StatelessWidget {
  const TripBookingViewBody({super.key});

  @override
  Widget build(BuildContext context) {
    final role = getUser()?.role;

    return Scaffold(
      body: Stack(
        children: [
          SizedBox(
            height: MediaQuery.of(context).size.height,
            child: Column(
              children: [
                heightBox(10),
                if (role == UserRole.passenger)
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: TripBookingHeader(),
                  ),
                Expanded(
                  child: TripSummaryListView(),
                ),
              ],
            ),
          ),
          if (role == UserRole.passenger)
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
