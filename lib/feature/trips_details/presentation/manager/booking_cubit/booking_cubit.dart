// ignore: duplicate_ignore
// ignore: depend_on_referenced_packages
// ignore_for_file: depend_on_referenced_packages

import 'dart:convert';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:travel_app/core/services/shared_preference_singleton.dart';
import 'package:travel_app/feature/add_travel/data/model/trip_model.dart';
import 'package:travel_app/feature/trips_details/domain/entity/booking_entity.dart';
import 'package:travel_app/feature/trips_details/domain/entity/booking_item_entity.dart';
part 'booking_state.dart';

class BookingCubit extends Cubit<BookingState> {
  BookingCubit() : super(BookingInitial());

  final String kBookedTripsKey = "bookedTrips";

  BookingEntity bookingEntity = BookingEntity([]);

  void addBooking(TripModel tripModel) {
    bool isProductExist = bookingEntity.isExist(tripModel);
    var getBooking = bookingEntity.getCartItem(tripModel);

    if (isProductExist) {
      getBooking.increaseCount();
    } else {
      bookingEntity.addBooking(getBooking);
    }

    saveAllBookedTrips();
    emit(BookingAdded(bookings: List.from(bookingEntity.bookingItems)));
  }

  void removeBooking(TripModel tripModel) {
    bool isProductExist = bookingEntity.isExist(tripModel);
    var getBooking = bookingEntity.getCartItem(tripModel);

    if (isProductExist) {
      getBooking.decreaseCount();
      if (getBooking.count == 0) {
        bookingEntity.removeBooking(getBooking);
      }
    }

    saveAllBookedTrips();
    emit(BookingRemoved(bookings: List.from(bookingEntity.bookingItems)));
  }

  Future<void> saveAllBookedTrips() async {
    final tripsJsonList = bookingEntity.bookingItems
        .map((bookingItem) => bookingItem.trip.toJson())
        .toList();

    await Prefs.setString(kBookedTripsKey, jsonEncode(tripsJsonList));
  }

  Future<void> loadBookingsFromPrefs() async {
    final tripsString = Prefs.getString(kBookedTripsKey);
    if (tripsString.isEmpty) return;

    final List<dynamic> decodedList = jsonDecode(tripsString);
    final List<BookingItemEntity> loadedBookings = decodedList
        .map((e) => BookingItemEntity(trip: TripModel.fromJson(e)))
        .toList();

    bookingEntity = BookingEntity(loadedBookings);
    emit(BookingInitial());
  }
}
