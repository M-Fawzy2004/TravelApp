part of 'location_cubit.dart';

abstract class LocationState extends Equatable {
  const LocationState();

  @override
  List<Object?> get props => [];
}

class LocationInitial extends LocationState {}

class LocationLoading extends LocationState {}

class LocationLoaded extends LocationState {
  final LatLng? currentLocation;
  final LatLng? selectedLocation;
  final LatLng? destinationLocation;
  final List<LatLng> route;
  final bool isRouteVisible;

  const LocationLoaded({
    this.currentLocation,
    this.selectedLocation,
    this.destinationLocation,
    required this.route,
    required this.isRouteVisible,
  });

  @override
  List<Object?> get props => [
        currentLocation,
        selectedLocation,
        destinationLocation,
        route,
        isRouteVisible,
      ];

  LocationLoaded copyWith({
    LatLng? currentLocation,
    LatLng? selectedLocation,
    LatLng? destinationLocation,
    List<LatLng>? route,
    bool? isRouteVisible,
  }) {
    return LocationLoaded(
      currentLocation: currentLocation ?? this.currentLocation,
      selectedLocation: selectedLocation ?? this.selectedLocation,
      destinationLocation: destinationLocation ?? this.destinationLocation,
      route: route ?? this.route,
      isRouteVisible: isRouteVisible ?? this.isRouteVisible,
    );
  }
}

class LocationError extends LocationState {
  final String message;

  const LocationError(this.message);

  @override
  List<Object> get props => [message];
}
