import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:travel_app/core/theme/app_color.dart';
import 'package:travel_app/core/theme/styles.dart';
import 'package:travel_app/feature/share_location/presentation/view/widget/location_bottom_sheet.dart';

class LocationInfoSection extends StatelessWidget {
  final bool isLoading;
  final String? locationName;
  final LocationBottomSheet widget;

  const LocationInfoSection({
    Key? key,
    required this.isLoading,
    required this.locationName,
    required this.widget,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 24.h),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.vertical(top: Radius.circular(20.r)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          // Handle bar
          Center(
            child: Container(
              width: 40.w,
              height: 5.h,
              decoration: BoxDecoration(
                color: Colors.grey[300],
                borderRadius: BorderRadius.circular(5.r),
              ),
            ),
          ),
          SizedBox(height: 16.h),

          // Location information
          Row(
            children: [
              Icon(
                FontAwesomeIcons.locationDot,
                color: AppColors.primaryColor,
                size: 24.sp,
              ),
              SizedBox(width: 10.w),
              Expanded(
                child: isLoading
                    ? Row(
                        children: [
                          Text(
                            'جاري تحميل العنوان...',
                            style: Styles.font16BlackBold,
                          ),
                          SizedBox(width: 10.w),
                          SizedBox(
                            width: 15.w,
                            height: 15.h,
                            child: const CircularProgressIndicator(
                              strokeWidth: 2,
                              color: AppColors.primaryColor,
                            ),
                          ),
                        ],
                      )
                    : Text(
                        locationName ?? 'موقع غير معروف',
                        style: Styles.font16BlackBold,
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                      ),
              ),
            ],
          ),
          SizedBox(height: 8.h),

          // Coordinates
          Text(
            'الإحداثيات: ${widget.point.latitude.toStringAsFixed(6)}, ${widget.point.longitude.toStringAsFixed(6)}',
            style: Styles.font14GreyExtraBold.copyWith(color: Colors.grey[600]),
          ),
          SizedBox(height: 24.h),

          // Action buttons
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              // Search nearby button
              Expanded(
                child: _ActionButton(
                  icon: FontAwesomeIcons.magnifyingGlass,
                  label: 'بحث قريب',
                  onPressed: () {
                    Navigator.pop(context);
                    // Implement nearby search functionality
                    _showNearbySearchDialog(context);
                  },
                ),
              ),
              SizedBox(width: 16.w),

              // Navigate button
              Expanded(
                child: _ActionButton(
                  icon: FontAwesomeIcons.route,
                  label: 'التنقل إلى هنا',
                  onPressed: widget.onNavigatePressed,
                  isPrimary: true,
                ),
              ),
            ],
          ),
          SizedBox(height: 16.h),

          // Use current location button
          _ActionButton(
            icon: FontAwesomeIcons.locationCrosshairs,
            label: 'استخدام موقعي الحالي',
            onPressed: () {
              Navigator.pop(context);
              // This functionality should be implemented in the parent widget
              // The parent widget already has access to the current location
            },
            isFullWidth: true,
          ),
        ],
      ),
    );
  }

  void _showNearbySearchDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text(
          'بحث في المنطقة المحيطة',
          style: Styles.font18BlackBold,
          textAlign: TextAlign.center,
        ),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            _SearchCategoryButton(
              icon: FontAwesomeIcons.hotel,
              label: 'فنادق',
              onPressed: () {
                Navigator.pop(context);
                // Implement search for hotels
              },
            ),
            SizedBox(height: 8.h),
            _SearchCategoryButton(
              icon: FontAwesomeIcons.utensils,
              label: 'مطاعم',
              onPressed: () {
                Navigator.pop(context);
                // Implement search for restaurants
              },
            ),
            SizedBox(height: 8.h),
            _SearchCategoryButton(
              icon: FontAwesomeIcons.landmark,
              label: 'معالم سياحية',
              onPressed: () {
                Navigator.pop(context);
                // Implement search for attractions
              },
            ),
            SizedBox(height: 8.h),
            _SearchCategoryButton(
              icon: FontAwesomeIcons.gasPump,
              label: 'محطات وقود',
              onPressed: () {
                Navigator.pop(context);
                // Implement search for gas stations
              },
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text(
              'إلغاء',
              style: Styles.font16BlackBold
                  .copyWith(color: AppColors.primaryColor),
            ),
          ),
        ],
      ),
    );
  }
}

class _ActionButton extends StatelessWidget {
  final IconData icon;
  final String label;
  final VoidCallback? onPressed;
  final bool isPrimary;
  final bool isFullWidth;

  const _ActionButton({
    required this.icon,
    required this.label,
    this.onPressed,
    this.isPrimary = false,
    this.isFullWidth = false,
  });

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onPressed,
      style: ElevatedButton.styleFrom(
        backgroundColor: isPrimary ? AppColors.primaryColor : Colors.white,
        foregroundColor: isPrimary ? Colors.white : AppColors.primaryColor,
        side: isPrimary
            ? null
            : const BorderSide(color: AppColors.primaryColor, width: 1),
        padding: EdgeInsets.symmetric(vertical: 12.h),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8.r),
        ),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(icon, size: 16.sp),
          SizedBox(width: 8.w),
          Text(
            label,
            style: Styles.font14GreyExtraBold.copyWith(
              color: isPrimary ? Colors.white : AppColors.primaryColor,
            ),
          ),
        ],
      ),
    );
  }
}

class _SearchCategoryButton extends StatelessWidget {
  final IconData icon;
  final String label;
  final VoidCallback onPressed;

  const _SearchCategoryButton({
    required this.icon,
    required this.label,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onPressed,
      borderRadius: BorderRadius.circular(8.r),
      child: Container(
        width: double.infinity,
        padding: EdgeInsets.symmetric(vertical: 12.h),
        decoration: BoxDecoration(
          border: Border.all(color: Colors.grey[300]!),
          borderRadius: BorderRadius.circular(8.r),
        ),
        child: Row(
          children: [
            SizedBox(width: 16.w),
            Icon(
              icon,
              size: 20.sp,
              color: AppColors.primaryColor,
            ),
            SizedBox(width: 16.w),
            Text(
              label,
              style: Styles.font14DarkGreyExtraBold,
            ),
          ],
        ),
      ),
    );
  }
}
