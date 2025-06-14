import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:travel_app/core/helper/spacing.dart';
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
          backgroundColor: AppColors.getPrimaryColor(context),
          child: Icon(
            FontAwesomeIcons.locationCrosshairs,
            size: 24.sp,
            color: AppColors.getSurfaceColor(context),
          ),
        ),
        heightBox(15),
        Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            FloatingActionButton(
              heroTag: 'zoomOut',
              onPressed: () => adjustZoom(-1),
              backgroundColor: AppColors.getPrimaryColor(context),
              mini: true,
              child: Icon(
                FontAwesomeIcons.minus,
                size: 18.sp,
                color: AppColors.getSurfaceColor(context),
              ),
            ),
            widthBox(8),
            FloatingActionButton(
              heroTag: 'zoomIn',
              onPressed: () => adjustZoom(1),
              backgroundColor: AppColors.getPrimaryColor(context),
              mini: true,
              child: Icon(
                FontAwesomeIcons.plus,
                size: 18.sp,
                color: AppColors.getSurfaceColor(context),
              ),
            ),
          ],
        ),
      ],
    );
  }
}
