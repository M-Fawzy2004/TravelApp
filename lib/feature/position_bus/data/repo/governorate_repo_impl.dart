import 'package:dartz/dartz.dart';
import 'package:travel_app/core/error/failure_class.dart';
import 'package:travel_app/feature/position_bus/data/model/governorate_model.dart';
import 'package:travel_app/feature/position_bus/data/repo/governorate_repo.dart';
import 'package:travel_app/feature/position_bus/data/service/api_service.dart';

class GovernorateRepoImpl implements GovernorateRepo {
  final ApiService apiService;

  GovernorateRepoImpl({required this.apiService});

  @override
  Future<Either<Failure, List<GovernorateModel>>> getGovernorates() async {
    try {
      final response = await apiService.getAllData();

      final model = GovernorateModel.fromJson(response);

      return Right([model]);
    } catch (e) {
      return Left(
        ServerFailure(
          message: 'حدث خطأ أثناء جلب البيانات: ${e.toString()}',
        ),
      );
    }
  }
}
