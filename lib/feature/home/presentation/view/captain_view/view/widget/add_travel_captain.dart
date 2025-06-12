// ignore_for_file: depend_on_referenced_packages

import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:travel_app/core/helper/app_router.dart';
import 'package:travel_app/feature/add_travel/data/model/trip_model.dart';
import 'package:travel_app/feature/home/presentation/view/captain_view/view/widget/add_travel_captain_section.dart';

class AddTravelCaptain extends StatelessWidget {
  final TripModel trip;

  const AddTravelCaptain({super.key, required this.trip});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        context.push(
          AppRouter.detailsTrip,
          extra: {'trip': trip},
        );
      },
      child: AddTravelCaptainSection(trip: trip),
    );
  }
}
