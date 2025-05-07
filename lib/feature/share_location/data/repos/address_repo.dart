import 'dart:convert';
import 'package:geocoding/geocoding.dart';
import 'package:http/http.dart' as http;
import 'package:travel_app/feature/share_location/data/data_source/address_data_source.dart';

class AddressRepository {
  final AddressDataSource dataSource;

  AddressRepository({required this.dataSource});

  Future<String> getAddressFromCoordinates(double latitude, double longitude) async {
    try {
      // First try with Nominatim API
      final response = await http
          .get(
            Uri.parse(
              'https://nominatim.openstreetmap.org/reverse?lat=$latitude&lon=$longitude&format=json',
            ),
          )
          .timeout(const Duration(seconds: 5));

      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        if (data.containsKey('display_name')) {
          return data['display_name'];
        }
      }

      // Fall back to geocoding package
      final placemarks = await placemarkFromCoordinates(latitude, longitude);
      if (placemarks.isNotEmpty) {
        final place = placemarks.first;
        return [
          place.street,
          place.subLocality,
          place.locality,
          place.administrativeArea,
          place.country,
        ].where((element) => element != null && element.isNotEmpty).join(', ');
      }
      
      return 'موقع غير معروف';
    } catch (e) {
      return 'موقع غير معروف';
    }
  }

  Future<bool> saveUserLocation(
    String userId, 
    double latitude, 
    double longitude, 
    String locationName
  ) async {
    try {
      return await dataSource.saveUserLocation(
        userId, 
        latitude, 
        longitude, 
        locationName,
      );
    } catch (e) {
      throw Exception('فشل في حفظ الموقع: $e');
    }
  }
}