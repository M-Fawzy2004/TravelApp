import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
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
        BlocListener<AuthCubit, AuthState>(
          listener: (context, state) {
            if (state is AuthError) {
              showCustomTopOverlaySnackBar(
                context: context,
                message: state.message,
                backgroundColor: Colors.red,
              );
            } else if (state is AuthSaved) {
              showCustomTopOverlaySnackBar(
                context: context,
                message: 'تم حفظ الموقع بنجاح',
                backgroundColor: AppColors.darkPrimaryColor,
              );
              Navigator.pop(context);
            }
          },
        ),
      ],
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 24.h),
        decoration: BoxDecoration(
          color: AppColors.getBackgroundColor(context),
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
                  color: AppColors.getPrimaryColor(context),
                  borderRadius: BorderRadius.circular(5.r),
                ),
              ),
            ),
            heightBox(16),
            _buildLocationInfoSection(context),
            heightBox(24),
            _buildOpenStreetMapImage(context),
            heightBox(10),
            _buildActionButtons(context),
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
            Row(
              children: [
                Icon(
                  FontAwesomeIcons.locationDot,
                  color: AppColors.getPrimaryColor(context),
                  size: 24.sp,
                ),
                widthBox(10),
                Expanded(
                  child: isLoading
                      ? Row(
                          children: [
                            Text(
                              'جاري تحميل العنوان...',
                              style: Styles.font16BlackBold(context),
                            ),
                            widthBox(10),
                            Center(
                              child: SpinKitCircle(
                                color: AppColors.getPrimaryColor(context),
                                size: 50.h,
                              ),
                            ),
                          ],
                        )
                      : Text(
                          locationName ?? 'موقع غير معروف',
                          style: Styles.font16BlackBold(context),
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                        ),
                ),
              ],
            ),
          ],
        );
      },
    );
  }

  Widget _buildOpenStreetMapImage(BuildContext context) {
    final mapImageUrl = _generateOpenStreetMapImageUrl();
    return Container(
      height: 150.h,
      width: double.infinity,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10.r),
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(10.r),
        child: Image.network(
          mapImageUrl,
          width: double.infinity,
          height: double.infinity,
          fit: BoxFit.cover,
          loadingBuilder: (context, child, loadingProgress) {
            if (loadingProgress == null) return child;
            return Center(
              child: SpinKitCircle(
                color: AppColors.getPrimaryColor(context),
                size: 30.h,
              ),
            );
          },
          errorBuilder: (context, error, stackTrace) {
            return Container(
              color: AppColors.getSurfaceColor(context),
              child: Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(
                      FontAwesomeIcons.mapLocation,
                      size: 40.sp,
                      color:
                          AppColors.getPrimaryColor(context).withOpacity(0.7),
                    ),
                    heightBox(8),
                    Text(
                      'لا يمكن تحميل صورة الخريطة',
                      style: Styles.font14GreyExtraBold(context),
                    ),
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }

  String _generateOpenStreetMapImageUrl() {
    final lat = point.latitude;
    final lng = point.longitude;

    return 'https://render.openstreetmap.org/cgi-bin/export?bbox=${lng - 0.01},${lat - 0.01},${lng + 0.01},${lat + 0.01}&scale=1&format=png';
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
        authCubit.saveUserLocation(
          currentUser.id,
          point.latitude,
          point.longitude,
          locationName,
        );
      } catch (e) {
        debugPrint('Error saving location: $e');
        showCustomTopOverlaySnackBar(
          context: context,
          message: 'حدث خطأ أثناء حفظ الموقع',
          backgroundColor: Colors.red,
        );
      }
    } else {
      // Show error message - user not authenticated
      showCustomTopOverlaySnackBar(
        context: context,
        message: 'يجب تسجيل الدخول أولاً لحفظ الموقع',
        backgroundColor: AppColors.primaryColor,
      );
    }
  }
}
