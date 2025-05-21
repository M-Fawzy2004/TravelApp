part of 'passenger_directory_cubit.dart';

abstract class PassengerDirectoryState extends Equatable {
  const PassengerDirectoryState();

  @override
  List<Object?> get props => [];
}

class PassengerDirectoryInitial extends PassengerDirectoryState {
  const PassengerDirectoryInitial();
}

class PassengerDirectoryLoading extends PassengerDirectoryState {
  const PassengerDirectoryLoading();
}

class PassengerDirectoryLoaded extends PassengerDirectoryState {
  final LatLng currentLocation;
  final String currentAddress;
  final LatLng? destinationLocation;
  final String destinationAddress;
  final List<String> searchSuggestions;
  final bool isSearching;
  final double? estimatedFare;
  final double? distanceKm;
  final int? durationMin;
  final List<LatLng> routePoints;
  final String lastQuery;

  const PassengerDirectoryLoaded({
    required this.currentLocation,
    required this.currentAddress,
    this.destinationLocation,
    required this.destinationAddress,
    required this.searchSuggestions,
    required this.isSearching,
    this.estimatedFare,
    this.distanceKm,
    this.durationMin,
    required this.routePoints,
    required this.lastQuery,
  });

  PassengerDirectoryLoaded copyWith({
    LatLng? currentLocation,
    String? currentAddress,
    LatLng? destinationLocation,
    String? destinationAddress,
    List<String>? searchSuggestions,
    bool? isSearching,
    double? estimatedFare,
    double? distanceKm,
    int? durationMin,
    List<LatLng>? routePoints,
    String? lastQuery,
  }) {
    return PassengerDirectoryLoaded(
      currentLocation: currentLocation ?? this.currentLocation,
      currentAddress: currentAddress ?? this.currentAddress,
      destinationLocation: destinationLocation ?? this.destinationLocation,
      destinationAddress: destinationAddress ?? this.destinationAddress,
      searchSuggestions: searchSuggestions ?? this.searchSuggestions,
      isSearching: isSearching ?? this.isSearching,
      estimatedFare: estimatedFare ?? this.estimatedFare,
      distanceKm: distanceKm ?? this.distanceKm,
      durationMin: durationMin ?? this.durationMin,
      routePoints: routePoints ?? this.routePoints,
      lastQuery: lastQuery ?? this.lastQuery,
    );
  }

  @override
  List<Object?> get props => [
        currentLocation,
        currentAddress,
        destinationLocation,
        destinationAddress,
        searchSuggestions,
        isSearching,
        estimatedFare,
        distanceKm,
        durationMin,
        routePoints,
        lastQuery,
      ];
}

class PassengerDirectoryError extends PassengerDirectoryState {
  final String message;

  const PassengerDirectoryError(this.message);

  @override
  List<Object> get props => [message];
}
