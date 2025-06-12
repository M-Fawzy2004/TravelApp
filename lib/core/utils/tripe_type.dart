import 'package:travel_app/feature/add_travel/data/model/trip_model.dart';

String getTripTypeInArabic(TripType type) {
  switch (type) {
    case TripType.specialTrip:
      return 'رحلة خاصة';
    case TripType.privateDelivery:
      return 'توصيل خاص';
  }
}

TripType mapStringToTripType(String type) {
  switch (type) {
    case 'رحلة خاصة':
      return TripType.specialTrip;
    case 'توصيل خاص':
      return TripType.privateDelivery;
    default:
      return TripType.specialTrip;
  }
}
