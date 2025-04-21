import 'package:travel_app/feature/add_travel/data/model/trip_model.dart';

String getTripTypeInArabic(TripType type) {
  switch (type) {
    case TripType.specialTrip:
      return 'رحلة خاصة';
    case TripType.delivery:
      return 'توصيل';
    case TripType.cargoShipping:
      return 'شحن أغراض';
  }
}

TripType mapStringToTripType(String type) {
  switch (type) {
    case 'رحلة خاصة':
      return TripType.specialTrip;
    case 'توصيل':
      return TripType.delivery;
    case 'شحن أغراض':
      return TripType.cargoShipping;
    default:
      return TripType.specialTrip;
  }
}
