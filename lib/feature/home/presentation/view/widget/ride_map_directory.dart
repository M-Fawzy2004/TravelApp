import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:latlong2/latlong.dart';
import 'package:travel_app/core/theme/app_color.dart';
import 'package:travel_app/core/theme/styles.dart';

class RideMapDirectory extends StatelessWidget {
  const RideMapDirectory({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return FlutterMap(
      options: const MapOptions(
        initialCenter: LatLng(30.0444, 31.2357),
        initialZoom: 13.0,
      ),
      children: [
        TileLayer(
          urlTemplate: "https://tile.openstreetmap.org/{z}/{x}/{y}.png",
        ),
        MarkerLayer(
          markers: [
            Marker(
              width: 60.w,
              height: 60.h,
              point: const LatLng(30.0500, 31.2300),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  const Icon(
                    FontAwesomeIcons.user,
                    color: Colors.red,
                  ),
                  Text(
                    'الراكب',
                    style: Styles.font16BlackBold,
                  ),
                ],
              ),
            ),
            Marker(
              width: 60.w,
              height: 60.h,
              point: const LatLng(30.0350, 31.2450),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  const Icon(
                    FontAwesomeIcons.car,
                    color: AppColors.primaryColor,
                  ),
                  Text(
                    'أنت',
                    style: Styles.font16BlackBold,
                  ),
                ],
              ),
            ),
          ],
        ),
      ],
    );
  }
}
