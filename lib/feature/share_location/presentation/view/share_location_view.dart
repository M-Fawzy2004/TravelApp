// Enhanced and refactored version of ShareLocationView with Clean Architecture
// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:latlong2/latlong.dart';
import 'package:travel_app/core/utils/top_snakbar_app.dart';
import 'package:travel_app/feature/auth/presentation/manager/cubit/auth_cubit.dart';
import 'package:travel_app/feature/share_location/presentation/manager/address/address_cubit.dart';
import 'package:travel_app/feature/share_location/presentation/manager/location/location_cubit.dart';
import 'package:travel_app/feature/share_location/presentation/view/widget/build_share_location_app_bar.dart';
import 'package:travel_app/feature/share_location/presentation/view/widget/map_floating_buttons.dart';
import 'package:travel_app/feature/share_location/presentation/view/widget/share_location_body_bloc_consumer.dart';
import 'package:travel_app/feature/share_location/presentation/view/widget/location_bottom_sheet.dart';

class ShareLocationView extends StatefulWidget {
  const ShareLocationView({super.key});

  @override
  State<ShareLocationView> createState() => _ShareLocationViewState();
}

class _ShareLocationViewState extends State<ShareLocationView> {
  final MapController mapController = MapController();
  final TextEditingController locationController = TextEditingController();

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (mounted) {
        context.read<LocationCubit>().initializeLocation();
      }
    });
  }

  @override
  void dispose() {
    locationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: buildShareLocationAppBar(context),
      floatingActionButton: MapFloatingButtons(
        moveToCurrentLocation: _moveToCurrentLocation,
        adjustZoom: (amount) => _adjustZoom(amount),
      ),
      body: ShareLocationBodyBlocListener(
        mapController: mapController,
        locationController: locationController,
        showLocationBottomSheet: _showLocationBottomSheet,
      ),
    );
  }

  void _showLocationBottomSheet(LatLng point) {
    if (!mounted) return;

    // First get the address
    context.read<AddressCubit>().getAddressFromCoordinates(point);

    // Then show the bottom sheet with BlocProvider to pass both cubits
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20.r)),
      ),
      builder: (bottomSheetContext) => MultiBlocProvider(
        providers: [
          // Pass the existing AddressCubit from parent context to bottom sheet
          BlocProvider.value(
            value: context.read<AddressCubit>(),
          ),
          // Pass the existing AuthCubit from parent context to bottom sheet
          BlocProvider.value(
            value: context.read<AuthCubit>(),
          ),
        ],
        child: LocationBottomSheet(
          point: point,
          onNavigatePressed: () {
            Navigator.pop(context);
            if (mounted) {
              context.read<LocationCubit>().getRoute(point);
            }
          },
        ),
      ),
    );
  }

  void _moveToCurrentLocation() {
    final state = context.read<LocationCubit>().state;
    if (state is LocationLoaded && state.currentLocation != null) {
      mapController.move(state.currentLocation!, 15);
    } else {
      showCustomTopSnackBar(context: context, message: 'هذا الموقع غير متوفر');
    }
  }

  void _adjustZoom(double amount) {
    try {
      final currentZoom = mapController.camera.zoom;
      mapController.move(mapController.camera.center, currentZoom + amount);
    } catch (e) {
      debugPrint('Error adjusting zoom: $e');
    }
  }
}
