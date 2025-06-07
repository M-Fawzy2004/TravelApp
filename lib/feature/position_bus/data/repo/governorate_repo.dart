import 'package:dartz/dartz.dart';
import 'package:travel_app/core/error/failure_class.dart';
import 'package:travel_app/feature/position_bus/data/model/governorate_model.dart';

abstract class GovernorateRepo {
  Future<Either<Failure, List<GovernorateModel>>> getGovernorates();
}
