import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:latlong2/latlong.dart';
import 'package:travel_app/core/helper/spacing.dart';
import 'package:travel_app/core/theme/app_color.dart';
import 'package:travel_app/core/theme/styles.dart';
import 'package:travel_app/core/utils/top_snakbar_app.dart';
import 'package:travel_app/feature/auth/presentation/manager/cubit/auth_cubit.dart';
import 'package:travel_app/feature/share_location/presentation/manager/address/address_cubit.dart';
import 'package:travel_app/feature/share_location/presentation/view/widget/action_button.dart';

class LocationBottomSheet extends StatelessWidget {
  final LatLng point;
  final VoidCallback? onNavigatePressed;

  const LocationBottomSheet({
    super.key,
    required this.point,
    this.onNavigatePressed,
  });

  @override
  Widget build(BuildContext context) {
    return MultiBlocListener(
      listeners: [
        // Listen for auth state changes
        BlocListener<AuthCubit, AuthState>(
          listener: (context, state) {
            if (state is AuthError) {
              showCustomTopSnackBar(
                context: context,
                message: state.message,
              );
            } else if (state is AuthSaved) {
              showCustomTopSnackBar(
                context: context,
                message: 'تم حفظ الموقع بنجاح',
              );
              Navigator.pop(context);
            }
          },
        ),
      ],
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

            // Location information section
            _buildLocationInfoSection(context),

            heightBox(24),

            // Location image placeholder
            _buildLocationImagePlaceholder(),

            heightBox(24),

            // Action buttons
            _buildActionButtons(context),

            heightBox(16),

            // Use current location button
            ActionButton(
              icon: FontAwesomeIcons.locationCrosshairs,
              label: 'استخدام موقعي الحالي',
              onPressed: () => Navigator.pop(context),
              isFullWidth: true,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildLocationInfoSection(BuildContext context) {
    return BlocBuilder<AddressCubit, AddressState>(
      builder: (context, state) {
        final bool isLoading = state is AddressLoading;
        final String? locationName =
            state is AddressLoaded ? state.address : null;

        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Location name with icon
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
            heightBox(8),
            // Coordinates
            Text(
              'الإحداثيات: ${point.latitude.toStringAsFixed(6)}, ${point.longitude.toStringAsFixed(6)}',
              style:
                  Styles.font14GreyExtraBold.copyWith(color: Colors.grey[600]),
            ),
          ],
        );
      },
    );
  }

  Widget _buildLocationImagePlaceholder() {
    return Container(
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
    );
  }

  Widget _buildActionButtons(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        // Save location button
        Expanded(
          child: BlocBuilder<AuthCubit, AuthState>(
            buildWhen: (previous, current) =>
                current is AuthLoading ||
                (previous is AuthLoading && current is! AuthLoading),
            builder: (context, state) {
              final bool isSaving = state is AuthLoading;

              return ActionButton(
                icon: isSaving
                    ? FontAwesomeIcons.spinner
                    : FontAwesomeIcons.floppyDisk,
                label: isSaving ? 'جاري الحفظ...' : 'حفظ الموقع',
                onPressed:
                    isSaving ? null : () => _saveLocationToUserProfile(context),
              );
            },
          ),
        ),
        widthBox(16),

        // Navigate button
        Expanded(
          child: ActionButton(
            icon: FontAwesomeIcons.route,
            label: 'التنقل إلى هنا',
            onPressed: onNavigatePressed,
            isPrimary: true,
          ),
        ),
      ],
    );
  }

  void _saveLocationToUserProfile(BuildContext context) {
    final authCubit = context.read<AuthCubit>();
    final state = authCubit.state;

    if (state is AuthAuthenticated) {
      final currentUser = state.user;
      final addressCubit = context.read<AddressCubit>();
      final addressState = addressCubit.state;
      final locationName =
          addressState is AddressLoaded ? addressState.address : 'موقع محفوظ';

      try {
        // Use AuthCubit's saveUserLocation instead of AddressCubit
        authCubit.saveUserLocation(
          currentUser.id,
          point.latitude,
          point.longitude,
          locationName,
        );
      } catch (e) {
        debugPrint('Error saving location: $e');
        showCustomTopSnackBar(
          context: context,
          message: 'حدث خطأ أثناء حفظ الموقع',
        );
      }
    } else {
      // Show error message - user not authenticated
      showCustomTopSnackBar(
        context: context,
        message: 'يجب تسجيل الدخول أولاً لحفظ الموقع',
      );
    }
  }
}
