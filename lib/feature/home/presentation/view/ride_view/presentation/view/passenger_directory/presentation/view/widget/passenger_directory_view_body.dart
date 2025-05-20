// First, let's update the PassengerDirectoryViewBody class to use BLoC/Cubit for state management

// ignore_for_file: unused_field, avoid_print

import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:travel_app/feature/home/presentation/view/ride_view/presentation/manager/ride_cubit/ride_cubit.dart';
import 'package:travel_app/feature/home/presentation/view/ride_view/presentation/manager/ride_cubit/ride_state.dart';
import 'package:latlong2/latlong.dart';
import 'package:travel_app/feature/home/presentation/view/ride_view/data/model/ride_request_model.dart';
import 'package:travel_app/feature/home/presentation/view/ride_view/data/model/ride_status.dart';
import 'package:travel_app/feature/home/presentation/view/ride_view/presentation/view/passenger_directory/presentation/view/widget/location_input_card.dart';
import 'package:travel_app/feature/home/presentation/view/ride_view/presentation/view/passenger_directory/presentation/view/widget/ride_request_ui.dart';
import 'package:geolocator/geolocator.dart';
import 'package:geocoding/geocoding.dart';
import 'package:travel_app/feature/home/presentation/view/widget/ride_map_directory.dart';
import 'package:uuid/uuid.dart';

class PassengerDirectoryViewBody extends StatefulWidget {
  const PassengerDirectoryViewBody({super.key});

  @override
  State<PassengerDirectoryViewBody> createState() =>
      _PassengerDirectoryViewBodyState();
}

