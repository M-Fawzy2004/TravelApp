import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:travel_app/core/error/failure_class.dart';
import 'package:travel_app/feature/add_travel/data/model/trip_model.dart';
import 'package:travel_app/feature/add_travel/data/repos/trip_repo.dart';
import 'package:travel_app/feature/add_travel/presentation/manager/trip_cubit/trip_state.dart';

// Trip Cubit
class TripCubit extends Cubit<TripState> {
  final TripRepository _tripRepository;

  TripCubit({required TripRepository tripRepository})
      : _tripRepository = tripRepository,
        super(TripInitial());

  Future<void> getAllTrips() async {
    emit(TripLoading());

    final result = await _tripRepository.getAllTrips();

    result.fold(
      (failure) => _handleFailure(failure),
      (trips) {
        trips.shuffle();
        emit(TripsLoadedSuccess(trips));
      },
    );
  }

  Future<void> getTripById(String id) async {
    emit(TripLoading());

    final result = await _tripRepository.getTripById(id);

    result.fold((failure) => _handleFailure(failure),
        (trip) => emit(TripLoadedSuccess(trip)));
  }

  Future<void> createTrip(TripModel trip) async {
    emit(TripLoading());

    final result = await _tripRepository.createTrip(trip);

    result.fold((failure) => _handleFailure(failure),
        (_) => emit(const TripOperationSuccess('تم إنشاء الرحلة بنجاح')));
  }

  Future<void> updateTrip(TripModel trip) async {
    emit(TripLoading());

    final result = await _tripRepository.updateTrip(trip);

    result.fold((failure) => _handleFailure(failure),
        (_) => emit(const TripOperationSuccess('تم تحديث الرحلة بنجاح')));
  }

  Future<void> deleteTrip(String id) async {
    emit(TripLoading());

    final result = await _tripRepository.deleteTrip(id);

    result.fold((failure) => _handleFailure(failure),
        (_) => emit(const TripOperationSuccess('تم حذف الرحلة بنجاح')));
  }

  Future<void> searchTrips({
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

    result.fold((failure) => _handleFailure(failure),
        (trips) => emit(TripsLoadedSuccess(trips)));
  }

  // Helper method to handle failures consistently
  void _handleFailure(Failure failure) {
    FailureType type = FailureType.unknown;

    if (failure is ServerFailure) {
      type = FailureType.server;
    } else if (failure is NetworkFailure) {
      type = FailureType.network;
    }

    emit(TripError(message: failure.message, failureType: type));
  }
}
