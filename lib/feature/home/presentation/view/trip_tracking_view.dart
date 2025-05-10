import 'package:flutter/material.dart';
import 'package:travel_app/feature/home/presentation/view/widget/trip_tracking_view_body.dart';

class TripTrackingView extends StatelessWidget {
  const TripTrackingView({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: TripTrackingViewBody(),
    );
  }
}
