import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
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
    final screenWidth = MediaQuery.of(context).size.width;
    final isSmallScreen = screenWidth < 360;

    return Container(
      decoration: BoxDecoration(
        color: AppColors.getBackgroundColor(context),
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(20.r),
          topRight: Radius.circular(20.r),
        ),
      ),
      child: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(
            horizontal: isSmallScreen ? 8.w : 10.w,
            vertical: 8.h,
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              _buildNavItem(
                context,
                FontAwesomeIcons.home,
                'الرئيسيه',
                0,
                screenWidth,
              ),
              _buildNavItem(
                context,
                FontAwesomeIcons.landmark,
                'السياحه',
                1,
                screenWidth,
              ),
              _buildNavItem(
                context,
                FontAwesomeIcons.bus,
                'مواقف',
                2,
                screenWidth,
              ),
              _buildNavItem(
                context,
                FontAwesomeIcons.facebookMessenger,
                'الرسائل',
                3,
                screenWidth,
              ),
              _buildNavItem(
                context,
                FontAwesomeIcons.solidUserCircle,
                'الحساب',
                4,
                screenWidth,
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildNavItem(
    BuildContext context,
    IconData icon,
    String label,
    int index,
    double screenWidth,
  ) {
    final isSelected = index == currentIndex;
    final isSmallScreen = screenWidth < 360;
    final isLargeScreen = screenWidth > 414;

    // Responsive sizing calculations
    final itemWidth = (screenWidth - 40) / 5; // Distribute width evenly
    final maxWidth = isSmallScreen ? 65.0 : (isLargeScreen ? 85.0 : 75.0);
    final finalWidth = itemWidth > maxWidth ? maxWidth : itemWidth;

    final iconSize = isSelected
        ? (isSmallScreen ? 20.0 : 22.0)
        : (isSmallScreen ? 16.0 : 18.0);

    final fontSize = isSmallScreen ? 10.0 : 12.0;
    final verticalPadding = isSmallScreen ? 4.0 : 6.0;

    return Expanded(
      child: GestureDetector(
        onTap: () => onTap(index),
        behavior: HitTestBehavior.opaque,
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 250),
          curve: Curves.easeInOut,
          constraints: BoxConstraints(
            minWidth: finalWidth,
            maxWidth: finalWidth,
          ),
          padding: EdgeInsets.symmetric(
            horizontal: 4.w,
            vertical: verticalPadding,
          ),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(12.r),
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
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              AnimatedScale(
                scale: isSelected ? 1.1 : 1.0,
                duration: const Duration(milliseconds: 200),
                child: Icon(
                  icon,
                  size: iconSize,
                  color: isSelected
                      ? AppColors.getPrimaryColor(context)
                      : AppColors.darkLightGrey,
                ),
              ),
              SizedBox(height: isSmallScreen ? 2 : 4),
              Flexible(
                child: Text(
                  label,
                  style: TextStyle(
                    fontSize: fontSize,
                    color: isSelected
                        ? AppColors.getPrimaryColor(context)
                        : AppColors.darkLightGrey,
                    fontWeight: isSelected ? FontWeight.w700 : FontWeight.w600,
                    height: 1.2,
                  ),
                  textAlign: TextAlign.center,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
