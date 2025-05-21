import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:geolocator/geolocator.dart';
import 'package:latlong2/latlong.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:travel_app/core/theme/app_color.dart';
import 'package:flutter_map_location_marker/flutter_map_location_marker.dart';

class RideMapDirectory extends StatelessWidget {
  final LatLng currentLocation;
  final LatLng? destinationLocation;
  final List<LatLng> routePoints;

  const RideMapDirectory({
    super.key,
    required this.currentLocation,
    this.destinationLocation,
    this.routePoints = const [],
  });

  @override
  Widget build(BuildContext context) {
    final allPoints = _getRelevantPoints();
    final bounds = _calculateMapBounds(allPoints);

    return FlutterMap(
      options: MapOptions(
        initialCenter: currentLocation,
        initialZoom: 15.0,
        initialCameraFit: allPoints.length > 1
            ? CameraFit.bounds(
                bounds: bounds,
                padding: const EdgeInsets.all(50),
              )
            : null,
        maxZoom: 25.0,
        interactionOptions: const InteractionOptions(
          flags: InteractiveFlag.all & ~InteractiveFlag.rotate,
          enableMultiFingerGestureRace: true,
        ),
      ),
      children: [
        TileLayer(
          urlTemplate: 'https://tile.openstreetmap.org/{z}/{x}/{y}.png',
          userAgentPackageName: 'com.example.app',
          tileProvider: NetworkTileProvider(
            headers: {'User-Agent': 'com.example.app'},
          ),
          keepBuffer: 5,
          maxZoom: 18.0,
        ),
        CurrentLocationLayer(
          positionStream: const LocationMarkerDataStreamFactory()
              .fromGeolocatorPositionStream(
            stream: Geolocator.getPositionStream(
              locationSettings: const LocationSettings(
                accuracy: LocationAccuracy.high,
                distanceFilter: 10,
              ),
            ),
          ),
          style: const LocationMarkerStyle(
            marker: DefaultLocationMarker(
              color: Colors.blue,
              child: Icon(
                Icons.my_location,
                color: Colors.white,
                size: 16,
              ),
            ),
            markerSize: Size(40, 40),
            accuracyCircleColor: Colors.blue,
            headingSectorColor: Colors.blue,
          ),
        ),
        if (routePoints.isNotEmpty) _buildRouteLayer(),
        MarkerLayer(
          markers: _buildMarkers(),
        ),
      ],
    );
  }

  List<LatLng> _getRelevantPoints() {
    List<LatLng> points = [currentLocation];

    if (destinationLocation != null) {
      points.add(destinationLocation!);
    }

    if (routePoints.length > 10) {
      points.add(routePoints.first);
      points.add(routePoints[routePoints.length ~/ 2]);
      points.add(routePoints.last);
    } else if (routePoints.isNotEmpty) {
      points.addAll(routePoints);
    }

    return points;
  }

  LatLngBounds _calculateMapBounds(List<LatLng> points) {
    if (points.length <= 1) {
      return LatLngBounds(
        LatLng(
          currentLocation.latitude - 0.01,
          currentLocation.longitude - 0.01,
        ),
        LatLng(
          currentLocation.latitude + 0.01,
          currentLocation.longitude + 0.01,
        ),
      );
    }
    return LatLngBounds.fromPoints(points);
  }

  PolylineLayer _buildRouteLayer() {
    List<LatLng> displayPoints = routePoints;
    if (routePoints.length > 100) {
      displayPoints = [];
      for (int i = 0; i < routePoints.length; i += 5) {
        displayPoints.add(routePoints[i]);
      }
      if (displayPoints.isEmpty || displayPoints.last != routePoints.last) {
        displayPoints.add(routePoints.last);
      }
    }

    return PolylineLayer(
      polylines: [
        Polyline(
          points: displayPoints,
          color: AppColors.primaryColor,
          strokeWidth: 4.0,
        ),
      ],
    );
  }

  List<Marker> _buildMarkers() {
    List<Marker> markers = [];

    if (destinationLocation != null) {
      markers.add(
        Marker(
          point: destinationLocation!,
          width: 40.w,
          height: 40.h,
          child: _buildMarker(Icons.location_on, AppColors.primaryColor),
        ),
      );
    }

    // Only add route point markers if route isn't too long (to improve performance)
    if (routePoints.length >= 3 && routePoints.length <= 20) {
      markers.addAll(
        routePoints.skip(1).take(routePoints.length - 2).map(
              (point) => Marker(
                point: point,
                width: 10.w,
                height: 10.h,
                child: Container(
                  decoration: BoxDecoration(
                    color: AppColors.primaryColor.withOpacity(0.7),
                    shape: BoxShape.circle,
                    border: Border.all(
                      color: Colors.white,
                      width: 1,
                    ),
                  ),
                ),
              ),
            ),
      );
    }

    return markers;
  }

  Widget _buildMarker(IconData icon, Color color) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        shape: BoxShape.circle,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.2),
            blurRadius: 6,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      child: Padding(
        padding: EdgeInsets.all(4.w),
        child: Icon(
          icon,
          color: color,
          size: 24.sp,
        ),
      ),
    );
  }
}
