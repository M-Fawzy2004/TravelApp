// ignore_for_file: use_build_context_synchronously
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:travel_app/core/utils/top_snakbar_app.dart';
import 'package:travel_app/feature/home/presentation/view/ride_view/presentation/manager/ride_cubit/ride_cubit.dart';
import 'package:travel_app/feature/home/presentation/view/ride_view/presentation/view/passenger_directory/presentation/manager/cubit/passenger_directory_cubit.dart';

import 'package:travel_app/feature/home/presentation/view/ride_view/presentation/view/passenger_directory/presentation/view/widget/location_input_card.dart';
import 'package:travel_app/feature/home/presentation/view/ride_view/presentation/view/passenger_directory/presentation/view/widget/ride_request_ui.dart';
import 'package:travel_app/feature/home/presentation/view/ride_view/presentation/view/passenger_directory/presentation/view/widget/ride_map_directory.dart';

class RideRequestContent extends StatefulWidget {
  const RideRequestContent({super.key, required this.state});

  final PassengerDirectoryLoaded state;

  @override
  State<RideRequestContent> createState() => _RideRequestContentState();
}

class _RideRequestContentState extends State<RideRequestContent> {
  late TextEditingController _destinationController;
  late FocusNode _destinationFocusNode;

  @override
  void initState() {
    super.initState();
    _destinationController = TextEditingController(
      text: widget.state.destinationAddress,
    );
    _destinationFocusNode = FocusNode();
  }

  @override
  void didUpdateWidget(covariant RideRequestContent oldWidget) {
    super.didUpdateWidget(oldWidget);
    // Important: Only update the controller when the address changes significantly
    // This prevents the text from being reset during state updates
    if (_destinationController.text.isEmpty &&
        widget.state.destinationAddress.isNotEmpty) {
      _destinationController.text = widget.state.destinationAddress;
    }
  }

  @override
  void dispose() {
    _destinationController.dispose();
    _destinationFocusNode.dispose();
    super.dispose();
  }

  void _handleSelectDestination(String address) {
    // We'll avoid updating the controller directly here
    // Instead, let the didUpdateWidget handle it
    context.read<PassengerDirectoryCubit>().selectDestination(address);

    // Hide keyboard after selection
    FocusScope.of(context).unfocus();
  }

  void _handleRequestRide(int vehicleType) async {
    try {
      final rideRequest = await context
          .read<PassengerDirectoryCubit>()
          .requestRide(vehicleType);

      context.read<RideCubit>().createRide(rideRequest);
    } catch (e) {
      showCustomTopSnackBar(context: context, message: 'حدث خطاء في الطلب');
    }
  }

  @override
  Widget build(BuildContext context) {
    final state = widget.state;

    return Stack(
      children: [
        // Map Layer
        Positioned.fill(
          child: RideMapDirectory(
            currentLocation: state.currentLocation,
            destinationLocation: state.destinationLocation,
            routePoints: state.routePoints,
          ),
        ),

        // Bottom Ride Request UI - Only show if a destination is selected
        if (state.destinationLocation != null)
          Positioned(
            bottom: 0,
            left: 0,
            right: 0,
            child: RideRequestUI(
              estimatedFare: state.estimatedFare,
              distanceKm: state.distanceKm,
              durationMin: state.durationMin,
              onRequestRide: _handleRequestRide,
              isDestinationSelected: state.destinationLocation != null,
            ),
          ),

        // Top Location Input and Search Results
        Positioned(
          top: 0,
          left: 0,
          right: 0,
          child: Column(
            children: [
              // Location Input Card
              LocationInputCard(
                currentLocation: state.currentAddress,
                destinationController: _destinationController,
                onSearchDestination: (query) {
                  if (query.isNotEmpty) {
                    context
                        .read<PassengerDirectoryCubit>()
                        .searchDestination(query);
                  } else {
                    context
                        .read<PassengerDirectoryCubit>()
                        .clearSearchSuggestions();
                  }
                },
              ),

              // Search Suggestions Container
              if (state.searchSuggestions.isNotEmpty)
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
                  constraints: BoxConstraints(
                    maxHeight: 200.h,
                  ),
                  child: ListView.builder(
                    shrinkWrap: true,
                    physics: const ClampingScrollPhysics(),
                    itemCount: state.searchSuggestions.length,
                    itemBuilder: (context, index) {
                      return ListTile(
                        dense: true,
                        title: Text(
                          state.searchSuggestions[index],
                          style: TextStyle(fontSize: 14.sp),
                          textDirection: TextDirection.rtl,
                          textAlign: TextAlign.right,
                        ),
                        onTap: () => _handleSelectDestination(
                          state.searchSuggestions[index],
                        ),
                      );
                    },
                  ),
                ),
            ],
          ),
        ),

        if (state.isSearching)
          Positioned(
            top: 80.h,
            right: 20.w,
            child: Container(
              padding: EdgeInsets.all(8.w),
              decoration: BoxDecoration(
                color: Colors.white,
                shape: BoxShape.circle,
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.1),
                    blurRadius: 5,
                    offset: const Offset(0, 3),
                  ),
                ],
              ),
              child: SizedBox(
                height: 24.h,
                width: 24.w,
                child: const CircularProgressIndicator(
                  strokeWidth: 2.5,
                ),
              ),
            ),
          ),
      ],
    );
  }
}
