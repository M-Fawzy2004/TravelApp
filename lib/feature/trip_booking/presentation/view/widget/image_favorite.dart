import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:travel_app/core/widget/custom_loading_circle.dart';
import 'package:travel_app/feature/add_travel/data/model/trip_model.dart';

class ImageFavorite extends StatelessWidget {
  const ImageFavorite({
    super.key,
    required this.trip,
    this.height,
    this.widget,
  });

  final TripModel trip;
  final double? height;
  final double? widget;

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(10.r),
      child: Image.network(
        trip.imageUrl,
        width: widget ?? 80.w,
        height: height ?? 95.h,
        fit: BoxFit.cover,
        loadingBuilder: (context, child, loadingProgress) {
          if (loadingProgress == null) return child;
          return SizedBox(
            width: 80.w,
            height: 95.h,
            child: const CustomLoadingCircle(),
          );
        },
        errorBuilder: (context, error, stackTrace) {
          return Container(
            width: 80.w,
            height: 95.h,
            decoration: BoxDecoration(
              color: Colors.grey[300],
              borderRadius: BorderRadius.circular(8.r),
            ),
            child: Icon(
              Icons.image_not_supported,
              size: 30.sp,
              color: Colors.grey[600],
            ),
          );
        },
      ),
    );
  }
}
