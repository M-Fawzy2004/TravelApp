import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:travel_app/core/helper/spacing.dart';
import 'package:travel_app/core/theme/app_color.dart';
import 'package:travel_app/feature/home/presentation/view/trip_tracking_view/widget/order_summary_row.dart';
import 'package:travel_app/feature/home/presentation/view/trip_tracking_view/widget/passenger_name_card.dart';
import 'package:travel_app/feature/home/presentation/view/trip_tracking_view/widget/route_info_card.dart';

class TripDetailsCard extends StatefulWidget {
  const TripDetailsCard({super.key});

  @override
  State<TripDetailsCard> createState() => _TripDetailsCardState();
}

class _TripDetailsCardState extends State<TripDetailsCard> {
  String tripStatus = "جار التجهيز";
  bool isTripStarted = false;
  bool isTripEnded = false;

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 2,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      color: AppColors.white,
      child: Padding(
        padding: EdgeInsets.all(16.w),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const PassengerNameCard(),
            heightBox(12),
            const RouteInfoCard(),
            heightBox(12),
            const OrderSummaryRow(),
          ],
        ),
      ),
    );
  }
}
