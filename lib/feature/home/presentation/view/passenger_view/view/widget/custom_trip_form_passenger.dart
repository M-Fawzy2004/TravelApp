import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:travel_app/feature/home/presentation/view/ride_view/presentation/view/passenger_directory/presentation/view/widget/ride_request_ui.dart';
import 'package:travel_app/feature/home/presentation/view/widget/ride_map_directory.dart';

class CustomTripFormPassenger extends StatelessWidget {
  final String type;

  const CustomTripFormPassenger({super.key, required this.type});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 0.7.sh,
      child: const Stack(
        children: [
          RideMapDirectory(),
          Positioned(
            bottom: 0,
            left: 0,
            right: 0,
            child: RideRequestUI(),
          ),
        ],
      ),
    );
  }
}
