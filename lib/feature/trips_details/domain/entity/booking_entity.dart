import 'package:travel_app/feature/add_travel/data/model/trip_model.dart';
import 'package:travel_app/feature/trips_details/domain/entity/booking_item_entity.dart';

class BookingEntity {
  final List<BookingItemEntity> bookingItems;

  BookingEntity(this.bookingItems);

  addBooking(BookingItemEntity tripItemEntity) {
    bookingItems.add(tripItemEntity);
  }

  removeBooking(BookingItemEntity tripItemEntity) {
    bookingItems.remove(tripItemEntity);
  }

  calculateTotalPrice() {
    num totalPrice = 0;
    for (var bookingItems in bookingItems) {
      totalPrice += bookingItems.calulateTotalPrice();
    }
    return totalPrice;
  }

  bool isExist(TripModel tripModel) {
    for (var cartItem in bookingItems) {
      if (cartItem.trip == tripModel) {
        return true;
      }
    }
    return false;
  }

  BookingItemEntity getCartItem(TripModel tripModel) {
    for (var cartItem in bookingItems) {
      if (cartItem.trip == tripModel) {
        return cartItem;
      }
    }
    return BookingItemEntity(
      trip: tripModel,
      count: 1,
    );
  }
}
