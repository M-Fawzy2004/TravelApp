import 'dart:async';

import 'package:flutter_polyline_points/flutter_polyline_points.dart';
import 'package:latlong2/latlong.dart';
import 'package:location/location.dart';
import 'package:travel_app/feature/share_location/data/data_source/location_data_source.dart';

class LocationRepository {
  final LocationDataSource locationDataSource;
  final Location location = Location();

  LocationRepository({required this.locationDataSource});

  // get current location
  Future<LocationData> getCurrentLocation() async {
    try {
      // check permission
      final locationData = await location.getLocation().timeout(
        const Duration(seconds: 10),
        onTimeout: () {
          throw TimeoutException('استغرق الحصول على الموقع وقتًا طويلاً');
        },
      );
      return locationData;
    } catch (e) {
      // exception
      throw Exception('فشل في الحصول على الموقع الحالي: $e');
    }
  }

  // search location
  Future<LatLng?> searchLocation(String query) async {
    try {
      // response
      final result = await locationDataSource.searchLocation(query);
      // check result is not empty
      if (result.isNotEmpty) {
        final lat = double.parse(result[0]['lat']);
        final lon = double.parse(result[0]['lon']);
        return LatLng(lat, lon);
      }
      return null;
    } catch (e) {
      // exception
      throw Exception('فشل في البحث عن الموقع: $e');
    }
  }

  // get route
  Future<List<LatLng>> getRoute(
    LatLng start,
    LatLng end,
  ) async {
    try {
      // response
      final routeData = await locationDataSource.getRoute(
        start.longitude,
        start.latitude,
        end.longitude,
        end.latitude,
      );
      if (routeData['routes'] != null && routeData['routes'].isNotEmpty) {
        final geometry = routeData['routes'][0]['geometry'];
        return _decodePolyline(geometry);
      }
      return [];
    } catch (e) {
      throw Exception('فشل في الحصول على المسار: $e');
    }
  }

  List<LatLng> _decodePolyline(String encodedPolyline) {
    try {
      PolylinePoints polylinePoints = PolylinePoints();
      List<PointLatLng> decodedPolyline =
          polylinePoints.decodePolyline(encodedPolyline);

      return decodedPolyline
          .map(
            (point) => LatLng(
              point.latitude,
              point.longitude,
            ),
          )
          .toList();
    } catch (e) {
      return [];
    }
  }
}
