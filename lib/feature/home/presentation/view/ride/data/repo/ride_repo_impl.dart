import 'package:dartz/dartz.dart';
import 'package:travel_app/core/error/failure_class.dart';
import 'package:travel_app/feature/home/presentation/view/ride/data/model/ride_request_model.dart';
import 'package:travel_app/feature/home/presentation/view/ride/data/model/ride_status.dart';
import 'package:travel_app/feature/home/presentation/view/ride/data/repo/ride_repo.dart';
import 'package:travel_app/feature/home/presentation/view/ride/data/service/ride_service.dart';

class RideRepoImpl implements RideRepo {
  final RideService rideService;

  RideRepoImpl(this.rideService);

  // createRide
  @override
  Future<Either<Failure, void>> createRide(RideRequestModel ride) async {
    try {
      await rideService.createRide(ride);
      return const Right(null);
    } catch (e) {
      return const Left(ServerFailure(message: 'حدث خطاء في انشاء الرحلة'));
    }
  }

  // updateRide
  @override
  Future<Either<Failure, void>> updateRide(
    String id,
    Map<String, dynamic> data,
  ) async {
    try {
      await rideService.updateRide(id, data);
      return const Right(null);
    } catch (e) {
      return const Left(ServerFailure(message: 'حدث خطاء في تحديث الرحلة'));
    }
  }

  // getRideById
  @override
  Future<Either<Failure, RideRequestModel>> getRideById(String id) async {
    try {
      final result = await rideService.getRideById(id);
      if (result != null) {
        return Right(result);
      } else {
        return const Left(ServerFailure(message: "الرحلة غير موجودة"));
      }
    } catch (e) {
      return const Left(ServerFailure(message: 'حدث خطاء في جلب الرحلة'));
    }
  }

  // getRidesByStatus
  @override
  Future<Either<Failure, List<RideRequestModel>>> getRidesByStatus(
    RideStatus status,
  ) async {
    try {
      final result = await rideService.getRidesByStatus(status);
      return Right(result);
    } catch (e) {
      return const Left(
        ServerFailure(message: 'حدث خطاء في جلب الرحلات حسب الحالة'),
      );
    }
  }

  // listenToRide
  @override
  Stream<Either<Failure, RideRequestModel?>> listenToRide(String id) async* {
    try {
      await for (final ride in rideService.listenToRide(id)) {
        yield Right(ride);
      }
    } catch (e) {
      yield Left(ServerFailure(message: 'حدث خطأ في جلب الرحلة: $e'));
    }
  }

  // deleteRide
  @override
  Future<Either<Failure, void>> deleteRide(String id) async {
    try {
      await rideService.deleteRide(id);
      return const Right(null);
    } catch (e) {
      return const Left(ServerFailure(message: 'حدث خطاء في حذف الرحلة'));
    }
  }
}
