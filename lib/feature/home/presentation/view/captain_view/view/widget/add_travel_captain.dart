// ignore_for_file: depend_on_referenced_packages

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:travel_app/core/helper/extension.dart';
import 'package:travel_app/feature/add_travel/data/model/trip_model.dart';
import 'package:travel_app/feature/home/presentation/view/captain_view/view/widget/add_travel_captain_section.dart';
import 'package:travel_app/feature/trips_details/presentation/view/details_trip_view.dart';

class AddTravelCaptain extends StatelessWidget {
  final TripModel trip;
  final int index;
  static const List<LinearGradient> _gradientsList = [
    LinearGradient(colors: [Color(0xFFE3F2FD), Color(0xFF90CAF9)]),
    LinearGradient(colors: [Color(0xFFFCE4EC), Color(0xFFF48FB1)]),
    LinearGradient(colors: [Color(0xFFE8F5E9), Color(0xFFA5D6A7)]),
    LinearGradient(colors: [Color(0xFFFFF3E0), Color(0xFFFFCC80)]),
  ];

  const AddTravelCaptain({
    super.key,
    required this.trip,
    required this.index,
  });

  @override
  Widget build(BuildContext context) {
    final gradient =
        trip.gradientIndex >= 0 && trip.gradientIndex < _gradientsList.length
            ? _gradientsList[trip.gradientIndex]
            : _gradientsList[0];

    // Instead of using OpenContainer for a side slide animation,
    // we'll use a GestureDetector with Navigator.push
    return GestureDetector(
      onTap: () {
        context.navigateWithSlideTransition(
          DetailsTripView(
            trip: trip,
            index: index,
          ),
        );
      },
      child: Container(
        decoration: BoxDecoration(
          gradient: gradient,
          borderRadius: BorderRadius.circular(10.r),
        ),
        child: AddTravelCaptainSection(
          trip: trip,
          onPressed: () {},
        ),
      ),
    );
  }
}

// class AddTravelCaptainWithOpenContainer extends StatelessWidget {
//   final TripModel trip;
//   final int index;
//   static const List<LinearGradient> _gradientsList = [
//     LinearGradient(colors: [Color(0xFFE3F2FD), Color(0xFF90CAF9)]),
//     LinearGradient(colors: [Color(0xFFFCE4EC), Color(0xFFF48FB1)]),
//     LinearGradient(colors: [Color(0xFFE8F5E9), Color(0xFFA5D6A7)]),
//     LinearGradient(colors: [Color(0xFFFFF3E0), Color(0xFFFFCC80)]),
//   ];

//   const AddTravelCaptainWithOpenContainer({
//     super.key,
//     required this.trip,
//     required this.index,
//   });

//   @override
//   Widget build(BuildContext context) {
//     final gradient =
//         trip.gradientIndex >= 0 && trip.gradientIndex < _gradientsList.length
//             ? _gradientsList[trip.gradientIndex]
//             : _gradientsList[0];
//     return OpenContainer(
//       transitionType: ContainerTransitionType.fadeThrough,
//       transitionDuration: const Duration(milliseconds: 500),
//       openBuilder: (context, _) {
//         context.navigateWithSlideTransition(
//           DetailsTripView(
//             trip: trip,
//             index: index,
//           ),
//         );
//         return Container(color: Colors.transparent);
//       },
//       closedElevation: 0,
//       closedShape: RoundedRectangleBorder(
//         borderRadius: BorderRadius.circular(10.r),
//       ),
//       closedColor: Colors.transparent,
//       closedBuilder: (context, openContainer) {
//         return Container(
//           decoration: BoxDecoration(
//             gradient: gradient,
//           ),
//           child: AddTravelCaptainSection(
//             trip: trip,
//             onPressed: openContainer,
//           ),
//         );
//       },
//     );
//   }
// }
