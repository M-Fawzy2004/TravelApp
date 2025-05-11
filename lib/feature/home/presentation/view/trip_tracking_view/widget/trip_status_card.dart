import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:travel_app/core/theme/app_color.dart';

class TripStatusCard extends StatelessWidget {
  const TripStatusCard({super.key});

  @override
  Widget build(BuildContext context) {
    Color statusColor;
    IconData statusIcon;
    String tripStatus = 'جار التجهيز';

    // Set the appropriate color and icon based on trip status
    switch (tripStatus) {
      case "جار التجهيز":
        statusColor = Colors.blue;
        statusIcon = Icons.pending_actions;
        break;
      case "في الطريق":
        statusColor = Colors.orange;
        statusIcon = Icons.directions_car;
        break;
      case "مكتمل":
        statusColor = Colors.green;
        statusIcon = Icons.check_circle;
        break;
      default:
        statusColor = Colors.grey;
        statusIcon = Icons.info;
    }
    return Card(
      elevation: 2,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      color: AppColors.white,
      child: ListTile(
        leading: Icon(statusIcon, color: statusColor, size: 28.sp),
        title: Text(
          'حالة الرحلة: $tripStatus',
          style: TextStyle(
            fontWeight: FontWeight.bold,
            color: statusColor,
          ),
        ),
        trailing: CircleAvatar(
          backgroundColor: statusColor.withOpacity(0.2),
          child: Icon(Icons.refresh, color: statusColor),
        ),
      ),
    );
  }
}
