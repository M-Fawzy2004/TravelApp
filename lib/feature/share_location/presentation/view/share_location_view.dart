// ignore_for_file: use_build_context_synchronously

import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:flutter_polyline_points/flutter_polyline_points.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:http/http.dart' as http;
import 'package:latlong2/latlong.dart';
import 'package:location/location.dart';
import 'package:travel_app/core/helper/extension.dart';
import 'package:travel_app/core/theme/app_color.dart';
import 'package:travel_app/core/theme/styles.dart';
import 'package:travel_app/core/utils/top_snakbar_app.dart';
import 'package:travel_app/feature/share_location/presentation/view/widget/share_location_view_body.dart';
import 'package:travel_app/feature/share_location/presentation/view/widget/location_bottom_sheet.dart';

class ShareLocationView extends StatefulWidget {
  const ShareLocationView({super.key});

  @override
  State<ShareLocationView> createState() => _ShareLocationViewState();
}

class _ShareLocationViewState extends State<ShareLocationView> {
  final MapController mapController = MapController();
  final Location location = Location();
  final TextEditingController locationController = TextEditingController();
  bool isLocationLoading = true;
  LatLng? currentLocation;
  LatLng? destinationLocation;
  LatLng? selectedLocation;

  List<LatLng> route = [];
  bool isRouteVisible = false;

  @override
  void initState() {
    super.initState();
    initializeLocation();
  }

