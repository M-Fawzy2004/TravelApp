import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:travel_app/core/helper/spacing.dart';
import 'package:travel_app/core/theme/app_color.dart';
import 'package:travel_app/core/theme/styles.dart';

class TripAndDeliveryDropdown extends StatefulWidget {
  const TripAndDeliveryDropdown({super.key});

  @override
  State<TripAndDeliveryDropdown> createState() =>
      _TripAndDeliveryDropdownState();
}

class _TripAndDeliveryDropdownState extends State<TripAndDeliveryDropdown> {
  String _selectedOption = 'رحلة';

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 55.h,
      padding: EdgeInsets.symmetric(
        vertical: 15.h,
        horizontal: 16.w,
      ),
      decoration: BoxDecoration(
        color: AppColors.grey,
        borderRadius: BorderRadius.circular(10),
      ),
      child: Row(
        children: [
          Text(
            'اختر',
            style: Styles.font14GreyExtraBold,
          ),
          const Spacer(),
          DropdownButton<String>(
            dropdownColor: AppColors.white,
            value: _selectedOption,
            onChanged: (String? newValue) {
              setState(() {
                _selectedOption = newValue!;
              });
            },
            items: <String>['رحلة', 'توصيل']
                .map<DropdownMenuItem<String>>((String value) {
              return DropdownMenuItem<String>(
                value: value,
                child: Row(
                  children: [
                    Text(
                      value,
                      style: Styles.font14GreyExtraBold,
                    ),
                    widthBox(10),
                    Icon(
                      value == 'رحلة'
                          ? Icons.flight_takeoff
                          : Icons.local_shipping,
                      size: 18.w,
                      color: Colors.black,
                    ),
                  ],
                ),
              );
            }).toList(),
            underline: const SizedBox(),
          ),
        ],
      ),
    );
  }
}
