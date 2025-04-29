// ignore: depend_on_referenced_packages
import 'package:bloc/bloc.dart';
import 'package:travel_app/feature/trip_booking/domain/entity/booking_item_entity.dart';

part 'booking_item_state.dart';

class BookingItemCubit extends Cubit<BookingItemState> {
  BookingItemCubit() : super(BookingItemInitial());

  void updateItem(BookingItemEntity item) {
    emit(BookingItemUpdated(bookingItemEntity: item));
  }
}
