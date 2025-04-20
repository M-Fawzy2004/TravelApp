import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class GradientSelector extends StatelessWidget {
  final List<LinearGradient> gradients;
  final LinearGradient selectedGradient;
  final ValueChanged<LinearGradient> onChanged;

  const GradientSelector({
    super.key,
    required this.gradients,
    required this.selectedGradient,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.centerRight,
      child: Wrap(
        spacing: 8,
        children: gradients.map((gradient) {
          final isSelected = gradient == selectedGradient;
          return GestureDetector(
            onTap: () => onChanged(gradient),
            child: Container(
              width: 40,
              height: 40,
              decoration: BoxDecoration(
                shape: BoxShape.rectangle,
                borderRadius: BorderRadius.circular(10.r),
                gradient: gradient,
                border: isSelected
                    ? Border.all(color: Colors.black, width: 2)
                    : null,
              ),
            ),
          );
        }).toList(),
      ),
    );
  }
}
