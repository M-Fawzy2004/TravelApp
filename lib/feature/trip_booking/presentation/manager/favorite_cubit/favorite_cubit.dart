// ignore_for_file: depend_on_referenced_packages
import 'dart:convert';
import 'package:bloc/bloc.dart';
import 'package:dartz/dartz.dart';
import 'package:travel_app/constant.dart';
import 'package:travel_app/core/error/failure_class.dart';
import 'package:travel_app/core/services/shared_preference_singleton.dart';
import 'package:travel_app/feature/add_travel/data/model/trip_model.dart';
import 'package:travel_app/feature/trip_booking/domain/entity/favorite_entity.dart';
import 'favorite_state.dart';

class FavoriteCubit extends Cubit<FavoriteState> {
  FavoriteCubit() : super(FavoriteInitial()) {
    loadFavorites();
  }

  FavoriteEntity favoriteEntity = FavoriteEntity([]);

  Future<void> toggleFavorite(TripModel tripModel) async {
    emit(FavoriteLoading());
    final result = await _toggleFavoriteLogic(tripModel);
    result.fold(
      (failure) => emit(FavoriteError(failure)),
      (wasAdded) {
        if (wasAdded) {
          emit(FavoriteAdded(List.from(favoriteEntity.favoriteTrips), tripModel));
        } else {
          emit(FavoriteRemoved(List.from(favoriteEntity.favoriteTrips), tripModel));
        }
      },
    );
  }

  Future<Either<Failure, bool>> _toggleFavoriteLogic(TripModel tripModel) async {
    try {
      bool wasAdded = false;
      if (favoriteEntity.isExist(tripModel)) {
        favoriteEntity.removeFavorite(tripModel);
        wasAdded = false;
      } else {
        favoriteEntity.addFavorite(tripModel);
        wasAdded = true;
      }
      final saveResult = await _saveFavorites();
      return saveResult.fold(
        (failure) => Left(failure),
        (_) => Right(wasAdded),
      );
    } catch (e) {
      return const Left(ServerFailure(message: 'حدث خطأ أثناء تحديث المفضلة'));
    }
  }

  Future<void> undoRemoveFavorite(TripModel tripModel) async {
    try {
      favoriteEntity.addFavorite(tripModel);
      await _saveFavorites();
      emit(FavoriteAdded(List.from(favoriteEntity.favoriteTrips), tripModel));
    } catch (e) {
      emit(const FavoriteError(ServerFailure(message: 'حدث خطأ أثناء التراجع')));
    }
  }

  Future<void> loadFavorites() async {
    emit(FavoriteLoading());
    final result = await _loadFavoritesLogic();
    result.fold(
      (failure) => emit(FavoriteError(failure)),
      (favorites) {
        favoriteEntity = FavoriteEntity(favorites);
        emit(FavoriteLoaded(List.from(favoriteEntity.favoriteTrips)));
      },
    );
  }

  Future<Either<Failure, List<TripModel>>> _loadFavoritesLogic() async {
    try {
      final favoritesString = Prefs.getString(kFavoriteTripsKey);
      if (favoritesString.isEmpty) {
        return const Right([]);
      }
      final decodedList = jsonDecode(favoritesString);
      final List<TripModel> loadedFavorites =
          (decodedList as List).map((e) => TripModel.fromJson(e)).toList();
      return Right(loadedFavorites);
    } catch (e) {
      return const Left(ServerFailure(message: 'حدث خطأ أثناء تحميل المفضلة'));
    }
  }

  Future<Either<Failure, Unit>> _saveFavorites() async {
    try {
      final encodedList = jsonEncode(
        favoriteEntity.favoriteTrips.map((trip) => trip.toJson()).toList(),
      );
      await Prefs.setString(kFavoriteTripsKey, encodedList);
      return const Right(unit);
    } catch (e) {
      return const Left(ServerFailure(message: 'حدث خطأ أثناء حفظ المفضلة'));
    }
  }

  bool isFavorite(TripModel tripModel) {
    return favoriteEntity.isExist(tripModel);
  }

  Future<void> clearAllFavorites() async {
    emit(FavoriteLoading());
    final result = await _clearFavoritesLogic();
    result.fold(
      (failure) => emit(FavoriteError(failure)),
      (_) {
        favoriteEntity = FavoriteEntity([]);
        emit(const FavoriteUpdated([]));
      },
    );
  }

  Future<Either<Failure, Unit>> _clearFavoritesLogic() async {
    try {
      favoriteEntity = FavoriteEntity([]);
      final saveResult = await _saveFavorites();
      return saveResult;
    } catch (e) {
      return const Left(ServerFailure(message: 'حدث خطأ أثناء مسح المفضلة'));
    }
  }

  int getFavoritesCount() {
    return favoriteEntity.favoriteTrips.length;
  }

  Future<void> initializeFavorites() async {
    if (state is FavoriteInitial) {
      await loadFavorites();
    }
  }
}