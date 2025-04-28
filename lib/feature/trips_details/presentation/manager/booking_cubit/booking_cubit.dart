// ignore: depend_on_referenced_packages
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:travel_app/feature/add_travel/data/model/trip_model.dart';
import 'package:travel_app/feature/trips_details/domain/entity/booking_entity.dart';
import 'package:travel_app/feature/trips_details/domain/entity/booking_item_entity.dart';
part 'booking_state.dart';

class BookingCubit extends Cubit<BookingState> {
  BookingCubit() : super(BookingInitial());

  BookingEntity bookingEntity = BookingEntity([]);

  void addBooking(TripModel tripModel) {
    print(
        "BEFORE ADDING: Booking count = ${bookingEntity.bookingItems.length}");

    bool isProductExist = bookingEntity.isExist(tripModel);
    var getBooking = bookingEntity.getCartItem(tripModel);

    if (isProductExist) {
      getBooking.increaseCount();
      print("INCREASED COUNT of existing booking");
    } else {
      bookingEntity.addBooking(getBooking);
      print("ADDED NEW BOOKING");
    }

    print("AFTER ADDING: Booking count = ${bookingEntity.bookingItems.length}");
    print(
        "BOOKING DETAILS: ${getBooking.trip.destinationName}, count: ${getBooking.count}");

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
    emit(BookingRemoved(bookings: bookingEntity.bookingItems));
  }
}
