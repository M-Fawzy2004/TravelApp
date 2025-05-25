import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:travel_app/core/theme/app_color.dart';
import 'package:travel_app/core/theme/styles.dart';
import 'package:travel_app/core/helper/spacing.dart';

class CarTypeSelector extends StatelessWidget {
  final List<Map<String, dynamic>> carOptions;
  final int selectedCarType;
  final Function(int) onSelect;

  const CarTypeSelector({
    super.key,
    required this.carOptions,
    required this.selectedCarType,
    required this.onSelect,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 80.h,
      child: Row(
        children: List.generate(
          carOptions.length,
          (index) => Expanded(
            child: GestureDetector(
              onTap: () => onSelect(index),
              child: AnimatedContainer(
                margin: EdgeInsets.only(
                  left: index == 0 ? 5.w : 0,
                  right: index == carOptions.length - 1 ? 5.w : 0,
                ),
                duration: const Duration(milliseconds: 300),
                decoration: BoxDecoration(
                  color: selectedCarType == index
                      ? AppColors.getPrimaryColor(context).withOpacity(0.5)
                      : AppColors.getBackgroundColor(context),
                  borderRadius: BorderRadius.circular(8.r),
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(
                      carOptions[index]['icon'] as IconData,
                      size: 24.w,
                      color: Colors.black54,
                    ),
                    heightBox(10),
                    Text(
                      carOptions[index]['type'] as String,
                      style: Styles.font16BlackBold(context),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
