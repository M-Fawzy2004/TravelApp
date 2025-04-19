import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:http/http.dart' as http;
import 'package:latlong2/latlong.dart';
import 'package:location/location.dart';

class MapView extends StatefulWidget {
  const MapView({super.key});

  @override
  _MapViewState createState() => _MapViewState();
}

class _MapViewState extends State<MapView> {
  final MapController mapController = MapController();
  LocationData? currentLocation;
  List<LatLng> routePoints = [];
  List<Marker> markers = [];
  final String orsApiKey =
      '5b3ce3597851110001cf624879d2f923a0ad439da69f24ba7272555e';
  bool isLoading = true;
  String errorMessage = '';

  final LatLng egyptCenter = LatLng(26.8206, 30.8025);
  final double initialZoom = 6.0;

  @override
  void initState() {
    super.initState();
    setState(() {
      isLoading = false;
    });
    _getCurrentLocation();
  }

  Future<void> _getCurrentLocation() async {
    var location = Location();

    // Check if location service is enabled
    bool serviceEnabled = await location.serviceEnabled();
    if (!serviceEnabled) {
      serviceEnabled = await location.requestService();
      if (!serviceEnabled) {
        print("خدمة الموقع معطلة");
        return;
      }
    }

    // Check if permission is granted
    PermissionStatus permissionGranted = await location.hasPermission();
    if (permissionGranted == PermissionStatus.denied) {
      permissionGranted = await location.requestPermission();
      if (permissionGranted != PermissionStatus.granted) {
        print("تم رفض إذن الوصول للموقع");
        return;
      }
    }

    try {
      print("جاري الحصول على الموقع...");
      var userLocation = await location.getLocation();
      print(
          "تم الحصول على الموقع: ${userLocation.latitude}, ${userLocation.longitude}");

      bool isInEgypt = userLocation.latitude! <= 31.8 &&
          userLocation.latitude! >= 22.0 &&
          userLocation.longitude! <= 37.0 &&
          userLocation.longitude! >= 25.0;

      if (mounted) {
        setState(() {
          currentLocation = userLocation;

          if (isInEgypt) {
            markers.add(
              Marker(
                width: 80.0,
                height: 80.0,
                point: LatLng(userLocation.latitude!, userLocation.longitude!),
                child: const Icon(Icons.my_location,
                    color: Colors.blue, size: 40.0),
              ),
            );
            mapController.move(
              LatLng(userLocation.latitude!, userLocation.longitude!),
              12.0,
            );
          }
        });
      }
    } catch (e) {
      print("خطأ في الحصول على الموقع: $e");
    }

    location.onLocationChanged.listen((LocationData newLocation) {
      if (mounted) {
        setState(() {
          currentLocation = newLocation;
        });
      }
    });
  }

  Future<void> _getRoute(LatLng destination) async {
    if (currentLocation == null) return;

    final start =
        LatLng(currentLocation!.latitude!, currentLocation!.longitude!);

    try {
      final response = await http.get(
        Uri.parse(
            'https://api.openrouteservice.org/v2/directions/driving-car?api_key=$orsApiKey&start=${start.longitude},${start.latitude}&end=${destination.longitude},${destination.latitude}'),
      );

      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        final List<dynamic> coords =
            data['features'][0]['geometry']['coordinates'];
        if (mounted) {
          setState(() {
            routePoints =
                coords.map((coord) => LatLng(coord[1], coord[0])).toList();
          });
        }
      } else {
        print('فشل في الحصول على المسار: ${response.statusCode}');
        print('رد الخادم: ${response.body}');
      }
    } catch (e) {
      print('خطأ أثناء الاتصال بخدمة المسارات: $e');
    }
  }

  void _addDestinationMarker(LatLng point) {
    bool isInEgypt = point.latitude <= 31.8 &&
        point.latitude >= 22.0 &&
        point.longitude <= 37.0 &&
        point.longitude >= 25.0;

    if (!isInEgypt) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text("يرجى اختيار نقطة داخل مصر فقط"),
          duration: Duration(seconds: 2),
        ),
      );
      return;
    }

    setState(() {
      markers.removeWhere((marker) =>
          marker.child is Icon &&
          (marker.child as Icon).icon == Icons.location_on);

      markers.add(
        Marker(
          width: 80.0,
          height: 80.0,
          point: point,
          child: const Icon(Icons.location_on, color: Colors.red, size: 40.0),
        ),
      );
    });

    if (currentLocation != null) {
      _getRoute(point);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: isLoading
          ? const Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  CircularProgressIndicator(),
                  SizedBox(height: 20),
                  Text("جاري تحميل الخريطة...", textAlign: TextAlign.center),
                ],
              ),
            )
          : errorMessage.isNotEmpty
              ? Center(
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Icon(Icons.error_outline,
                            size: 48, color: Colors.red),
                        const SizedBox(height: 16),
                        Text(
                          errorMessage,
                          textAlign: TextAlign.center,
                          style: const TextStyle(fontSize: 16),
                        ),
                        const SizedBox(height: 24),
                        ElevatedButton(
                          onPressed: () {
                            setState(() {
                              isLoading = true;
                              errorMessage = '';
                            });
                            _getCurrentLocation();
                          },
                          child: const Text("إعادة المحاولة"),
                        ),
                      ],
                    ),
                  ),
                )
              : FlutterMap(
                  mapController: mapController,
                  options: MapOptions(
                    initialCenter: egyptCenter,
                    initialZoom: initialZoom,
                    onTap: (tapPosition, point) => _addDestinationMarker(point),
                    minZoom: 5.0,
                    maxZoom: 18.0,
                    cameraConstraint: CameraConstraint.contain(
                      bounds: LatLngBounds(
                        LatLng(22.0, 25.0),
                        LatLng(31.8, 37.0),
                      ),
                    ),
                  ),
                  children: [
                    TileLayer(
                      urlTemplate:
                          "https://{s}.tile.openstreetmap.org/{z}/{x}/{y}.png",
                      subdomains: const ['a', 'b', 'c'],
                    ),
                    MarkerLayer(
                      markers: markers,
                    ),
                    if (routePoints.isNotEmpty)
                      PolylineLayer(
                        polylines: [
                          Polyline(
                            points: routePoints,
                            strokeWidth: 4.0,
                            color: Colors.blue,
                          ),
                        ],
                      ),
                  ],
                ),
      floatingActionButton: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          FloatingActionButton(
            onPressed: () {
              mapController.move(egyptCenter, initialZoom);
            },
            heroTag: "showEgypt",
            child: const Icon(Icons.home),
          ),
          const SizedBox(height: 16),
          if (currentLocation != null)
            FloatingActionButton(
              onPressed: () {
                mapController.move(
                  LatLng(
                      currentLocation!.latitude!, currentLocation!.longitude!),
                  15.0,
                );
              },
              heroTag: "myLocation",
              child: const Icon(Icons.my_location),
            ),
        ],
      ),
    );
  }
}
