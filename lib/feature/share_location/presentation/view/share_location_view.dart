// Enhanced version of ShareLocationView to fix crashes
// ignore_for_file: use_build_context_synchronously

import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:flutter_polyline_points/flutter_polyline_points.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:http/http.dart' as http;
import 'package:latlong2/latlong.dart';
import 'package:location/location.dart';
import 'package:travel_app/core/helper/extension.dart';
import 'package:travel_app/core/helper/spacing.dart';
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

  // Stream subscription for proper cleanup
  StreamSubscription<LocationData>? _locationSubscription;

  bool isLocationLoading = true;
  LatLng? currentLocation;
  LatLng? destinationLocation;
  LatLng? selectedLocation;

  List<LatLng> route = [];
  bool isRouteVisible = false;

  // Flag to track if the widget is mounted
  bool _isMounted = false;

  @override
  void initState() {
    super.initState();
    _isMounted = true;
    // Use a future delayed to allow the widget to fully build before accessing location
    Future.delayed(Duration.zero, () {
      if (_isMounted) {
        initializeLocation();
      }
    });
  }

  @override
  void dispose() {
    locationController.dispose();

    // Cancel the subscription properly
    _locationSubscription?.cancel();

    // Mark widget as unmounted
    _isMounted = false;

    super.dispose();
  }

  // Safe setState that checks if the widget is still mounted
  void setStateIfMounted(VoidCallback fn) {
    if (_isMounted && mounted) {
      setState(fn);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 2,
        scrolledUnderElevation: 0,
        title: Text(
          'مشاركة موقعك',
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
                setStateIfMounted(() {
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
          heightBox(16),
          // Show buttons in a row to save space
          Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              FloatingActionButton(
                heroTag: 'zoomOut',
                onPressed: () {
                  try {
                    final currentZoom = mapController.camera.zoom;
                    mapController.move(
                      mapController.camera.center,
                      currentZoom - 1,
                    );
                  } catch (e) {
                    // Ignore map controller errors
                  }
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
                  try {
                    final currentZoom = mapController.camera.zoom;
                    mapController.move(
                      mapController.camera.center,
                      currentZoom + 1,
                    );
                  } catch (e) {
                    // Ignore map controller errors
                  }
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
                setStateIfMounted(() {
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
              child: Center(
                child: SpinKitCircle(
                  color: AppColors.primaryColor,
                  size: 50.h,
                ),
              ),
            ),
        ],
      ),
    );
  }

  void showLocationBottomSheet(LatLng point) {
    if (!mounted) return;

    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20.r)),
      ),
      builder: (context) => LocationBottomSheet(
        point: point,
        onNavigatePressed: () {
          Navigator.pop(context);
          if (mounted) {
            setStateIfMounted(() {
              destinationLocation = point;
            });
            fetchRoute();
          }
        },
      ),
    );
  }

  Future<void> userCurrentLocation() async {
    if (currentLocation != null) {
      try {
        mapController.move(currentLocation!, 15);
      } catch (e) {
        // Handle map controller errors
        debugPrint('Error moving map controller: $e');
      }
    } else {
      if (mounted) {
        showCustomTopSnackBar(
          context: context,
          message: 'هذا الموقع غير متوفر',
        );
      }
    }
  }

  Future<void> initializeLocation() async {
    try {
      if (!await checkRequestPermission()) return;

      setStateIfMounted(() {
        isLocationLoading = true;
      });

      final locationData = await location.getLocation().timeout(
        const Duration(seconds: 10),
        onTimeout: () {
          if (mounted) {
            showCustomTopSnackBar(
              context: context,
              message:
                  'استغرق الحصول على الموقع وقتًا طويلاً، يرجى المحاولة مرة أخرى',
            );
          }
          return LocationData.fromMap({});
        },
      );

      if (!_isMounted) return;

      if (locationData.latitude != null && locationData.longitude != null) {
        setStateIfMounted(() {
          currentLocation =
              LatLng(locationData.latitude!, locationData.longitude!);
          isLocationLoading = false;
        });

        try {
          mapController.move(currentLocation!, 15);
        } catch (e) {
          debugPrint('Error moving map: $e');
        }
      } else {
        setStateIfMounted(() {
          isLocationLoading = false;
        });
      }

      // Subscribe to location changes with proper error handling
      _locationSubscription = location.onLocationChanged.listen(
        (LocationData locationData) {
          if (!_isMounted) return;

          if (locationData.latitude != null && locationData.longitude != null) {
            setStateIfMounted(() {
              currentLocation =
                  LatLng(locationData.latitude!, locationData.longitude!);
            });
          }
        },
        onError: (error) {
          debugPrint('Location subscription error: $error');
        },
        cancelOnError: false,
      );
    } catch (e) {
      debugPrint('Error initializing location: $e');
      if (mounted) {
        setStateIfMounted(() {
          isLocationLoading = false;
        });
        showCustomTopSnackBar(
          context: context,
          message: 'حدث خطأ أثناء تحديد موقعك',
        );
      }
    }
  }

  Future<bool> checkRequestPermission() async {
    try {
      bool serviceEnabled = await location.serviceEnabled();
      if (!serviceEnabled) {
        serviceEnabled = await location.requestService();
        if (!serviceEnabled) {
          if (mounted) {
            showCustomTopSnackBar(
              context: context,
              message: 'يرجى تفعيل خدمة الموقع',
            );
          }
          setStateIfMounted(() {
            isLocationLoading = false;
          });
          return false;
        }
      }

      PermissionStatus permissionGranted = await location.hasPermission();
      if (permissionGranted == PermissionStatus.denied) {
        permissionGranted = await location.requestPermission();
        if (permissionGranted != PermissionStatus.granted) {
          if (mounted) {
            showCustomTopSnackBar(
              context: context,
              message: 'يرجى السماح بالوصول إلى الموقع',
            );
          }
          setStateIfMounted(() {
            isLocationLoading = false;
          });
          return false;
        }
      }

      return true;
    } catch (e) {
      debugPrint('Permission check error: $e');
      setStateIfMounted(() {
        isLocationLoading = false;
      });
      return false;
    }
  }

  Future<void> fetchCoordinatesPoints(String locationQuery) async {
    if (locationQuery.isEmpty || !mounted) return;

    setStateIfMounted(() {
      isLocationLoading = true;
    });

    try {
      final url = Uri.parse(
          "https://nominatim.openstreetmap.org/search?q=$locationQuery&format=json&limit=1");

      final response = await http.get(url).timeout(
        const Duration(seconds: 10),
        onTimeout: () {
          throw TimeoutException('البحث استغرق وقتًا طويلًا');
        },
      );

      if (!_isMounted) return;

      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        if (data.isNotEmpty) {
          final lat = double.parse(data[0]['lat']);
          final lon = double.parse(data[0]['lon']);
          final newLocation = LatLng(lat, lon);

          setStateIfMounted(() {
            selectedLocation = newLocation;
            isLocationLoading = false;
          });

          try {
            mapController.move(newLocation, 15);
          } catch (e) {
            debugPrint('Error moving map: $e');
          }

          showLocationBottomSheet(newLocation);
        } else {
          setStateIfMounted(() {
            isLocationLoading = false;
          });
          if (mounted) {
            showCustomTopSnackBar(
              context: context,
              message: 'هذا الموقع غير متوفر',
            );
          }
        }
      } else {
        setStateIfMounted(() {
          isLocationLoading = false;
        });
        if (mounted) {
          showCustomTopSnackBar(
            context: context,
            message: 'خطأ في البحث، يرجى المحاولة مرة أخرى',
          );
        }
      }
    } catch (e) {
      debugPrint('Error fetching coordinates: $e');
      if (_isMounted) {
        setStateIfMounted(() {
          isLocationLoading = false;
        });
        if (mounted) {
          showCustomTopSnackBar(
            context: context,
            message: 'حدث خطأ أثناء البحث، يرجى التحقق من اتصال الإنترنت',
          );
        }
      }
    }
  }

  Future<void> fetchRoute() async {
    if (currentLocation == null || destinationLocation == null || !mounted)
      return;

    setStateIfMounted(() {
      isLocationLoading = true;
    });

    try {
      final url = Uri.parse(
        'http://router.project-osrm.org/route/v1/driving/${currentLocation!.longitude},${currentLocation!.latitude};${destinationLocation!.longitude},${destinationLocation!.latitude}?overview=full&geometries=polyline',
      );

      final response = await http.get(url).timeout(
        const Duration(seconds: 15),
        onTimeout: () {
          throw TimeoutException('جلب المسار استغرق وقتًا طويلًا');
        },
      );

      if (!_isMounted) return;

      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        if (data['routes'] != null && data['routes'].isNotEmpty) {
          final geometry = data['routes'][0]['geometry'];
          decodePolyline(geometry);

          // Set the map view to show the entire route
          if (route.isNotEmpty) {
            try {
              final bounds = LatLngBounds.fromPoints(route);
              mapController.fitCamera(
                CameraFit.bounds(
                  bounds: bounds,
                  padding: const EdgeInsets.all(50.0),
                ),
              );
            } catch (e) {
              debugPrint('Error fitting camera to bounds: $e');
            }
          }

          setStateIfMounted(() {
            isRouteVisible = true;
            isLocationLoading = false;
          });
        } else {
          setStateIfMounted(() {
            isLocationLoading = false;
          });
          if (mounted) {
            showCustomTopSnackBar(
              context: context,
              message: 'لا يمكن إيجاد مسار للوجهة المحددة',
            );
          }
        }
      } else {
        setStateIfMounted(() {
          isLocationLoading = false;
        });
        if (mounted) {
          showCustomTopSnackBar(
            context: context,
            message: 'خطأ في التحميل، يرجى المحاولة مرة أخرى',
          );
        }
      }
    } catch (e) {
      debugPrint('Error fetching route: $e');
      if (_isMounted) {
        setStateIfMounted(() {
          isLocationLoading = false;
        });
        if (mounted) {
          showCustomTopSnackBar(
            context: context,
            message:
                'حدث خطأ أثناء تحميل المسار، يرجى التحقق من اتصال الإنترنت',
          );
        }
      }
    }
  }

  void decodePolyline(String encodedPolyline) {
    try {
      PolylinePoints polylinePoints = PolylinePoints();
      List<PointLatLng> decodedPolyline =
          polylinePoints.decodePolyline(encodedPolyline);

      setStateIfMounted(() {
        route = decodedPolyline
            .map((point) => LatLng(point.latitude, point.longitude))
            .toList();
      });
    } catch (e) {
      debugPrint('Error decoding polyline: $e');
      setStateIfMounted(() {
        route = [];
      });
    }
  }
}
