import 'package:flutter/material.dart';
import 'package:travel_app/feature/add_travel/data/model/trip_model.dart';
import 'package:travel_app/feature/trips_details/presentation/view/widget/trips_form.dart';

class EditAndDeleteTrips extends StatelessWidget {
  const EditAndDeleteTrips({
    super.key,
    required this.trip,
  });
  final TripModel trip;

  @override
  Widget build(BuildContext context) {
    return TripsForm(trip: trip);
  }
}
