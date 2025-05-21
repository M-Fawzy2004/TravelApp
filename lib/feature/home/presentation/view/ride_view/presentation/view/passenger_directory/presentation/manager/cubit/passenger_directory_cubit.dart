// ignore_for_file: depend_on_referenced_packages, avoid_print

import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:geolocator/geolocator.dart';
import 'package:geocoding/geocoding.dart';
import 'package:latlong2/latlong.dart';
import 'package:travel_app/feature/home/presentation/view/ride_view/data/model/ride_request_model.dart';
import 'package:travel_app/feature/home/presentation/view/ride_view/data/model/ride_status.dart';
import 'package:uuid/uuid.dart';
import 'dart:math';
import 'package:dio/dio.dart';

part 'passenger_directory_state.dart';

class PassengerDirectoryCubit extends Cubit<PassengerDirectoryState> {
  final Dio _dio = Dio();
  String _lastSearchQuery = '';
  List<LatLng> _cachedRoutePoints = [];
  Timer? _searchDebounceTimer;

  PassengerDirectoryCubit() : super(const PassengerDirectoryInitial());

  @override
  Future<void> close() {
    _searchDebounceTimer?.cancel();
    return super.close();
  }

  // Get current location
  Future<void> getCurrentLocation() async {
    emit(const PassengerDirectoryLoading());
    try {
      LocationPermission permission = await Geolocator.checkPermission();
      if (permission == LocationPermission.denied) {
        permission = await Geolocator.requestPermission();
        if (permission == LocationPermission.denied) {
          emit(const PassengerDirectoryError('تم رفض صلاحية تحديد الموقع'));
          return;
        }
      }

      Position position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high,
      );

      List<Placemark> placemarks = await placemarkFromCoordinates(
        position.latitude,
        position.longitude,
      );

      if (placemarks.isNotEmpty) {
        Placemark placemark = placemarks.first;
        final currentLocation = LatLng(position.latitude, position.longitude);
        final currentAddress =
            '${placemark.street ?? ''}, ${placemark.subLocality ?? ''}, '
            '${placemark.locality ?? ''}, ${placemark.country ?? ''}';

        emit(PassengerDirectoryLoaded(
          currentLocation: currentLocation,
          currentAddress: currentAddress,
          destinationLocation: state is PassengerDirectoryLoaded
              ? (state as PassengerDirectoryLoaded).destinationLocation
              : null,
          destinationAddress: state is PassengerDirectoryLoaded
              ? (state as PassengerDirectoryLoaded).destinationAddress
              : '',
          searchSuggestions: state is PassengerDirectoryLoaded
              ? (state as PassengerDirectoryLoaded).searchSuggestions
              : [],
          isSearching: false,
          estimatedFare: state is PassengerDirectoryLoaded
              ? (state as PassengerDirectoryLoaded).estimatedFare
              : null,
          distanceKm: state is PassengerDirectoryLoaded
              ? (state as PassengerDirectoryLoaded).distanceKm
              : null,
          durationMin: state is PassengerDirectoryLoaded
              ? (state as PassengerDirectoryLoaded).durationMin
              : null,
          routePoints: state is PassengerDirectoryLoaded
              ? (state as PassengerDirectoryLoaded).routePoints
              : [],
          lastQuery: state is PassengerDirectoryLoaded
              ? (state as PassengerDirectoryLoaded).lastQuery
              : '',
        ));
      }
    } catch (e) {
      emit(PassengerDirectoryError('خطأ في تحديد الموقع: $e'));
    }
  }

  // Search with Egypt focus - Improved to handle text preservation
  Future<void> searchDestination(String query) async {
    if (query.isEmpty) {
      if (state is PassengerDirectoryLoaded) {
        emit((state as PassengerDirectoryLoaded).copyWith(
          searchSuggestions: [],
          isSearching: false,
          lastQuery: '',
        ));
      }
      return;
    }
    
    if (state is PassengerDirectoryLoaded) {
      emit((state as PassengerDirectoryLoaded).copyWith(
        isSearching: true,
        lastQuery: query,
      ));
    }

    _searchDebounceTimer?.cancel();
    _searchDebounceTimer = Timer(const Duration(milliseconds: 300), () async {
      _lastSearchQuery = query;

      if (state is PassengerDirectoryLoaded) {
        final currentState = state as PassengerDirectoryLoaded;

        try {
          final response = await _dio.get(
            'https://nominatim.openstreetmap.org/search',
            queryParameters: {
              'q': '$query, Egypt',
              'format': 'json',
              'addressdetails': 1,
              'limit': 5,
              'countrycodes': 'eg',
              'accept-language': 'ar',
            },
            options: Options(
              headers: {'User-Agent': 'YourAppName'},
              sendTimeout: const Duration(seconds: 5),
              receiveTimeout: const Duration(seconds: 5),
            ),
          );

          if (response.statusCode == 200) {
            final data = List<Map<String, dynamic>>.from(response.data);

            if (data.isEmpty) {
              _useMockSuggestions(currentState, query);
              return;
            }

            List<String> suggestions = data.map((place) {
              final displayName = place['display_name'] as String;
              return displayName;
            }).toList();

            if (_lastSearchQuery == query && state is PassengerDirectoryLoaded) {
              emit((state as PassengerDirectoryLoaded).copyWith(
                searchSuggestions: suggestions,
                isSearching: false,
                lastQuery: query,
              ));
            }
          } else {
            _useMockSuggestions(currentState, query);
          }
        } catch (e) {
          print('Search error: $e');
          _useMockSuggestions(currentState, query);
        }
      }
    });
  }

  // Helper method for mock suggestions - Updated to also set isSearching to false
  Future<void> _useMockSuggestions(
      PassengerDirectoryLoaded currentState, String query) async {
    List<String> mockSuggestions = [
      '$query - القاهرة، مصر',
      '$query - الإسكندرية، مصر',
      '$query - الجيزة، مصر',
      '$query - شرم الشيخ، مصر',
      '$query - الأقصر، مصر',
    ];

    if (_lastSearchQuery == query && state is PassengerDirectoryLoaded) {
      emit((state as PassengerDirectoryLoaded).copyWith(
        searchSuggestions: mockSuggestions,
        isSearching: false,
        lastQuery: query,
      ));
    }
  }

  Future<void> selectDestination(String address) async {
    if (state is! PassengerDirectoryLoaded) {
      return;
    }

    final currentState = state as PassengerDirectoryLoaded;
    emit(currentState.copyWith(
      destinationAddress: address,
      searchSuggestions: [], 
      isSearching: true, 
    ));

    try {
      final currentLocation = currentState.currentLocation;

      LatLng destinationLocation;
      try {
        final response = await _dio.get(
          'https://nominatim.openstreetmap.org/search',
          queryParameters: {
            'q': '$address, Egypt',
            'format': 'json',
            'limit': 1,
            'countrycodes': 'eg',
          },
          options: Options(
            headers: {'User-Agent': 'YourAppName'},
            sendTimeout: const Duration(seconds: 5),
            receiveTimeout: const Duration(seconds: 5),
          ),
        );

        if (response.statusCode == 200 &&
            (response.data as List).isNotEmpty) {
          final place = response.data[0];
          destinationLocation = LatLng(
            double.parse(place['lat']),
            double.parse(place['lon']),
          );
        } else {
          destinationLocation = LatLng(
            currentLocation.latitude + (Random().nextDouble() * 0.05 - 0.025),
            currentLocation.longitude +
                (Random().nextDouble() * 0.05 - 0.025),
          );
        }
      } catch (e) {
        print('Geocoding error: $e');
        destinationLocation = LatLng(
          currentLocation.latitude + (Random().nextDouble() * 0.05 - 0.025),
          currentLocation.longitude + (Random().nextDouble() * 0.05 - 0.025),
        );
      }

      List<LatLng> routePoints;
      if (_cachedRoutePoints.isNotEmpty &&
          _cachedRoutePoints.first == currentLocation &&
          _cachedRoutePoints.last == destinationLocation) {
        routePoints = _cachedRoutePoints;
      } else {
        routePoints = await _getRouteFromOSRM(
          currentLocation,
          destinationLocation,
        );

        if (routePoints.isEmpty) {
          routePoints = _generateRoutePoints(
            currentLocation,
            destinationLocation,
            10,
          );
        }

        _cachedRoutePoints = routePoints;
      }

      double distanceInMeters = _calculateRouteDistance(routePoints);
      final distanceKm = distanceInMeters / 1000;
      final durationMin = (distanceKm * 60 / 40).round();
      final estimatedFare = 10 + (distanceKm * 5);

      if (state is PassengerDirectoryLoaded) {
        emit((state as PassengerDirectoryLoaded).copyWith(
          destinationLocation: destinationLocation,
          destinationAddress: address,
          searchSuggestions: [],
          isSearching: false,
          estimatedFare: estimatedFare,
          distanceKm: distanceKm,
          durationMin: durationMin,
          routePoints: routePoints,
          lastQuery: '',
        ));
      }
    } catch (e) {
      if (state is PassengerDirectoryLoaded) {
        emit((state as PassengerDirectoryLoaded).copyWith(
          isSearching: false,
        ));
      } else {
        emit(PassengerDirectoryError('خطأ في تحديد الوجهة: $e'));
      }
    }
  }

  // Calculate route distance efficiently
  double _calculateRouteDistance(List<LatLng> points) {
    double distanceInMeters = 0;
    int step = points.length > 30 ? 3 : 1;

    for (int i = 0; i < points.length - step; i += step) {
      distanceInMeters += Geolocator.distanceBetween(
        points[i].latitude,
        points[i].longitude,
        points[i + step].latitude,
        points[i + step].longitude,
      );
    }

    return distanceInMeters;
  }

  // Get route from OpenStreetMap Routing Machine (OSRM) with improved error handling
  Future<List<LatLng>> _getRouteFromOSRM(
    LatLng start,
    LatLng destination,
  ) async {
    try {
      final response = await _dio.get(
        'https://router.project-osrm.org/route/v1/driving/'
        '${start.longitude},${start.latitude};'
        '${destination.longitude},${destination.latitude}',
        queryParameters: {
          'overview': 'full',
          'geometries': 'geojson',
          'steps': 'false',
          'annotations': 'false',
        },
        options: Options(
          sendTimeout: const Duration(seconds: 5),
          receiveTimeout: const Duration(seconds: 5),
        ),
      );

      if (response.statusCode == 200 &&
          response.data['routes'] != null &&
          (response.data['routes'] as List).isNotEmpty) {
        final route = response.data['routes'][0];
        final geometry = route['geometry'];
        final coordinates = geometry['coordinates'] as List;

        List<LatLng> points = [];
        int step = coordinates.length > 100 ? 5 : 1;

        for (int i = 0; i < coordinates.length; i += step) {
          final point = coordinates[i];
          points.add(LatLng(point[1], point[0]));
        }

        if (points.isEmpty ||
            points.last != LatLng(coordinates.last[1], coordinates.last[0])) {
          points.add(LatLng(coordinates.last[1], coordinates.last[0]));
        }

        return points;
      }
    } catch (e) {
      print('Error getting OSRM route: $e');
    }
    return [];
  }

  // Generate optimized route points
  List<LatLng> _generateRoutePoints(LatLng start, LatLng end, int numPoints) {
    List<LatLng> points = [start];

    final latStep = (end.latitude - start.latitude) / (numPoints + 1);
    final lngStep = (end.longitude - start.longitude) / (numPoints + 1);

    final random = Random();

    for (int i = 1; i <= numPoints; i++) {
      final lat = start.latitude +
          (latStep * i) +
          (random.nextDouble() * 0.002 - 0.001);
      final lng = start.longitude +
          (lngStep * i) +
          (random.nextDouble() * 0.002 - 0.001);

      points.add(LatLng(lat, lng));
    }

    points.add(end);
    return points;
  }

  // Request ride
  Future<RideRequestModel> requestRide(int vehicleType) async {
    if (state is! PassengerDirectoryLoaded) {
      throw Exception('حالة غير صحيحة للطلب');
    }

    final currentState = state as PassengerDirectoryLoaded;
    if (currentState.destinationLocation == null) {
      throw Exception('لم يتم تحديد الوجهة');
    }

    final String rideId = const Uuid().v4();
    final String passengerId = 'current-user-id';

    final RideRequestModel rideRequest = RideRequestModel(
      id: rideId,
      passengerId: passengerId,
      pickupLocation: currentState.currentLocation,
      dropoffLocation: currentState.destinationLocation!,
      status: RideStatus.pending,
      createdAt: DateTime.now(),
      estimatedFare: currentState.estimatedFare,
      distanceKm: currentState.distanceKm,
      durationMin: currentState.durationMin,
      secureCode: (100000 + Random().nextInt(900000)).toString(),
    );

    return rideRequest;
  }

  // Clear search suggestions
  void clearSearchSuggestions() {
    if (state is PassengerDirectoryLoaded) {
      emit((state as PassengerDirectoryLoaded).copyWith(
        searchSuggestions: [],
        isSearching: false,
      ));
    }
  }

  // Reset destination with improved state handling
  void resetDestination() {
    _cachedRoutePoints = [];
    if (state is PassengerDirectoryLoaded) {
      emit((state as PassengerDirectoryLoaded).copyWith(
        destinationLocation: null,
        destinationAddress: '',
        estimatedFare: null,
        distanceKm: null,
        durationMin: null,
        routePoints: [],
        searchSuggestions: [],
        lastQuery: '',
      ));
    }
  }
}