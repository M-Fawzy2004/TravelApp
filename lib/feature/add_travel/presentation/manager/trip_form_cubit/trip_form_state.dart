// Form Cubit
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:travel_app/feature/add_travel/data/model/trip_model.dart';

class TripFormState extends Equatable {
  final TripType tripType;
  final String destinationName;
  final String departureLocation;
  final String arrivalLocation;
  final int availableSeats;
  final DateTime? tripDate;
  final TimeOfDay? tripTime;
  final String duration;
  final double price;
  final String additionalDetails;
  final bool isSubmitting;
  final String? error;
  final Map<String, String> fieldErrors;
  final int gradientIndex;

  const TripFormState({
    this.tripType = TripType.cargoShipping,
    this.destinationName = '',
    this.departureLocation = '',
    this.arrivalLocation = '',
    this.availableSeats = 0,
    this.tripDate,
    this.tripTime,
    this.duration = '',
    this.price = 0.0,
    this.additionalDetails = '',
    this.isSubmitting = false,
    this.error,
    this.fieldErrors = const {},
    this.gradientIndex = 0,
  });

  @override
  List<Object?> get props => [
        tripType,
        destinationName,
        departureLocation,
        arrivalLocation,
        availableSeats,
        tripDate,
        tripTime,
        duration,
        price,
        additionalDetails,
        isSubmitting,
        error,
        fieldErrors,
        gradientIndex,
      ];

  TripFormState copyWith({
    TripType? tripType,
    String? destinationName,
    String? departureLocation,
    String? arrivalLocation,
    int? availableSeats,
    DateTime? tripDate,
    TimeOfDay? tripTime,
    String? duration,
    double? price,
    String? additionalDetails,
    bool? isSubmitting,
    String? error,
    Map<String, String>? fieldErrors,
    int? gradientIndex,
  }) {
    return TripFormState(
      tripType: tripType ?? this.tripType,
      destinationName: destinationName ?? this.destinationName,
      departureLocation: departureLocation ?? this.departureLocation,
      arrivalLocation: arrivalLocation ?? this.arrivalLocation,
      availableSeats: availableSeats ?? this.availableSeats,
      tripDate: tripDate ?? this.tripDate,
      tripTime: tripTime ?? this.tripTime,
      duration: duration ?? this.duration,
      price: price ?? this.price,
      additionalDetails: additionalDetails ?? this.additionalDetails,
      isSubmitting: isSubmitting ?? this.isSubmitting,
      error: error,
      fieldErrors: fieldErrors ?? this.fieldErrors,
      gradientIndex: gradientIndex ?? this.gradientIndex,
    );
  }

  TripModel toTripModel() {
    return TripModel(
      id: '',
      creatorId: '',
      tripType: tripType,
      destinationName: destinationName,
      departureLocation: departureLocation,
      arrivalLocation: arrivalLocation,
      availableSeats: availableSeats,
      tripDate: tripDate ?? DateTime.now(),
      tripTime: tripTime ?? const TimeOfDay(hour: 12, minute: 0),
      duration: duration,
      price: price,
      additionalDetails: additionalDetails,
      gradientIndex: gradientIndex,
    );
  }

  bool get isValid {
    return destinationName.isNotEmpty &&
        departureLocation.isNotEmpty &&
        arrivalLocation.isNotEmpty &&
        tripDate != null &&
        tripTime != null;
  }
}
