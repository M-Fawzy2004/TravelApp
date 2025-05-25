import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:travel_app/core/helper/spacing.dart';
import 'package:travel_app/core/theme/app_color.dart';
import 'package:travel_app/core/theme/styles.dart';

class RideOptionTile extends StatelessWidget {
  final String title;
  final String price;
  final IconData icon;
  final bool isSelected;
  final VoidCallback? onTap;

  const RideOptionTile({
    super.key,
    required this.title,
    required this.price,
    required this.icon,
    required this.isSelected,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: GestureDetector(
        onTap: onTap,
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 400),
          padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 8.h),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(10.r),
            border: Border.all(
              color: isSelected
                  ? AppColors.getPrimaryColor(context)
                  : AppColors.getLightGreyColor(context),
              width: isSelected ? 2 : 1,
            ),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  children: [
                    Icon(
                      icon,
                      size: 30.h,
                      color: Colors.grey[600],
                    ),
                    const Spacer(),
                    heightBox(8),
                    Text(title, style: Styles.font12GreyExtraBold(context)),
                  ],
                ),
              ),
              Container(
                width: double.infinity,
                padding: EdgeInsets.symmetric(vertical: 5.h),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10.r),
                  color: isSelected
                      ? AppColors.getPrimaryColor(context).withOpacity(0.3)
                      : AppColors.getBackgroundColor(context),
                ),
                child: Center(
                  child: Text(price, style: Styles.font14GreyExtraBold(context)),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
