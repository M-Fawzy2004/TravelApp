import 'dart:convert';

import 'package:http/http.dart' as http;

class LocationDataSource {
  // search location
  Future<List<dynamic>> searchLocation(String query) async {
    // constant url
    final url = Uri.parse(
      "https://nominatim.openstreetmap.org/search?q=$query&format=json&limit=1",
    );

    // response time out
    final response = await http.get(url).timeout(
      const Duration(seconds: 10),
      onTimeout: () {
        throw Exception('البحث استغرق وقتًا طويلًا');
      },
    );

    // check status code
    if (response.statusCode == 200) {
      return json.decode(response.body);
    } else {
      throw Exception('خطأ في البحث: ${response.statusCode}');
    }
  }

  // get route
  Future<Map<String, dynamic>> getRoute(
    double startLongitude,
    double startLatitude,
    double endLongitude,
    double endLatitude,
  ) async {
    // constant url
    final url = Uri.parse(
      'http://router.project-osrm.org/route/v1/driving/$startLongitude,$startLatitude;$endLongitude,$endLatitude?overview=full&geometries=polyline',
    );

    // response time out
    final response = await http.get(url).timeout(
      const Duration(seconds: 15),
      onTimeout: () {
        throw Exception('جلب المسار استغرق وقتًا طويلًا');
      },
    );

    // check status code
    if (response.statusCode == 200) {
      return json.decode(response.body);
    } else {
      throw Exception('خطاء في جلب المسار: ${response.statusCode}');
    }
  }
}
