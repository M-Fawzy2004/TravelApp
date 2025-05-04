import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:latlong2/latlong.dart';
import 'package:travel_app/feature/share_location/presentation/view/widget/location_info_section.dart';

class LocationBottomSheet extends StatefulWidget {
  final LatLng point;
  final VoidCallback? onNavigatePressed;

  const LocationBottomSheet({
    super.key,
    required this.point,
    this.onNavigatePressed,
  });

  @override
  State<LocationBottomSheet> createState() => _LocationBottomSheetState();
}

class _LocationBottomSheetState extends State<LocationBottomSheet> {
  String? locationName;
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    fetchLocationName();
  }

  Future<void> fetchLocationName() async {
    try {
      final url = Uri.parse(
        'https://nominatim.openstreetmap.org/reverse?lat=${widget.point.latitude}&lon=${widget.point.longitude}&format=json',
      );

      // Add user agent for OpenStreetMap API policy compliance
      final response = await http.get(
        url,
        headers: {
          'User-Agent': 'TravelApp/1.0 (contact@travelapp.com)',
        },
      );

      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        String display;

        // Check if there's a meaningful display name
        if (data.containsKey('display_name') && data['display_name'] != null) {
          display = data['display_name'];
        }
        // Try to construct a name from address components
        else if (data.containsKey('address')) {
          final address = data['address'];
          final List<String> addressParts = [];

          // Check for common address components
          if (address.containsKey('road')) addressParts.add(address['road']);
          if (address.containsKey('suburb')) {
            addressParts.add(address['suburb']);
          }
          if (address.containsKey('city')) addressParts.add(address['city']);
          if (address.containsKey('state')) addressParts.add(address['state']);
          if (address.containsKey('country')) {
            addressParts.add(address['country']);
          }

          display = addressParts.isNotEmpty
              ? addressParts.join(', ')
              : 'موقع غير معروف';
        } else {
          display = 'موقع غير معروف';
        }

        setState(() {
          locationName = display;
          isLoading = false;
        });
      } else {
        setState(() {
          locationName = 'موقع غير معروف';
          isLoading = false;
        });
      }
    } catch (e) {
      setState(() {
        locationName = 'موقع غير معروف';
        isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return LocationInfoSection(
      isLoading: isLoading,
      locationName: locationName,
      widget: widget,
    );
  }
}
