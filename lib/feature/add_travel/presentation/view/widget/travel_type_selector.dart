import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:travel_app/core/theme/app_color.dart';
import 'package:travel_app/core/theme/styles.dart';
import 'package:travel_app/feature/add_travel/presentation/view/widget/row_with_label.dart';

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
    return RowWithLabel(
      label: 'نوع الرحلة',
      widget: Align(
        alignment: Alignment.centerRight,
        child: Padding(
          padding: EdgeInsets.only(bottom: 5.h),
          child: Wrap(
            spacing: 10,
            children: travelTypes.map((type) {
              return ChoiceChip(
                label: Text(
                  type,
                  style: selectedType == type
                      ? Styles.font14GreyExtraBold.copyWith(
                          color: AppColors.white,
                        )
                      : Styles.font14BlackExtraBold,
                ),
                selected: selectedType == type,
                onSelected: (selected) {
                  if (selected) {
                    onChanged(type);
                  }
                },
                selectedColor: AppColors.primaryColor,
                backgroundColor: AppColors.white,
              );
            }).toList(),
          ),
        ),
      ),
    );
  }
}
