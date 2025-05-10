import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:travel_app/core/helper/spacing.dart';
import 'package:travel_app/feature/home/presentation/view/widget/captain_action_button.dart';
import 'package:travel_app/feature/home/presentation/view/widget/captain_trip_details_card.dart';
import 'package:travel_app/feature/home/presentation/view/widget/captain_trip_status_card.dart';
import 'package:travel_app/feature/home/presentation/view/widget/details_map_section.dart';

class TripTrackingViewBody extends StatefulWidget {

  const TripTrackingViewBody({
    super.key,
  });

  @override
  State<TripTrackingViewBody> createState() => _TripTrackingViewBodyState();
}

class _TripTrackingViewBodyState extends State<TripTrackingViewBody> {
  bool isTripStarted = false;
  bool isTripEnded = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('متابعة الرحلة'),
        centerTitle: true,
      ),
      body: Padding(
        padding: EdgeInsets.all(16.w),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const CatpainTripStatusCard(),
            heightBox(16),
            const CaptainTripDetailsCard(),
            heightBox(16),
            const DetailsMapSection(),
            heightBox(16),
            const CaptainActionButton(),
          ],
        ),
      ),
    );
  }
}
