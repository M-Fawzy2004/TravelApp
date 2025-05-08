import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:latlong2/latlong.dart';
import 'package:travel_app/core/theme/app_color.dart';
import 'package:travel_app/core/utils/top_snakbar_app.dart';
import 'package:travel_app/feature/share_location/presentation/manager/location/location_cubit.dart';
import 'package:travel_app/feature/share_location/presentation/view/widget/share_location_view_body.dart';

class ShareLocationBodyBlocListener extends StatefulWidget {
  final MapController mapController;
  final TextEditingController locationController;
  final void Function(LatLng point) showLocationBottomSheet;

  const ShareLocationBodyBlocListener({
    super.key,
    required this.mapController,
    required this.locationController,
    required this.showLocationBottomSheet,
  });

  @override
  State<ShareLocationBodyBlocListener> createState() =>
      _ShareLocationBodyBlocListenerState();
}

class _ShareLocationBodyBlocListenerState
    extends State<ShareLocationBodyBlocListener> {
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<LocationCubit, LocationState>(
      listener: (context, state) {
        if (state is LocationError) {
          showCustomTopSnackBar(
            context: context,
            message: state.message,
          );
        } else if (state is LocationLoaded && state.selectedLocation != null) {
          // When a location is loaded with a selected location, center map on it
          WidgetsBinding.instance.addPostFrameCallback((_) {
            if (mounted) {
              widget.mapController.move(state.selectedLocation!, 15);
            }
          });
        }
      },
      builder: (context, state) {
        return Stack(
          children: [
            ShareLocationViewBody(
              mapController: widget.mapController,
              currentLocation:
                  state is LocationLoaded ? state.currentLocation : null,
              destinationLocation:
                  state is LocationLoaded ? state.destinationLocation : null,
              selectedLocation:
                  state is LocationLoaded ? state.selectedLocation : null,
              route: state is LocationLoaded ? state.route : const [],
              isRouteVisible:
                  state is LocationLoaded ? state.isRouteVisible : false,
              controller: widget.locationController,
              onSearchSubmitted: (query) {
                if (query.isNotEmpty) {
                  context.read<LocationCubit>().searchLocation(query);
                }
              },
              onMapTap: (point) {
                context.read<LocationCubit>().selectLocation(point);
                widget.showLocationBottomSheet(point);
              },
            ),
            if (state is LocationLoading)
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
        );
      },
    );
  }
}
