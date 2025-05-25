import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:travel_app/core/theme/styles.dart';
import 'package:travel_app/feature/add_travel/data/model/trip_model.dart';

class TripImageCard extends StatelessWidget {
  const TripImageCard({
    super.key,
    required this.trip,
  });

  final TripModel trip;
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        ClipRRect(
          borderRadius: BorderRadius.circular(10.r),
          child: Image.network(
            trip.imageUrl,
            width: double.infinity,
            height: 250.h,
            fit: BoxFit.cover,
            loadingBuilder: (context, child, loadingProgress) {
              if (loadingProgress == null) return child;
              return Center(
                child: CircularProgressIndicator(
                  value: loadingProgress.expectedTotalBytes != null
                      ? loadingProgress.cumulativeBytesLoaded /
                          loadingProgress.expectedTotalBytes!
                      : null,
                ),
              );
            },
          ),
        ),
        Positioned(
          bottom: 0,
          left: 0,
          right: 0,
          child: Container(
            padding: EdgeInsets.symmetric(
              horizontal: 16.w,
              vertical: 12.h,
            ),
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.bottomCenter,
                end: Alignment.topCenter,
                colors: [
                  Colors.black.withOpacity(0.7),
                  Colors.transparent,
                ],
              ),
              borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(10.r),
                bottomRight: Radius.circular(10.r),
              ),
            ),
            child: Text(
              trip.destinationName,
              style: Styles.font20BlackBold(context).copyWith(
                color: Colors.white,
              ),
            ),
          ),
        ),
      ],
    );
  }
}
