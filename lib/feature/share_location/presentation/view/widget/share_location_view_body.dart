import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:latlong2/latlong.dart';
import 'package:travel_app/core/theme/app_color.dart';
import 'package:travel_app/feature/share_location/presentation/view/widget/search_location.dart';

class ShareLocationViewBody extends StatelessWidget {
  const ShareLocationViewBody({
    super.key,
    required this.mapController,
    this.currentLocation,
    this.destinationLocation,
    this.selectedLocation,
    this.route = const [],
    this.isRouteVisible = false,
    this.controller,
    this.onSearchSubmitted,
    this.onMapTap,
  });

  final MapController mapController;
  final LatLng? currentLocation;
  final LatLng? destinationLocation;
  final LatLng? selectedLocation;
  final List<LatLng> route;
  final bool isRouteVisible;
  final TextEditingController? controller;
  final Function(String)? onSearchSubmitted;
  final Function(LatLng)? onMapTap;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        FlutterMap(
          mapController: mapController,
          options: MapOptions(
            initialCenter: currentLocation ?? const LatLng(30.0444, 31.2357),
            initialZoom: 15.0,
            minZoom: 3.0,
            maxZoom: 18.0,
            onTap: (tapPosition, point) => onMapTap?.call(point),
          ),
          children: [
            TileLayer(
              urlTemplate: 'https://tile.openstreetmap.org/{z}/{x}/{y}.png',
              userAgentPackageName: 'com.travel_app',
              tileProvider: NetworkTileProvider(),
            ),
            if (currentLocation != null)
              MarkerLayer(
                markers: [
                  Marker(
                    width: 40.w,
                    height: 40.h,
                    point: currentLocation!,
                    child: Container(
                      decoration: BoxDecoration(
                        color:
                            AppColors.getPrimaryColor(context).withOpacity(0.4),
                        shape: BoxShape.circle,
                      ),
                      child: Center(
                        child: Icon(
                          FontAwesomeIcons.locationDot,
                          color: AppColors.getPrimaryColor(context),
                          size: 24.sp,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            if (selectedLocation != null && selectedLocation != currentLocation)
              MarkerLayer(
                markers: [
                  Marker(
                    width: 40.w,
                    height: 40.h,
                    point: selectedLocation!,
                    child: Icon(
                      FontAwesomeIcons.mapPin,
                      color: Colors.red,
                      size: 30.sp,
                    ),
                  ),
                ],
              ),
            if (destinationLocation != null)
              MarkerLayer(
                markers: [
                  Marker(
                    width: 40.w,
                    height: 40.h,
                    point: destinationLocation!,
                    child: Icon(
                      FontAwesomeIcons.locationArrow,
                      color: Colors.green,
                      size: 30.sp,
                    ),
                  ),
                ],
              ),
            if (isRouteVisible && route.isNotEmpty)
              PolylineLayer(
                polylines: [
                  Polyline(
                    points: route,
                    strokeWidth: 4.0,
                    color: AppColors.getPrimaryColor(context),
                  ),
                ],
              ),
          ],
        ),
        Positioned(
          top: 10.h,
          left: 16.w,
          right: 16.w,
          child: SearchLocation(
            controller: controller,
            onSearchSubmitted: onSearchSubmitted,
          ),
        ),
        if (currentLocation == null)
          Center(
            child: SpinKitCircle(
              color: AppColors.getPrimaryColor(context),
              size: 50.h,
            ),
          ),
      ],
    );
  }
}
