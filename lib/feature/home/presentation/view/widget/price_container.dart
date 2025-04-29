import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:travel_app/core/theme/app_color.dart';
import 'package:travel_app/core/theme/styles.dart';
import 'package:travel_app/feature/add_travel/data/model/trip_model.dart';

class PriceContainer extends StatelessWidget {
  const PriceContainer({
    super.key,
    required this.trip,
  });

  final TripModel trip;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 5.w, vertical: 5.h),
      decoration: BoxDecoration(
        color: AppColors.primaryColor,
        borderRadius: BorderRadius.circular(10.r),
      ),
      child: Row(
        children: [
          const Icon(Icons.attach_money, size: 16),
          SizedBox(width: 4.w),
          Text(
            '${trip.price.toString()} ج.م',
            style: Styles.font16BlackBold,
          ),
        ],
      ),
    );
  }
}
