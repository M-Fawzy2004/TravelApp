// ignore_for_file: deprecated_member_use, avoid_print

import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:http/http.dart' as http;
import 'package:latlong2/latlong.dart';
import 'package:location/location.dart';
import 'package:travel_app/core/helper/extension.dart';
import 'package:travel_app/core/helper/spacing.dart';
import 'package:travel_app/core/theme/styles.dart';
import 'package:travel_app/core/utils/app_flush_bar.dart';

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
  Location location = Location();
  Stream<LocationData>? locationSubscription;

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

  @override
  void dispose() {
    location.onLocationChanged.listen(null).cancel();
    mapController.dispose();
    super.dispose();
  }

  Future<void> _getCurrentLocation() async {
    try {
      bool serviceEnabled = await location.serviceEnabled();
      if (!serviceEnabled) {
        serviceEnabled = await location.requestService();
        if (!serviceEnabled) {
          if (!mounted) return;
          setState(() {
            errorMessage = "خدمة الموقع معطلة، يرجى تفعيلها للاستمرار";
            isLoading = false;
          });
          return;
        }
      }

      PermissionStatus permissionGranted = await location.hasPermission();
      if (permissionGranted == PermissionStatus.denied) {
        permissionGranted = await location.requestPermission();
        if (permissionGranted != PermissionStatus.granted) {
          if (!mounted) return;
          setState(() {
            errorMessage = "تم رفض إذن الوصول للموقع";
            isLoading = false;
          });
          return;
        }
      }

      print("جاري الحصول على الموقع...");
      var userLocation = await location.getLocation();
      print(
          "تم الحصول على الموقع: ${userLocation.latitude}, ${userLocation.longitude}");

      if (!mounted) return;

      bool isInEgypt = userLocation.latitude! <= 31.8 &&
          userLocation.latitude! >= 22.0 &&
          userLocation.longitude! <= 37.0 &&
          userLocation.longitude! >= 25.0;

      setState(() {
        currentLocation = userLocation;

        if (isInEgypt) {
          _updateCurrentLocationMarker();
          mapController.move(
            LatLng(userLocation.latitude!, userLocation.longitude!),
            12.0,
          );
        }
      });

      location.onLocationChanged.listen((LocationData newLocation) {
        if (mounted) {
          setState(() {
            currentLocation = newLocation;
            _updateCurrentLocationMarker();
          });
        }
      });
    } catch (e) {
      print("خطأ في الحصول على الموقع: $e");
      if (!mounted) return;
      setState(() {
        errorMessage = "حدث خطأ أثناء محاولة الوصول إلى موقعك: $e";
        isLoading = false;
      });
    }
  }

  void _updateCurrentLocationMarker() {
    if (currentLocation == null) return;

    markers.removeWhere((marker) =>
        marker.child is Icon &&
        (marker.child as Icon).icon == Icons.my_location);

    markers.add(
      Marker(
        width: 80.0,
        height: 80.0,
        point: LatLng(currentLocation!.latitude!, currentLocation!.longitude!),
        child: const Icon(Icons.my_location, color: Colors.blue, size: 40.0),
      ),
    );
  }

  Future<void> _getRoute(LatLng destination) async {
    if (currentLocation == null) return;

    setState(() {
      isLoading = true;
      routePoints = [];
    });

    final start =
        LatLng(currentLocation!.latitude!, currentLocation!.longitude!);

    try {
      final response = await http.get(
        Uri.parse(
            'https://api.openrouteservice.org/v2/directions/driving-car?api_key=$orsApiKey&start=${start.longitude},${start.latitude}&end=${destination.longitude},${destination.latitude}'),
      );

      if (!mounted) return;

      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        final List<dynamic> coords =
            data['features'][0]['geometry']['coordinates'];

        setState(() {
          routePoints =
              coords.map((coord) => LatLng(coord[1], coord[0])).toList();
          isLoading = false;
        });
      } else {
        print('فشل في الحصول على المسار: ${response.statusCode}');
        print('رد الخادم: ${response.body}');
        setState(() {
          errorMessage = "تعذر الحصول على المسار، يرجى المحاولة مرة أخرى";
          isLoading = false;
        });
      }
    } catch (e) {
      print('خطأ أثناء الاتصال بخدمة المسارات: $e');
      if (!mounted) return;
      setState(() {
        errorMessage = "حدث خطأ أثناء محاولة رسم المسار: $e";
        isLoading = false;
      });
    }
  }

  void _addDestinationMarker(LatLng point) {
    bool isInEgypt = point.latitude <= 32.0 &&
        point.latitude >= 21.0 &&
        point.longitude <= 38.0 &&
        point.longitude >= 24.0;

    if (!isInEgypt) {
      CustomFlushBarWidget(
        message: 'الموقع غير صالح، يرجى تحديد الموقع في مصر',
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

  void _resetMap() {
    setState(() {
      routePoints = [];
      markers.clear();
      errorMessage = '';
      if (currentLocation != null) {
        _updateCurrentLocationMarker();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        // مسح البيانات قبل الخروج
        _resetMap();
        return true;
      },
      child: Scaffold(
        appBar: AppBar(
          title: Text(
            'موقعك',
            style: Styles.font18BlackBold,
          ),
          centerTitle: true,
          leading: IconButton(
            onPressed: () {
              _resetMap();
              context.pop();
            },
            icon: const Icon(Icons.arrow_back_ios_new),
          ),
        ),
        body: Stack(
          children: [
            isLoading && errorMessage.isEmpty
                ? const Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        CircularProgressIndicator(),
                        SizedBox(height: 20),
                        Text("جاري تحميل الخريطة...",
                            textAlign: TextAlign.center),
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
                          onTap: (tapPosition, point) =>
                              _addDestinationMarker(point),
                          minZoom: 4.0,
                          maxZoom: 18.0,
                          cameraConstraint: CameraConstraint.contain(
                            bounds: LatLngBounds(
                              LatLng(15.0, 20.0),
                              LatLng(35.0, 40.0),
                            ),
                          ),
                        ),
                        children: [
                          TileLayer(
                            urlTemplate:
                                "https://{s}.tile.openstreetmap.org/{z}/{x}/{y}.png",
                            subdomains: const ['a', 'b', 'c'],
                            tileProvider: NetworkTileProvider(),
                            userAgentPackageName: 'com.example.travel_app',
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
            if (isLoading && errorMessage.isEmpty && routePoints.isEmpty)
              const Positioned.fill(
                child: Center(
                  child: CircularProgressIndicator(),
                ),
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
            heightBox(16),
            if (currentLocation != null)
              FloatingActionButton(
                onPressed: () {
                  mapController.move(
                    LatLng(currentLocation!.latitude!,
                        currentLocation!.longitude!),
                    15.0,
                  );
                },
                heroTag: "myLocation",
                child: const Icon(Icons.my_location),
              ),
            heightBox(16),
            FloatingActionButton(
              onPressed: _resetMap,
              heroTag: "resetMap",
              child: const Icon(Icons.refresh),
            ),
          ],
        ),
      ),
    );
  }
}
