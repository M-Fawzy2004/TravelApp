import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:travel_app/core/helper/extension.dart';
import 'package:travel_app/core/helper/spacing.dart';
import 'package:travel_app/core/theme/app_color.dart';
import 'package:travel_app/core/theme/styles.dart';
import 'package:travel_app/feature/home/presentation/view/trip_tracking_view/trip_tracking_view.dart';
import 'package:travel_app/feature/home/presentation/view/captain_view/view/widget/custom_button_accept.dart';

class CustomTripFormCaptain extends StatelessWidget {
  const CustomTripFormCaptain({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const CaptainAvailabilityTile(),
        heightBox(20),
        Text(
          'الطلبات الجديدة:',
          style: Theme.of(context).textTheme.titleMedium,
          textAlign: TextAlign.right,
        ),
        heightBox(10),
        Card(
          color: AppColors.white,
          elevation: 2,
          margin: EdgeInsets.only(bottom: 10.h),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
          child: ListTile(
            leading: const Icon(Icons.location_on),
            title: const Text('من: باب اللوق - إلى: المعادي'),
            subtitle: const Text('عدد الأفراد: 2 | السعر: 50 جنيه'),
            trailing: CustomButtonAccept(
              onAccept: () => _navigateToTripTracking(context),
            ),
          ),
        ),
      ],
    );
  }

  void _navigateToTripTracking(BuildContext context) {
    context.navigateWithSlideTransition(const TripTrackingView());
  }
}

class CaptainAvailabilityTile extends StatefulWidget {
  const CaptainAvailabilityTile({super.key});

  @override
  State<CaptainAvailabilityTile> createState() =>
      _CaptainAvailabilityTileState();
}

class _CaptainAvailabilityTileState extends State<CaptainAvailabilityTile> {
  bool _isAvailable = true;

  @override
  Widget build(BuildContext context) {
    return Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      color: AppColors.white,
      child: ListTile(
        contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
        leading: Icon(
          Icons.circle,
          color: _isAvailable ? Colors.green : Colors.red,
          size: 16,
        ),
        title: Text(
          'الحالة: ${_isAvailable ? "متاح" : "غير متاح"}',
          style: Styles.font16BlackBold,
        ),
        trailing: Switch(
          value: _isAvailable,
          activeColor: AppColors.primaryColor,
          activeTrackColor: AppColors.primaryColor.withOpacity(0.2),
          inactiveTrackColor: AppColors.white,
          inactiveThumbColor: AppColors.primaryColor,
          onChanged: (val) {
            setState(() {
              _isAvailable = val;
            });
          },
        ),
      ),
    );
  }
}
