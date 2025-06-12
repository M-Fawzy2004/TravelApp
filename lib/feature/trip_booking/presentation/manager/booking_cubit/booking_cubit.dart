// ignore_for_file: depend_on_referenced_packages
import 'dart:convert';
import 'package:bloc/bloc.dart';
import 'package:travel_app/constant.dart';
import 'package:travel_app/core/services/shared_preference_singleton.dart';
import 'package:travel_app/feature/add_travel/data/model/trip_model.dart';
import 'package:travel_app/feature/trip_booking/domain/entity/booking_entity.dart';
import 'package:travel_app/feature/trip_booking/domain/entity/booking_item_entity.dart';
import 'package:travel_app/feature/trip_booking/presentation/manager/booking_cubit/booking_state.dart';

class BookingCubit extends Cubit<BookingState> {
  BookingCubit() : super(const BookingInitial()) {
    loadBookingsFromPrefs();
  }

  BookingEntity bookingEntity = BookingEntity([]);

  void addBooking(TripModel tripModel) {
    if (isClosed) return; // Add this check

    bool isProductExist = bookingEntity.isExist(tripModel);
    var getBooking = bookingEntity.getCartItem(tripModel);
    if (isProductExist) {
      getBooking.increaseCount();
    } else {
      bookingEntity.addBooking(getBooking);
    }
    saveAllBookedTrips();
    final newBookings = bookingEntity.bookingItems
        .map((item) => BookingItemEntity(
              trip: item.trip,
              count: item.count,
            ))
        .toList();

    if (!isClosed) {
      // Check before emitting
      emit(BookingAdded(bookings: newBookings));
    }
  }

  void removeBooking(BookingItemEntity bookingItemEntity) {
    if (isClosed) return;

    bookingEntity.bookingItems.removeWhere(
      (item) => item.trip.id == bookingItemEntity.trip.id,
    );
    saveAllBookedTrips();

    if (!isClosed) {
      if (bookingEntity.bookingItems.isEmpty) {
        emit(const BookingInitial(bookings: []));
      } else {
        final newBookings = bookingEntity.bookingItems
            .map((item) => BookingItemEntity(
                  trip: item.trip,
                  count: item.count,
                ))
            .toList();

        emit(BookingRemoved(bookings: newBookings));
      }
    }
  }

  void increaseBookingCount(String tripId) {
    if (isClosed) return;

    final bookingItem = bookingEntity.bookingItems.firstWhere(
      (item) => item.trip.id == tripId,
    );
    if (bookingItem.count < 20) {
      bookingItem.increaseCount();
      saveAllBookedTrips();
      final newBookings = bookingEntity.bookingItems
          .map((item) => BookingItemEntity(
                trip: item.trip,
                count: item.count,
              ))
          .toList();

      if (!isClosed) {
        emit(BookingAdded(bookings: newBookings));
      }
    }
  }

  void decreaseBookingCount(String tripId) {
    if (isClosed) return;

    final bookingItem = bookingEntity.bookingItems.firstWhere(
      (item) => item.trip.id == tripId,
    );
    if (bookingItem.count > 1) {
      bookingItem.decreaseCount();
      saveAllBookedTrips();
      final newBookings = bookingEntity.bookingItems
          .map((item) => BookingItemEntity(
                trip: item.trip,
                count: item.count,
              ))
          .toList();

      if (!isClosed) {
        emit(BookingAdded(bookings: newBookings));
      }
    }
  }

  Future<void> saveAllBookedTrips() async {
    final tripsJsonList = bookingEntity.bookingItems
        .map((bookingItem) => {
              ...bookingItem.trip.toJson(),
              'count': bookingItem.count,
            })
        .toList();

    await Prefs.setString(kBookedTripsKey, jsonEncode(tripsJsonList));
  }

  Future<void> loadBookingsFromPrefs() async {
    final tripsString = Prefs.getString(kBookedTripsKey);
    if (tripsString.isEmpty) {
      if (!isClosed) {
        emit(const BookingInitial(bookings: []));
      }
      return;
    }

    try {
      final List<dynamic> decodedList = jsonDecode(tripsString);
      final List<BookingItemEntity> loadedBookings = decodedList
          .map((e) => BookingItemEntity(
                trip: TripModel.fromJson(e),
                count: e['count'] ?? 1,
              ))
          .toList();

      bookingEntity = BookingEntity(loadedBookings);

      if (!isClosed) {
        // Check before emitting
        if (loadedBookings.isNotEmpty) {
          emit(BookingAdded(bookings: List.from(loadedBookings)));
        } else {
          emit(const BookingInitial(bookings: []));
        }
      }
    } catch (e) {
      if (!isClosed) {
        emit(const BookingInitial(bookings: []));
      }
    }
  }

  void clearAllBookings() {
    if (isClosed) return;

    bookingEntity.bookingItems.clear();
    saveAllBookedTrips();

    if (!isClosed) {
      emit(const BookingInitial(bookings: []));
    }
  }
}
