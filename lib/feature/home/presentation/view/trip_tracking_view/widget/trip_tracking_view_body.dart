import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:travel_app/core/helper/spacing.dart';
import 'package:travel_app/core/theme/styles.dart';
import 'package:travel_app/core/widget/icon_back.dart';
import 'package:travel_app/feature/home/presentation/view/trip_tracking_view/widget/trip_action_button.dart';
import 'package:travel_app/feature/home/presentation/view/trip_tracking_view/widget/trip_details_card.dart';
import 'package:travel_app/feature/home/presentation/view/trip_tracking_view/widget/trip_status_card.dart';
import 'package:travel_app/feature/home/presentation/view/trip_tracking_view/widget/details_map_section.dart';

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
      body: Padding(
        padding: EdgeInsets.all(16.w),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                const IconBack(),
                const Spacer(),
                Expanded(
                  flex: 2,
                  child: Text(
                    'تتبع الرحلة',
                    style: Styles.font20BlackBold,
                  ),
                ),
              ],
            ),
            heightBox(10),
            const TripStatusCard(),
            heightBox(10),
            const TripDetailsCard(),
            heightBox(10),
            const DetailsMapSection(),
            heightBox(16),
            const TripActionButton(),
          ],
        ),
      ),
    );
  }
}
