import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:travel_app/core/helper/spacing.dart';
import 'package:travel_app/core/theme/app_color.dart';
import 'package:travel_app/core/theme/styles.dart';
import 'package:travel_app/feature/trip_booking/presentation/view/widget/accept_or_reject_button.dart';
import 'package:travel_app/feature/trip_booking/presentation/view/widget/message_and_price.dart';
import 'package:travel_app/feature/trip_booking/presentation/view/widget/passenger_name.dart';

class TripSummaryCaptain extends StatelessWidget {
  const TripSummaryCaptain({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 8.h),
      padding: EdgeInsets.all(16.w),
      decoration: BoxDecoration(
        color: AppColors.getSurfaceColor(context),
        borderRadius: BorderRadius.circular(20.r),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 5,
            offset: const Offset(0, 3),
          ),
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 5,
            offset: const Offset(0, -3),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const PassengersName(),
          heightBox(5),
          Text(
            'عدد التذاكر: 2',
            style: Styles.font12GreyExtraBold(context),
          ),
          const MessageAndPrice(),
          const AcceptOrRejectButton(),
        ],
      ),
    );
  }
}
