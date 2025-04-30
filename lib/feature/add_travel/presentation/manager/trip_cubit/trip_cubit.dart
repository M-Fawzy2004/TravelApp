import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:travel_app/core/error/failure_class.dart';
import 'package:travel_app/feature/add_travel/data/model/trip_model.dart';
import 'package:travel_app/feature/add_travel/data/repos/trip_repo.dart';
import 'package:travel_app/feature/add_travel/presentation/manager/trip_cubit/trip_state.dart';

// Trip Cubit
class TripCubit extends Cubit<TripState> {
  final TripRepository _tripRepository;
  // ignore: prefer_final_fields
  List<TripModel> _allTrips = [];

  TripCubit({required TripRepository tripRepository})
      : _tripRepository = tripRepository,
        super(TripInitial());

  // create trip
  Future<void> createTrip(TripModel trip) async {
    emit(TripLoading());

    final result = await _tripRepository.createTrip(trip);

    result.fold(
      (failure) => _handleFailure(failure),
      (_) => emit(
        const TripOperationSuccess('تم إنشاء الرحلة بنجاح'),
      ),
    );
  }

  // update trip
  Future<void> updateTrip(TripModel trip) async {
    emit(TripLoading());

    final result = await _tripRepository.updateTrip(trip);

    result.fold(
      (failure) => _handleFailure(failure),
      (_) => emit(
        const TripOperationSuccess(
          'تم تحديث الرحلة بنجاح',
        ),
      ),
    );
  }

  // delete trip
  Future<void> deleteTrip(String id) async {
    emit(TripLoading());

    final result = await _tripRepository.deleteTrip(id);
    result.fold(
      (failure) => _handleFailure(failure),
      (_) => emit(
        const TripOperationSuccess('تم حذف الرحلة بنجاح'),
      ),
    );
  }

  // get trips by captain id
  Future<void> getTripsByCaptainId(String captainId) async {
    emit(TripLoading());
    final result = await _tripRepository.getTripsByCaptainId(captainId);
    result.fold(
      (failure) => _handleFailure(failure),
      (trips) => emit(
        TripsLoadedSuccess(trips),
      ),
    );
  }

  // get all trips
  Future<void> getAllTrips() async {
    emit(TripLoading());
    final result = await _tripRepository.getAllTrips();
    result.fold(
      (failure) => emit(TripError(message: failure.message)),
      (trips) {
        _allTrips = trips;
        emit(TripsLoadedSuccess(trips));
      },
    );
  }

  // get trip by id
  Future<void> getTripById(String id) async {
    emit(TripLoading());

    final result = await _tripRepository.getTripById(id);

    result.fold(
      (failure) => _handleFailure(failure),
      (trip) => emit(
        TripLoadedSuccess(trip),
      ),
    );
  }

  // filter trips
  void filterTripsByType(TripType tripType) {
    emit(TripLoading());

    if (_allTrips.isEmpty) {
      getAllTrips().then((_) {
        _filterByType(tripType);
      });
    } else {
      _filterByType(tripType);
    }
  }

  void _filterByType(TripType tripType) {
    final filteredTrips =
        _allTrips.where((trip) => trip.tripType == tripType).toList();
    emit(TripsLoadedSuccess(filteredTrips));
  }

  // Search trips by query
  // This will search across destinationName, departureLocation, and arrivalLocation
  Future<void> searchTrips(String query) async {
    if (query.isEmpty) {
      getAllTrips();
      return;
    }
    emit(TripLoading());
    // Use the cached trips for search to avoid unnecessary API calls
    if (_allTrips.isEmpty) {
      // If cache is empty, fetch from repository first
      await getAllTrips();
    }
    final lowercaseQuery = query.toLowerCase();
    // Search across multiple fields
    final searchResults = _allTrips.where((trip) {
      return trip.destinationName.toLowerCase().contains(lowercaseQuery) ||
          trip.departureLocation.toLowerCase().contains(lowercaseQuery) ||
          trip.arrivalLocation.toLowerCase().contains(lowercaseQuery) ||
          trip.creatorFirstName.toLowerCase().contains(lowercaseQuery) ||
          trip.creatorLastName.toLowerCase().contains(lowercaseQuery) ||
          trip.additionalDetails.toLowerCase().contains(lowercaseQuery);
    }).toList();
    emit(TripsLoadedSuccess(searchResults));
  }

  // For server-side search (if needed for more complex queries)
  Future<void> serverSideSearch({
    TripType? tripType,
    String? destination,
    DateTime? date,
  }) async {
    emit(TripLoading());
    final result = await _tripRepository.searchTrips(
      tripType: tripType,
      destination: destination,
      date: date,
    );
    result.fold(
      (failure) => emit(TripError(message: failure.message)),
      (trips) {
        _allTrips = trips;
        emit(TripsLoadedSuccess(trips));
      },
    );
  }

  // Helper method to handle failures consistently
  void _handleFailure(Failure failure) {
    FailureType type = FailureType.unknown;

    if (failure is ServerFailure) {
      type = FailureType.server;
    } else if (failure is NetworkFailure) {
      type = FailureType.network;
    }

    emit(
      TripError(message: failure.message, failureType: type),
    );
  }
}
