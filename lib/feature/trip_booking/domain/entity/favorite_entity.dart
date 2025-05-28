import 'package:travel_app/feature/add_travel/data/model/trip_model.dart';

class FavoriteEntity {
  final List<TripModel> favoriteTrips;

  FavoriteEntity(this.favoriteTrips);

  void addFavorite(TripModel tripModel) {
    if (!isExist(tripModel)) {
      favoriteTrips.add(tripModel);
    }
  }

  void removeFavorite(TripModel tripModel) {
    favoriteTrips.removeWhere((trip) => trip.id == tripModel.id);
  }

  bool isExist(TripModel tripModel) {
    return favoriteTrips.any((trip) => trip.id == tripModel.id);
  }
}