class _PassengerDirectoryViewBodyState
    extends State<PassengerDirectoryViewBody> {
  final TextEditingController _destinationController = TextEditingController();
  LatLng _currentLocation = const LatLng(30.0444, 31.2357);
  LatLng? _destinationLocation;
  String _currentAddress = '';
  String _destinationAddress = '';
  double? _estimatedFare;
  double? _distanceKm;
  int? _durationMin;
  bool _isSearchingDestination = false;
  List<String> _searchSuggestions = [];

  @override
  void initState() {
    super.initState();
    _getCurrentLocation();
  }

  @override
  void dispose() {
    _destinationController.dispose();
    super.dispose();
  }

  Future<void> _getCurrentLocation() async {
    try {
      // Request location permission
      LocationPermission permission = await Geolocator.checkPermission();
      if (permission == LocationPermission.denied) {
        permission = await Geolocator.requestPermission();
        if (permission == LocationPermission.denied) {
          return;
        }
      }

      // Get current position
      Position position = await Geolocator.getCurrentPosition(
          desiredAccuracy: LocationAccuracy.high);

      // Get address from coordinates
      List<Placemark> placemarks =
          await placemarkFromCoordinates(position.latitude, position.longitude);

      if (placemarks.isNotEmpty) {
        Placemark placemark = placemarks.first;
        setState(() {
          _currentLocation = LatLng(position.latitude, position.longitude);
          _currentAddress = '${placemark.street}, ${placemark.subLocality}, '
              '${placemark.locality}, ${placemark.postalCode}, ${placemark.country}';
        });
      }
    } catch (e) {
      print('Error getting current location: $e');
    }
  }

  void _searchDestination(String query) async {
    if (query.isEmpty) {
      setState(() {
        _searchSuggestions = [];
        _isSearchingDestination = false;
      });
      return;
    }

    setState(() {
      _isSearchingDestination = true;
    });

    try {
      // Get location suggestions based on the query
      List<Location> locations = await locationFromAddress(query);
      List<String> suggestions = [];

      for (var location in locations) {
        // Get address details for each location
        List<Placemark> placemarks = await placemarkFromCoordinates(
            location.latitude, location.longitude);

        if (placemarks.isNotEmpty) {
          Placemark placemark = placemarks.first;
          String address = '${placemark.street}, ${placemark.subLocality}, '
              '${placemark.locality}, ${placemark.postalCode}, ${placemark.country}';
          suggestions.add(address);
        }
      }

      setState(() {
        _searchSuggestions = suggestions;
      });
    } catch (e) {
      print('Error searching for destination: $e');
    } finally {
      setState(() {
        _isSearchingDestination = false;
      });
    }
  }

  void _selectDestination(String address) async {
    try {
      List<Location> locations = await locationFromAddress(address);
      if (locations.isNotEmpty) {
        setState(() {
          _destinationLocation =
              LatLng(locations.first.latitude, locations.first.longitude);
          _destinationAddress = address;
          _destinationController.text = address;
          _searchSuggestions = [];

          // Calculate estimated values
          _calculateEstimatedValues();
        });
      }
    } catch (e) {
      print('Error selecting destination: $e');
    }
  }

  void _calculateEstimatedValues() {
    if (_destinationLocation != null) {
      // Calculate distance
      final double distanceInMeters = Geolocator.distanceBetween(
        _currentLocation.latitude,
        _currentLocation.longitude,
        _destinationLocation!.latitude,
        _destinationLocation!.longitude,
      );

      _distanceKm = distanceInMeters / 1000;

      // Estimate duration (assuming average speed of 40 km/h in urban areas)
      _durationMin = (_distanceKm! * 60 / 40).round();

      // Calculate fare (example: base fare 10 + 5 per km)
      _estimatedFare = 10 + (_distanceKm! * 5);

      setState(() {});
    }
  }

  void _requestRide(int vehicleType) {
    if (_destinationLocation == null) return;

    final String rideId = const Uuid().v4();
    // Get current user ID (you would typically get this from authentication)
    final String passengerId = 'current-user-id';

    // Create ride request model
    final RideRequestModel rideRequest = RideRequestModel(
      id: rideId,
      passengerId: passengerId,
      pickupLocation: _currentLocation,
      dropoffLocation: _destinationLocation!,
      status: RideStatus.pending,
      createdAt: DateTime.now(),
      estimatedFare: _estimatedFare,
      distanceKm: _distanceKm,
      durationMin: _durationMin,
      // Generate a secure code for ride verification
      secureCode: (100000 + Random().nextInt(900000)).toString(),
    );

    // Submit ride request using the Cubit
    context.read<RideCubit>().createRide(rideRequest);
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<RideCubit, RideState>(
      listener: (context, state) {
        if (state is RideFailure) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text(state.message)),
          );
        } else if (state is RideSuccess && state.ride != null) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('تم إنشاء طلب التوصيل بنجاح')),
          );
        }
      },
      child: Stack(
        children: [
          Positioned.fill(
            child: RideMapDirectory(
              currentLocation: _currentLocation,
              destinationLocation: _destinationLocation,
            ),
          ),
          Positioned(
            bottom: 0,
            left: 0,
            right: 0,
            child: RideRequestUI(
              estimatedFare: _estimatedFare,
              distanceKm: _distanceKm,
              durationMin: _durationMin,
              onRequestRide: _requestRide,
              isDestinationSelected: _destinationLocation != null,
            ),
          ),
          Positioned(
            top: 0,
            left: 0,
            right: 0,
            child: Column(
              children: [
                LocationInputCard(
                  currentLocation: _currentAddress,
                  destinationController: _destinationController,
                  onSearchDestination: _searchDestination,
                ),
                if (_searchSuggestions.isNotEmpty)
                  Container(
                    margin: EdgeInsets.symmetric(horizontal: 10.w),
                    padding: EdgeInsets.all(8.w),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(10.r),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.1),
                          blurRadius: 5,
                          offset: const Offset(0, 3),
                        ),
                      ],
                    ),
                    child: ListView.builder(
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      itemCount: _searchSuggestions.length,
                      itemBuilder: (context, index) {
                        return ListTile(
                          title: Text(_searchSuggestions[index]),
                          onTap: () =>
                              _selectDestination(_searchSuggestions[index]),
                        );
                      },
                    ),
                  ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
