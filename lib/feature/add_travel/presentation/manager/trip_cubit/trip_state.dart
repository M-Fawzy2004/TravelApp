import 'package:equatable/equatable.dart';
import 'package:travel_app/feature/add_travel/data/model/trip_model.dart';

// Trip States
abstract class TripState extends Equatable {
  const TripState();
  
  @override
  List<Object?> get props => [];
}

class TripInitial extends TripState {}

class TripLoading extends TripState {}

class TripsLoadedSuccess extends TripState {
  final List<TripModel> trips;
  
  const TripsLoadedSuccess(this.trips);
  
  @override
  List<Object?> get props => [trips];
}

class TripLoadedSuccess extends TripState {
  final TripModel trip;
  
  const TripLoadedSuccess(this.trip);
  
  @override
  List<Object?> get props => [trip];
}

class TripOperationSuccess extends TripState {
  final String message;
  
  const TripOperationSuccess(this.message);
  
  @override
  List<Object?> get props => [message];
}

class TripError extends TripState {
  final String message;
  final FailureType failureType;
  
  const TripError({
    required this.message,
    this.failureType = FailureType.unknown
  });
  
  @override
  List<Object?> get props => [message, failureType];
}

// Failure Type Enum for better error handling
enum FailureType {
  server,
  network,
  validation,
  notFound,
  unknown
}