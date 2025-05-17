import 'package:dartz/dartz.dart';
import 'package:travel_app/core/error/failure_class.dart';
import 'package:travel_app/feature/home/presentation/view/ride/data/model/ride_request_model.dart';
import 'package:travel_app/feature/home/presentation/view/ride/data/model/ride_status.dart';

abstract class RideRepo {
  // create Ride
  Future<Either<Failure, void>> createRide(RideRequestModel ride);

  // update Ride
  Future<Either<Failure, void>> updateRide(
    String id,
    Map<String, dynamic> data,
  );

  // get Ride
  Future<Either<Failure, RideRequestModel>> getRideById(String id);

  // get Rides by status
  Future<Either<Failure, List<RideRequestModel>>> getRidesByStatus(
    RideStatus status,
  );

  // listen to Ride
  Stream<Either<Failure, RideRequestModel?>> listenToRide(String id);

  // delete Ride
  Future<Either<Failure, void>> deleteRide(String id);
}
