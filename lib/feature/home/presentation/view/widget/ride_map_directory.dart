import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:latlong2/latlong.dart';
import 'package:travel_app/core/theme/app_color.dart';
import 'package:travel_app/core/theme/styles.dart';
import 'package:flutter_map_location_marker/flutter_map_location_marker.dart';

class RideMapDirectory extends StatefulWidget {
  final LatLng currentLocation;
  final LatLng? destinationLocation;

  const RideMapDirectory({
    super.key,
    required this.currentLocation,
    this.destinationLocation,
  });

  @override
  State<RideMapDirectory> createState() => _RideMapDirectoryState();
}

class _RideMapDirectoryState extends State<RideMapDirectory> {
  final mapController = MapController();

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (widget.destinationLocation != null) {
        final bounds =
            LatLngBounds(widget.currentLocation, widget.destinationLocation!);
        bounds.extend(
          LatLng(widget.currentLocation.latitude + 0.02,
              widget.currentLocation.longitude + 0.02),
        );
        bounds.extend(
          LatLng(widget.destinationLocation!.latitude - 0.02,
              widget.destinationLocation!.longitude - 0.02),
        );

        mapController.fitCamera(
          CameraFit.bounds(
            bounds: bounds,
            padding: const EdgeInsets.all(50),
          ),
        );
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return FlutterMap(
      mapController: mapController,
      options: MapOptions(
        initialCenter: widget.currentLocation,
        initialZoom: 14.0,
      ),
      children: [
        TileLayer(
          urlTemplate: "https://tile.openstreetmap.org/{z}/{x}/{y}.png",
        ),
        if (widget.destinationLocation != null)
          PolylineLayer(
            polylines: [
              Polyline(
                points: [widget.currentLocation, widget.destinationLocation!],
                color: AppColors.primaryColor,
                strokeWidth: 4.0,
              ),
            ],
          ),
        MarkerLayer(
          markers: [
            Marker(
              width: 60.w,
              height: 60.h,
              point: widget.currentLocation,
              child: Column(
                children: [
                  const Icon(
                    FontAwesomeIcons.car,
                    color: AppColors.primaryColor,
                  ),
                  Text('أنت', style: Styles.font16BlackBold),
                ],
              ),
            ),
            if (widget.destinationLocation != null)
              Marker(
                width: 60.w,
                height: 60.h,
                point: widget.destinationLocation!,
                child: Column(
                  children: [
                    const Icon(
                      FontAwesomeIcons.locationDot,
                      color: Colors.red,
                    ),
                    Text('الوجهة', style: Styles.font16BlackBold),
                  ],
                ),
              ),
          ],
        ),
        const CurrentLocationLayer(),
      ],
    );
  }
}
