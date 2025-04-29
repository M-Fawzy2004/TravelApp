import 'package:equatable/equatable.dart';
import 'package:travel_app/feature/add_travel/data/model/trip_model.dart';

// ignore: must_be_immutable
class BookingItemEntity extends Equatable {
  final TripModel trip;
  int count;

  BookingItemEntity({required this.trip, this.count = 1});

  num calulateTotalPrice() {
    return trip.price * count;
  }

  increaseCount() {
    count++;
  }

  decreaseCount() {
    count--;
  }

  @override
  List<Object?> get props => [trip];
}
