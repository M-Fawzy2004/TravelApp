import 'package:travel_app/feature/add_travel/data/model/trip_model.dart';
import 'package:travel_app/feature/trip_booking/domain/entity/booking_item_entity.dart';

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

  num calculateTax() {
    num totalPrice = calculateTotalPrice();
    double taxRate;

    if (totalPrice <= 500) {
      taxRate = 0.10;
    } else if (totalPrice <= 1000) {
      taxRate = 0.12;
    } else if (totalPrice <= 2000) {
      taxRate = 0.14;
    } else {
      taxRate = 0.16;
    }

    return (totalPrice * taxRate).round();
  }

  num calculateSimpleTax() {
    num totalPrice = calculateTotalPrice();
    const double taxRate = 0.14;
    return (totalPrice * taxRate).round();
  }

  num calculateGrandTotal() {
    return calculateTotalPrice() + calculateTax();
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
