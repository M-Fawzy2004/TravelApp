import 'package:flutter/material.dart';
import 'package:travel_app/feature/add_travel/data/model/trip_model.dart';

TripModel getCategorySkeletonizer() {
  return TripModel(
    id: '',
    creatorId: '',
    creatorFirstName: 'مجهول',
    creatorLastName: 'مجهول',
    creatorPhone: 'غير معروف',
    tripType: TripType.specialTrip,
    destinationName: '',
    departureLocation: '',
    arrivalLocation: '',
    availableSeats: 0,
    tripDate: DateTime.now(),
    tripTime: TimeOfDay.now(),
    duration: '',
    price: 0.0,
    additionalDetails: '',
  );
}
