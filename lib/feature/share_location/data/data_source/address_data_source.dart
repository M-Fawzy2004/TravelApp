import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:travel_app/constant.dart';

class AddressDataSource {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<bool> saveUserLocation(
    String userId,
    double latitude,
    double longitude,
    String locationName,
  ) async {
    try {
      // Create a GeoPoint for Firestore
      final GeoPoint geoPoint = GeoPoint(latitude, longitude);

      // Create location document
      final locationData = {
        'name': locationName,
        'coordinates': geoPoint,
        'timestamp': FieldValue.serverTimestamp(),
      };

      // Save to user's saved locations collection
      await _firestore
          .collection(kUsers)
          .doc(userId)
          .collection('savedLocations')
          .add(locationData);

      return true;
    } catch (e) {
      throw Exception('فشل في حفظ الموقع: $e');
    }
  }
}
