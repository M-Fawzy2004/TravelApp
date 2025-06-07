import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:travel_app/core/helper/spacing.dart';
import 'package:travel_app/core/theme/app_color.dart';
import 'package:travel_app/feature/auth/domain/entity/user_entity.dart';

class CustomBottomNavBar extends StatelessWidget {
  final int currentIndex;
  final Function(int) onTap;
  final UserRole role;

  const CustomBottomNavBar({
    super.key,
    required this.currentIndex,
    required this.onTap,
    required this.role,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: AppColors.getBackgroundColor(context),
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(20.r),
          topRight: Radius.circular(20.r),
        ),
      ),
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 5.h),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            _buildNavItem(
              context,
              FontAwesomeIcons.home,
              'الرئيسيه',
              0,
            ),
            _buildNavItem(
              context,
              FontAwesomeIcons.car,
              'الحجوزات',
              1,
            ),
            _buildNavItem(
              context,
              FontAwesomeIcons.bus,
              'مواقف',
              2,
            ),
            _buildNavItem(
              context,
              FontAwesomeIcons.facebookMessenger,
              'الرسائل',
              3,
            ),
            _buildNavItem(
              context,
              FontAwesomeIcons.solidUserCircle,
              'الحساب',
              4,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildNavItem(
      BuildContext context, IconData icon, String label, int index) {
    final isSelected = index == currentIndex;
    return GestureDetector(
      onTap: () => onTap(index),
      child: AnimatedContainer(
        width: 80.w,
        duration: const Duration(milliseconds: 250),
        padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 6.h),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10.r),
          border: BorderDirectional(
            bottom: BorderSide(
              color: isSelected
                  ? AppColors.getPrimaryColor(context)
                  : Colors.transparent,
              width: 2.w,
            ),
          ),
          gradient: isSelected
              ? LinearGradient(
                  begin: Alignment.bottomCenter,
                  end: Alignment.topCenter,
                  colors: [
                    AppColors.getPrimaryColor(context).withOpacity(0.15),
                    Colors.transparent,
                  ],
                )
              : null,
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(
              icon,
              size: isSelected ? 22.sp : 18.sp,
              color: isSelected
                  ? AppColors.getPrimaryColor(context)
                  : AppColors.darkLightGrey,
            ),
            heightBox(5),
            Text(
              label,
              style: TextStyle(
                fontSize: 12.sp,
                color: isSelected
                    ? AppColors.getPrimaryColor(context)
                    : AppColors.darkLightGrey,
                fontWeight: FontWeight.w600,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
