import 'package:flutter/material.dart';
import 'package:travel_app/feature/home/presentation/view/ride_view/presentation/view/passenger_directory/presentation/view/widget/location_input_card.dart';
import 'package:travel_app/feature/home/presentation/view/ride_view/presentation/view/passenger_directory/presentation/view/widget/ride_request_ui.dart';
import 'package:travel_app/feature/home/presentation/view/widget/ride_map_directory.dart';

class PassengerDirectoryViewBody extends StatelessWidget {
  const PassengerDirectoryViewBody({super.key});

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        const Positioned.fill(
          child: RideMapDirectory(),
        ),
        const Positioned(
          bottom: 0,
          left: 0,
          right: 0,
          child: RideRequestUI(),
        ),
        Positioned(
          top: 0,
          left: 0,
          right: 0,
          child: LocationInputCard(
            currentLocation:
                '5, شارع عبد الخالق ثروت, معروف, باب الشعرية, القاهرة, 11519, مصر',
            destinationController: TextEditingController(),
          ),
        ),
      ],
    );
  }
}
