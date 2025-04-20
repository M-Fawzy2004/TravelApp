import 'package:dartz/dartz.dart';
import 'package:travel_app/core/error/failure_class.dart';
import 'package:travel_app/feature/add_travel/data/model/trip_model.dart';

abstract class TripRepository {
  // get all trips
  Future<Either<Failure, List<TripModel>>> getAllTrips();
  // get trip by id
  Future<Either<Failure, TripModel>> getTripById(String id);
  // create trip
  Future<Either<Failure, void>> createTrip(TripModel trip);
  // update trip
  Future<Either<Failure, void>> updateTrip(TripModel trip);
  // delete trip
  Future<Either<Failure, void>> deleteTrip(String id);
  // search trips
  Future<Either<Failure, List<TripModel>>> searchTrips({
    TripType? tripType,
    String? destination,
    DateTime? date,
  });
}
