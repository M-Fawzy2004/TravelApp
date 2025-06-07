// ignore_for_file: depend_on_referenced_packages

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:travel_app/feature/position_bus/data/model/governorate_model.dart';
import 'package:travel_app/feature/position_bus/data/repo/governorate_repo.dart';

part 'governorate_state.dart';

class GovernorateCubit extends Cubit<GovernorateState> {
  GovernorateCubit(this.governorateRepo) : super(GovernorateInitial()) {
    getGovernorates();
  }

  final GovernorateRepo governorateRepo;

  Future<void> getGovernorates() async {
    emit(GovernorateLoading());
    try {
      final result = await governorateRepo.getGovernorates();
      result.fold(
        (failure) {
          emit(GovernorateFailure(message: failure.message));
        },
        (governorates) {
          if (governorates.isEmpty) {
            emit(const GovernorateFailure(message: 'لا توجد محافظات متاحة'));
          } else {
            emit(GovernorateSuccess(governorates: governorates));
          }
        },
      );
    } catch (e) {
      emit(GovernorateFailure(message: 'حدث خطأ غير متوقع: ${e.toString()}'));
    }
  }
}
