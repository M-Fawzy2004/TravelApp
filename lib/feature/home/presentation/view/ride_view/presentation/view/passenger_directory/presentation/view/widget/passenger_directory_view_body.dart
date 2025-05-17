import 'package:flutter/material.dart';
import 'package:travel_app/feature/home/presentation/view/ride_view/presentation/view/passenger_directory/presentation/view/widget/ride_request_ui.dart';
import 'package:travel_app/feature/home/presentation/view/widget/ride_map_directory.dart';

class PassengerDirectoryViewBody extends StatelessWidget {
  const PassengerDirectoryViewBody({super.key});

  @override
  Widget build(BuildContext context) {
    return const Stack(
      children: [
        Positioned.fill(
          child: RideMapDirectory(),
        ),
        Positioned(
          bottom: 0,
          left: 0,
          right: 0,
          child: RideRequestUI(),
        ),
      ],
    );
  }
}
