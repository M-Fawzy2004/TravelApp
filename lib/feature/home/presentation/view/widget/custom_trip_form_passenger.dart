import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:travel_app/core/helper/spacing.dart';
import 'package:travel_app/feature/home/presentation/view/widget/trip_form.dart';
import 'package:travel_app/feature/home/presentation/view/widget/trip_header.dart';

class CustomTripFormPassenger extends StatelessWidget {
  final String type;

  const CustomTripFormPassenger({super.key, required this.type});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(bottom: 50.h, left: 10.w, right: 10.w),
      child: Column(
        children: [
          TripHeader(type: type),
          heightBox(10),
          const TripForm(),
          heightBox(50),
        ],
      ),
    );
  }
}
