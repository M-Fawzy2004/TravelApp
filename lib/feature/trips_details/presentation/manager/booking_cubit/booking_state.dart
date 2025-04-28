part of 'booking_cubit.dart';

abstract class BookingState extends Equatable {
  const BookingState();
  
  @override
  List<Object> get props => [];
}

class BookingInitial extends BookingState {}

class BookingAdded extends BookingState {
  final List<BookingItemEntity> bookings;
  
  const BookingAdded({required this.bookings});
  
  @override
  List<Object> get props => [bookings];
}

class BookingRemoved extends BookingState {
  final List<BookingItemEntity> bookings;
  
  const BookingRemoved({required this.bookings});
  
  @override
  List<Object> get props => [bookings];
}

class BookingFailed extends BookingState {}