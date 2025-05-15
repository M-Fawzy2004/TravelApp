import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:travel_app/core/theme/app_color.dart';
import 'package:travel_app/feature/home/presentation/view/widget/category_filter_item.dart';

class PassengerTripTypeSelector extends StatelessWidget {
  final String selectedTripType;
  final Function(String) onTripTypeChanged;

  const PassengerTripTypeSelector({
    super.key,
    required this.selectedTripType,
    required this.onTripTypeChanged,
  });

  @override
  Widget build(BuildContext context) {
    List<String> tripTypes = ['توصيل مباشر', 'مجدولة'];

    return Row(
      children: List.generate(
        tripTypes.length,
        (index) => Padding(
          padding: EdgeInsets.only(right: 10.w),
          child: GestureDetector(
            onTap: () {
              onTripTypeChanged(tripTypes[index]);
            },
            child: CategoryFilterItem(
              text: tripTypes[index],
              isSelected: selectedTripType == tripTypes[index],
              color: AppColors.primaryColor,
            ),
          ),
        ),
      ),
    );
  }
}
