import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:travel_app/core/helper/spacing.dart';
import 'package:travel_app/core/theme/styles.dart';
import 'package:travel_app/core/widget/custom_button.dart';
import 'package:travel_app/feature/home/presentation/view/ride_view/presentation/view/passenger_directory/presentation/view/widget/car_type_selector.dart';
import 'package:travel_app/feature/home/presentation/view/ride_view/presentation/view/passenger_directory/presentation/view/widget/ride_fee_row.dart';

class RideRequestUI extends StatefulWidget {
  final double? estimatedFare;
  final double? distanceKm;
  final int? durationMin;
  final Function(int) onRequestRide;
  final bool isDestinationSelected;

  const RideRequestUI({
    super.key,
    this.estimatedFare,
    this.distanceKm,
    this.durationMin,
    required this.onRequestRide,
    required this.isDestinationSelected,
  });

  @override
  State<RideRequestUI> createState() => _RideRequestUIState();
}

class _RideRequestUIState extends State<RideRequestUI> {
  int selectedCarType = 0;
  final carOptions = [
    {
      'type': 'سياره',
      'icon': FontAwesomeIcons.car,
      'multiplier': 1.0,
    },
    {
      'type': 'موتسيكل',
      'icon': FontAwesomeIcons.motorcycle,
      'multiplier': 0.7,
    },
  ];

  @override
  Widget build(BuildContext context) {
    // Calculate the actual fare based on vehicle type
    double? actualFare;
    if (widget.estimatedFare != null) {
      final multiplier = carOptions[selectedCarType]['multiplier'] as double;
      actualFare = widget.estimatedFare! * multiplier;
    }

    return Container(
      padding: EdgeInsets.all(16.w),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(20.r),
          topRight: Radius.circular(20.r),
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            blurRadius: 10,
            offset: const Offset(0, -5),
          ),
        ],
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 8.h),
            child: Text(
              'اختر نوع التوصيل',
              style: Styles.font16BlackBold,
            ),
          ),
          CarTypeSelector(
            carOptions: carOptions,
            selectedCarType: selectedCarType,
            onSelect: (index) {
              setState(() {
                selectedCarType = index;
              });
            },
          ),
          heightBox(20),
          if (widget.isDestinationSelected && widget.distanceKm != null && widget.durationMin != null) 
            Column(
              children: [
                RideFeeRow(
                  fare: actualFare?.toStringAsFixed(2) ?? '-',
                  distance: widget.distanceKm?.toStringAsFixed(1) ?? '-',
                  duration: widget.durationMin?.toString() ?? '-',
                ),
                heightBox(10),
              ],
            ),
          heightBox(10),
          CustomButton(
            buttonText: "طلب التوصيل",
            onPressed: widget.isDestinationSelected
                ? () => widget.onRequestRide(selectedCarType)
                : null,
            isEnabled: widget.isDestinationSelected,
          ),
        ],
      ),
    );
  }
}