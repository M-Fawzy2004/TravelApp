import 'package:travel_app/feature/trip_booking/domain/entity/booking_item_entity.dart';

abstract class BookingState {
  final List<BookingItemEntity> bookings;
  const BookingState({this.bookings = const []});
}

class BookingInitial extends BookingState {
  const BookingInitial({super.bookings});
}

class BookingAdded extends BookingState {
  const BookingAdded({required super.bookings});
}

class BookingRemoved extends BookingState {
  const BookingRemoved({required super.bookings});
}

class BookingFailed extends BookingState {
  const BookingFailed();
}