  @override
  void dispose() {
    locationController.dispose();
    location.onLocationChanged.listen(null).cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 2,
        scrolledUnderElevation: 0,
        title: Text(
          'مشاركة الموقع',
          style: Styles.font20ExtraBlackBold,
        ),
        centerTitle: true,
        leading: IconButton(
          onPressed: () {
            context.pop();
          },
          icon: const Icon(FontAwesomeIcons.arrowRight),
        ),
        actions: [
          // Clear route button if route is visible
          if (isRouteVisible)
            IconButton(
              onPressed: () {
                setState(() {
                  route.clear();
                  isRouteVisible = false;
                  destinationLocation = null;
                });
              },
              icon: Icon(
                FontAwesomeIcons.xmark,
                size: 20.sp,
              ),
              tooltip: 'إزالة المسار',
            ),
        ],
      ),
      floatingActionButton: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          FloatingActionButton(
            heroTag: 'currentLocation',
            onPressed: userCurrentLocation,
            backgroundColor: AppColors.primaryColor,
            child: Icon(
              FontAwesomeIcons.locationCrosshairs,
              size: 24.sp,
              color: AppColors.white,
            ),
          ),
          SizedBox(height: 16.h),
          // Show buttons in a row to save space
          Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              FloatingActionButton(
                heroTag: 'zoomOut',
                onPressed: () {
                  final currentZoom = mapController.camera.zoom;
                  mapController.move(mapController.camera.center, currentZoom - 1);
                },
                backgroundColor: AppColors.primaryColor,
                mini: true,
                child: Icon(
                  FontAwesomeIcons.minus,
                  size: 18.sp,
                  color: AppColors.white,
                ),
              ),
              SizedBox(width: 8.w),
              FloatingActionButton(
                heroTag: 'zoomIn',
                onPressed: () {
                  final currentZoom = mapController.camera.zoom;
                  mapController.move(mapController.camera.center, currentZoom + 1);
                },
                backgroundColor: AppColors.primaryColor,
                mini: true,
                child: Icon(
                  FontAwesomeIcons.plus,
                  size: 18.sp,
                  color: AppColors.white,
                ),
              ),
            ],
          ),
        ],
      ),
      body: Stack(
        children: [
          SafeArea(
            child: ShareLocationViewBody(
              mapController: mapController,
              currentLocation: currentLocation,
              destinationLocation: destinationLocation,
              selectedLocation: selectedLocation,
              route: route,
              isRouteVisible: isRouteVisible,
              controller: locationController,
              onSearchSubmitted: (query) {
                fetchCoordinatesPoints(query);
              },
              onMapTap: (point) {
                setState(() {
                  selectedLocation = point;
                });
                showLocationBottomSheet(point);
              },
            ),
          ),
          // Loading indicator
          if (isLocationLoading)
            Container(
              color: Colors.black.withOpacity(0.3),
              child: const Center(
                child: CircularProgressIndicator(),
              ),
            ),
        ],
      ),
    );
  }

  void showLocationBottomSheet(LatLng point) {
    showModalBottomSheet(
      context: context,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20.r)),
      ),
      builder: (context) => LocationBottomSheet(
        point: point,
        onNavigatePressed: () {
          Navigator.pop(context);
          setState(() {
            destinationLocation = point;
          });
          fetchRoute();
        },
      ),
    );
  }

  Future<void> userCurrentLocation() async {
    if (currentLocation != null) {
      mapController.move(currentLocation!, 15);
    } else {
      showCustomTopSnackBar(
        context: context,
        message: 'هذا الموقع غير متوفر',
      );
    }
  }

  Future<void> initializeLocation() async {
    if (!await checkRequestPermission()) return;

    final locationData = await location.getLocation();
    if (locationData.latitude != null && locationData.longitude != null) {
      setState(() {
        currentLocation = LatLng(locationData.latitude!, locationData.longitude!);
        isLocationLoading = false;
      });
      mapController.move(currentLocation!, 15);
    }

    location.onLocationChanged.listen((LocationData locationData) {
      if (locationData.latitude != null && locationData.longitude != null) {
        setState(() {
          currentLocation = LatLng(locationData.latitude!, locationData.longitude!);
          isLocationLoading = false;
        });
      }
    });
  }

  Future<bool> checkRequestPermission() async {
    bool serviceEnabled = await location.serviceEnabled();
    if (!serviceEnabled) {
      serviceEnabled = await location.requestService();
      if (!serviceEnabled) {
        showCustomTopSnackBar(
          context: context,
          message: 'يرجى تفعيل خدمة الموقع',
        );
        return false;
      }
    }

    PermissionStatus permissionGranted = await location.hasPermission();
    if (permissionGranted == PermissionStatus.denied) {
      permissionGranted = await location.requestPermission();
      if (permissionGranted != PermissionStatus.granted) {
        showCustomTopSnackBar(
          context: context,
          message: 'يرجى السماح بالوصول إلى الموقع',
        );
        return false;
      }
    }

    return true;
  }

  Future<void> fetchCoordinatesPoints(String locationQuery) async {
    if (locationQuery.isEmpty) return;

    setState(() {
      isLocationLoading = true;
    });

    final url = Uri.parse(
        "https://nominatim.openstreetmap.org/search?q=$locationQuery&format=json&limit=1");
    try {
      final response = await http.get(url);
      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        if (data.isNotEmpty) {
          final lat = double.parse(data[0]['lat']);
          final lon = double.parse(data[0]['lon']);
          final newLocation = LatLng(lat, lon);
          
          setState(() {
            selectedLocation = newLocation;
            isLocationLoading = false;
          });
          
          mapController.move(newLocation, 15);
          showLocationBottomSheet(newLocation);
        } else {
          setState(() {
            isLocationLoading = false;
          });
          showCustomTopSnackBar(
            context: context,
            message: 'هذا الموقع غير متوفر',
          );
        }
      } else {
        setState(() {
          isLocationLoading = false;
        });
        showCustomTopSnackBar(
          context: context,
          message: 'خطأ في البحث، يرجى المحاولة مرة أخرى',
        );
      }
    } catch (e) {
      setState(() {
        isLocationLoading = false;
      });
      showCustomTopSnackBar(
        context: context,
        message: 'حدث خطأ أثناء البحث، يرجى التحقق من اتصال الإنترنت',
      );
    }
  }

  Future<void> fetchRoute() async {
    if (currentLocation != null && destinationLocation != null) {
      setState(() {
        isLocationLoading = true;
      });

      try {
        final url = Uri.parse(
          'http://router.project-osrm.org/route/v1/driving/${currentLocation!.longitude},${currentLocation!.latitude};${destinationLocation!.longitude},${destinationLocation!.latitude}?overview=full&geometries=polyline',
        );
        final response = await http.get(url);
        if (response.statusCode == 200) {
          final data = json.decode(response.body);
          final geometry = data['routes'][0]['geometry'];
          decodePolyline(geometry);
          
          // Set the map view to show the entire route
          if (route.isNotEmpty) {
            final bounds = LatLngBounds.fromPoints(route);
            mapController.fitCamera(
              CameraFit.bounds(
                bounds: bounds,
                padding: const EdgeInsets.all(50.0),
              ),
            );
          }
          
          setState(() {
            isRouteVisible = true;
            isLocationLoading = false;
          });
        } else {
          setState(() {
            isLocationLoading = false;
          });
          showCustomTopSnackBar(
            context: context,
            message: 'خطأ في التحميل، يرجى المحاولة مرة أخرى',
          );
        }
      } catch (e) {
        setState(() {
          isLocationLoading = false;
        });
        showCustomTopSnackBar(
          context: context,
          message: 'حدث خطأ أثناء تحميل المسار، يرجى التحقق من اتصال الإنترنت',
        );
      }
    }
  }

  void decodePolyline(String encodedPolyline) {
    PolylinePoints polylinePoints = PolylinePoints();
    List<PointLatLng> decodedPolyline =
        polylinePoints.decodePolyline(encodedPolyline);

    setState(() {
      route = decodedPolyline
          .map((point) => LatLng(point.latitude, point.longitude))
          .toList();
    });
  }
}