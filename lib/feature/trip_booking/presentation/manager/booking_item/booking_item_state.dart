part of 'booking_item_cubit.dart';

sealed class BookingItemState {
  const BookingItemState();
}

final class BookingItemInitial extends BookingItemState {}

final class BookingItemUpdated extends BookingItemState {
  final BookingItemEntity bookingItemEntity;

  const BookingItemUpdated({required this.bookingItemEntity});
}
