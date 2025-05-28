import 'package:equatable/equatable.dart';
import 'package:travel_app/core/error/failure_class.dart';
import 'package:travel_app/feature/add_travel/data/model/trip_model.dart';

abstract class FavoriteState extends Equatable {
  const FavoriteState();
  @override
  List<Object?> get props => [];
}

class FavoriteInitial extends FavoriteState {}

class FavoriteLoading extends FavoriteState {}

class FavoriteLoaded extends FavoriteState {
  final List<TripModel> favorites;
  
  const FavoriteLoaded(this.favorites);
  
  @override
  List<Object?> get props => [favorites];
}

class FavoriteUpdated extends FavoriteState {
  final List<TripModel> favorites;
  
  const FavoriteUpdated(this.favorites);
  
  @override
  List<Object?> get props => [favorites];
}

class FavoriteAdded extends FavoriteState {
  final List<TripModel> favorites;
  final TripModel addedTrip;
  
  const FavoriteAdded(this.favorites, this.addedTrip);
  
  @override
  List<Object?> get props => [favorites, addedTrip];
}

class FavoriteRemoved extends FavoriteState {
  final List<TripModel> favorites;
  final TripModel removedTrip;
  
  const FavoriteRemoved(this.favorites, this.removedTrip);
  
  @override
  List<Object?> get props => [favorites, removedTrip];
}

class FavoriteError extends FavoriteState {
  final Failure failure;
  
  const FavoriteError(this.failure);
  
  @override
  List<Object?> get props => [failure];
}