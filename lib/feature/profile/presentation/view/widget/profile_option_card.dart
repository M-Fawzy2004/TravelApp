import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:travel_app/core/theme/app_color.dart';
import 'package:travel_app/core/theme/styles.dart';

class ProfileOptionCard extends StatelessWidget {
  const ProfileOptionCard({
    super.key,
    required this.title,
    required this.icon,
    required this.isSelected,
    required this.onTap,
  });

  final String title;
  final IconData icon;
  final bool isSelected;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 300),
        height: 90.h,
        decoration: BoxDecoration(
          color: isSelected
              ? AppColors.getPrimaryColor(context)
              : AppColors.getSurfaceColor(context),
          borderRadius: BorderRadius.circular(10.r),
        ),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                icon,
                color: isSelected
                    ? AppColors.getSurfaceColor(context)
                    : AppColors.getLightGreyColor(context),
                size: 30,
              ),
              Text(
                title,
                style: isSelected
                    ? Styles.font16WhiteBold(context)
                    : Styles.font16BlackBold(context),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
