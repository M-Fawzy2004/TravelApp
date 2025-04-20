import 'package:travel_app/feature/add_travel/data/model/trip_model.dart';

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