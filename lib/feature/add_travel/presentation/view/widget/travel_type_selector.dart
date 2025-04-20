import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:travel_app/core/theme/app_color.dart';
import 'package:travel_app/core/theme/styles.dart';

class TravelTypeSelector extends StatelessWidget {
  final String selectedType;
  final List<String> travelTypes;
  final ValueChanged<String> onChanged;

  const TravelTypeSelector({
    super.key,
    required this.selectedType,
    required this.travelTypes,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.centerRight,
      child: Padding(
        padding: EdgeInsets.only(bottom: 10.h),
        child: Wrap(
          spacing: 10,
          children: travelTypes.map((type) {
            return ChoiceChip(
              label: Text(type, style: Styles.font14DarkGreyBold),
              selected: selectedType == type,
              onSelected: (selected) {
                if (selected) {
                  onChanged(type);
                }
              },
              selectedColor: Colors.blue.shade100,
              backgroundColor: Colors.grey.shade200,
              labelStyle: TextStyle(
                color: selectedType == type
                    ? AppColors.primaryColor
                    : Colors.black,
              ),
            );
          }).toList(),
        ),
      ),
    );
  }
}
