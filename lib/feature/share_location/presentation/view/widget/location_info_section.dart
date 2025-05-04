import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:travel_app/core/theme/app_color.dart';
import 'package:travel_app/core/theme/styles.dart';
import 'package:travel_app/core/utils/top_snakbar_app.dart';
import 'package:travel_app/feature/auth/presentation/manager/cubit/auth_cubit.dart';
import 'package:travel_app/feature/share_location/presentation/view/widget/location_bottom_sheet.dart';

class LocationInfoSection extends StatelessWidget {
  final bool isLoading;
  final String? locationName;
  final LocationBottomSheet widget;

  const LocationInfoSection({
    super.key,
    required this.isLoading,
    required this.locationName,
    required this.widget,
  });

  @override
  Widget build(BuildContext context) {
    return BlocListener<AuthCubit, AuthState>(
      listener: (context, state) {
        if (state is AuthSaved) {
          showCustomTopSnackBar(
            context: context,
            message: 'تم حفظ الموقع بنجاح',
          );
        } else if (state is AuthError) {
          showCustomTopSnackBar(
            context: context,
            message: 'حدث خطأ أثناء حفظ الموقع',
          );
        }
      },
      child: Container(
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
              style:
                  Styles.font14GreyExtraBold.copyWith(color: Colors.grey[600]),
            ),
            SizedBox(height: 24.h),

            // Location image placeholder
            Container(
              height: 150.h,
              width: double.infinity,
              decoration: BoxDecoration(
                color: Colors.grey[300],
                borderRadius: BorderRadius.circular(10.r),
                image: const DecorationImage(
                  image: AssetImage('assets/images/map_placeholder.png'),
                  fit: BoxFit.cover,
                ),
              ),
              child: Center(
                child: Icon(
                  FontAwesomeIcons.mapLocation,
                  size: 40.sp,
                  color: AppColors.primaryColor.withOpacity(0.7),
                ),
              ),
            ),
            SizedBox(height: 24.h),

            // Action buttons
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                // Save location button
                Expanded(
                  child: _ActionButton(
                    icon: FontAwesomeIcons.floppyDisk,
                    label: 'حفظ الموقع',
                    onPressed: () => _saveLocationToUserProfile(context),
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
      ),
    );
  }

  void _saveLocationToUserProfile(BuildContext context) {
    final authCubit = context.read<AuthCubit>();
    final state = authCubit.state;

    if (state is AuthAuthenticated) {
      final currentUser = state.user;

      // Check if the user is already authenticated
      // Create updated user with location information
      final updatedUser = currentUser.copyWith(
        latitude: widget.point.latitude,
        longitude: widget.point.longitude,
        locationName: locationName ?? 'موقع محفوظ',
      );

      // Save the updated user data
      authCubit.saveUser(updatedUser);

      // Show success message
      showCustomTopSnackBar(
        context: context,
        message: 'جاري حفظ الموقع...',
      );

      // Close the bottom sheet
      Navigator.pop(context);
    } else {
      // Show error message
      showCustomTopSnackBar(
        context: context,
        message: 'يجب تسجيل الدخول أولاً لحفظ الموقع',
      );
    }
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
