import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:travel_app/feature/home/presentation/view/ride/data/repo/ride_repo.dart';
import 'ride_state.dart';

class RideCubit extends Cubit<RideState> {
  final RideRepo rideRepo;

  RideCubit(this.rideRepo) : super(RideInitial());

  // Get ride by ID (once)
  Future<void> getRideById(String id) async {
    emit(RideLoading());
    final result = await rideRepo.getRideById(id);

    result.fold(
      (failure) => emit(RideFailure(failure.message)),
      (ride) => emit(RideSuccess(ride)),
    );
  }

  // Create new ride
  Future<void> createRide(ride) async {
    emit(RideLoading());
    final result = await rideRepo.createRide(ride);

    result.fold(
      (failure) => emit(RideFailure(failure.message)),
      (_) => emit(RideSuccess(ride)),
    );
  }

  // Update ride
  Future<void> updateRide(String id, Map<String, dynamic> data) async {
    emit(RideLoading());
    final result = await rideRepo.updateRide(id, data);

    result.fold(
      (failure) => emit(RideFailure(failure.message)),
      (_) => getRideById(id),
    );
  }

  // Delete ride
  Future<void> deleteRide(String id) async {
    emit(RideLoading());
    final result = await rideRepo.deleteRide(id);

    result.fold(
      (failure) => emit(RideFailure(failure.message)),
      (_) => emit(const RideSuccess(null)),
    );
  }
}
