import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:travel_app/core/widget/custom_loading_circle.dart';
import 'package:travel_app/feature/add_travel/data/model/trip_model.dart';

class TravelImage extends StatelessWidget {
  const TravelImage({
    super.key,
    required this.trip,
  });

  final TripModel trip;

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(10.r),
      child: Image.network(
        trip.imageUrl,
        width: double.infinity,
        height: double.infinity,
        fit: BoxFit.cover,
        loadingBuilder: (context, child, loadingProgress) {
          if (loadingProgress == null) return child;
          return const Center(
            child: CustomLoadingCircle(),
          );
        },
        errorBuilder: (context, error, stackTrace) {
          return Container(
            color: Colors.grey[300],
            child: Icon(
              Icons.image_not_supported,
              size: 50.sp,
              color: Colors.grey[600],
            ),
          );
        },
      ),
    );
  }
}
