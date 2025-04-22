import 'package:dartz/dartz.dart';
import 'package:travel_app/core/error/failure_class.dart';
import 'package:travel_app/feature/add_travel/data/model/trip_model.dart';
import 'package:travel_app/feature/add_travel/data/repos/trip_repo.dart';
import 'package:travel_app/feature/add_travel/data/service/trip_service.dart';

class TripRepositoryImpl implements TripRepository {
  final TripService _service;

  TripRepositoryImpl({required TripService service}) : _service = service;

  @override
  Future<Either<Failure, List<TripModel>>> getAllTrips() async {
    try {
      final trips = await _service.getAllTrips();
      return Right(trips);
    } catch (e) {
      return Left(ServerFailure(message: e.toString()));
    }
  }

  @override
  Future<Either<Failure, TripModel>> getTripById(String id) async {
    try {
      final trip = await _service.getTripById(id);
      return Right(trip);
    } catch (e) {
      return Left(ServerFailure(message: e.toString()));
    }
  }

  @override
  Future<Either<Failure, void>> createTrip(TripModel trip) async {
    try {
      await _service.createTrip(trip);
      return const Right(null);
    } catch (e) {
      return Left(ServerFailure(message: e.toString()));
    }
  }

  @override
  Future<Either<Failure, void>> updateTrip(TripModel trip) async {
    try {
      await _service.updateTrip(trip);
      return const Right(null);
    } catch (e) {
      return Left(ServerFailure(message: e.toString()));
    }
  }

  @override
  Future<Either<Failure, void>> deleteTrip(String id) async {
    try {
      await _service.deleteTrip(id);
      return const Right(null);
    } catch (e) {
      return Left(ServerFailure(message: e.toString()));
    }
  }

  @override
  Future<Either<Failure, List<TripModel>>> searchTrips({
    TripType? tripType,
    String? destination,
    DateTime? date,
  }) async {
    try {
      final trips = await _service.searchTrips(
        tripType: tripType,
        destination: destination,
        date: date,
      );
      return Right(trips);
    } catch (e) {
      return Left(ServerFailure(message: e.toString()));
    }
  }

  @override
  Future<Either<Failure, List<TripModel>>> getTripsByCaptainId(
      String captainId) async {
    try {
      final result = await _service.getTripsByCaptainId(captainId);
      return right(result);
    } on Exception catch (e) {
      return Left(ServerFailure(message: e.toString()));
    }
  }
}
