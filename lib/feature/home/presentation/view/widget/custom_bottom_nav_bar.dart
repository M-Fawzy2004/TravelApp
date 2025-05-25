import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:travel_app/core/helper/get_user.dart';
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
    final role = getUser()?.role;
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
            if (role == UserRole.captain || role == UserRole.passenger) ...[
              _buildNavItem(
                context,
                FontAwesomeIcons.car,
                'الحجز',
                1,
              ),
            ] else ...[
              _buildNavItem(
                context,
                FontAwesomeIcons.clipboardList,
                'السجل',
                1,
              ),
            ],
            _buildNavItem(
              context,
              FontAwesomeIcons.facebookMessenger,
              'الرسائل',
              2,
            ),
            _buildNavItem(
              context,
              FontAwesomeIcons.solidUserCircle,
              'الحساب',
              3,
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
        width: isSelected ? 90.w : 80.w,
        duration: const Duration(milliseconds: 250),
        padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 6.h),
        decoration: BoxDecoration(
          color: isSelected
              ? AppColors.getPrimaryColor(context).withOpacity(0.3)
              : Colors.transparent,
          borderRadius: BorderRadius.circular(10.r),
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
