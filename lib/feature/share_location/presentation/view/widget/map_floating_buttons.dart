import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:travel_app/core/theme/app_color.dart';

class MapFloatingButtons extends StatelessWidget {
  final VoidCallback moveToCurrentLocation;
  final void Function(double) adjustZoom;

  const MapFloatingButtons({
    super.key,
    required this.moveToCurrentLocation,
    required this.adjustZoom,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        FloatingActionButton(
          heroTag: 'currentLocation',
          onPressed: moveToCurrentLocation,
          backgroundColor: AppColors.primaryColor,
          child: Icon(
            FontAwesomeIcons.locationCrosshairs,
            size: 24.sp,
            color: AppColors.white,
          ),
        ),
        SizedBox(height: 16.h),
        Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            FloatingActionButton(
              heroTag: 'zoomOut',
              onPressed: () => adjustZoom(-1),
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
              onPressed: () => adjustZoom(1),
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
    );
  }
}
