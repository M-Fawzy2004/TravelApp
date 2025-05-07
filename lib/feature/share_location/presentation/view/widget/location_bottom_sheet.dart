// Enhanced version of LocationBottomSheet to fix crashes
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:geocoding/geocoding.dart';
import 'package:http/http.dart' as http;
import 'package:latlong2/latlong.dart';
import 'package:travel_app/core/helper/spacing.dart';
import 'package:travel_app/core/theme/app_color.dart';
import 'package:travel_app/core/theme/styles.dart';
import 'package:travel_app/core/utils/top_snakbar_app.dart';
import 'package:travel_app/feature/auth/presentation/manager/cubit/auth_cubit.dart';
import 'package:travel_app/feature/share_location/presentation/view/widget/action_button.dart';

class LocationBottomSheet extends StatefulWidget {
  final LatLng point;
  final VoidCallback? onNavigatePressed;

  const LocationBottomSheet({
    super.key,
    required this.point,
    this.onNavigatePressed,
  });

  @override
  State<LocationBottomSheet> createState() => _LocationBottomSheetState();
}

class _LocationBottomSheetState extends State<LocationBottomSheet> {
  bool isLoading = true;
  String? locationName;
  bool _isMounted = false;

  @override
  void initState() {
    super.initState();
    _isMounted = true;
    _getAddressFromCoordinates();
  }

  @override
  void dispose() {
    _isMounted = false;
    super.dispose();
  }

  // Safe setState that checks if the widget is still mounted
  void setStateIfMounted(VoidCallback fn) {
    if (_isMounted && mounted) {
      setState(fn);
    }
  }

  Future<void> _getAddressFromCoordinates() async {
    try {
      // First try with Nominatim API
      final response = await http
          .get(
            Uri.parse(
              'https://nominatim.openstreetmap.org/reverse?lat=${widget.point.latitude}&lon=${widget.point.longitude}&format=json',
            ),
          )
          .timeout(const Duration(seconds: 5));

      if (!_isMounted) return;

      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        if (data.containsKey('display_name')) {
          setStateIfMounted(() {
            locationName = data['display_name'];
            isLoading = false;
          });
          return;
        }
      }

      // Fall back to geocoding package if Nominatim fails
      final placemarks = await placemarkFromCoordinates(
        widget.point.latitude,
        widget.point.longitude,
      );

      if (!_isMounted) return;

      if (placemarks.isNotEmpty) {
        final place = placemarks.first;
        final address = [
          place.street,
          place.subLocality,
          place.locality,
          place.administrativeArea,
          place.country,
        ].where((element) => element != null).join(', ');

        setStateIfMounted(() {
          locationName = address;
          isLoading = false;
        });
      } else {
        setStateIfMounted(() {
          locationName = 'موقع غير معروف';
          isLoading = false;
        });
      }
    } catch (e) {
      debugPrint('Error getting address: $e');
      if (_isMounted) {
        setStateIfMounted(() {
          locationName = 'موقع غير معروف';
          isLoading = false;
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return LocationInfoSection(
      isLoading: isLoading,
      locationName: locationName,
      widget: widget,
    );
  }
}

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
            message: state.message,
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
            heightBox(8),
            // Coordinates
            Text(
              'الإحداثيات: ${widget.point.latitude.toStringAsFixed(6)}, ${widget.point.longitude.toStringAsFixed(6)}',
              style:
                  Styles.font14GreyExtraBold.copyWith(color: Colors.grey[600]),
            ),
            heightBox(24),

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
            heightBox(24),
            // Action buttons
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                // Save location button
                Expanded(
                  child: ActionButton(
                    icon: FontAwesomeIcons.floppyDisk,
                    label: 'حفظ الموقع',
                    onPressed: () => _saveLocationToUserProfile(context),
                  ),
                ),
                widthBox(16),

                // Navigate button
                Expanded(
                  child: ActionButton(
                    icon: FontAwesomeIcons.route,
                    label: 'التنقل إلى هنا',
                    onPressed: widget.onNavigatePressed,
                    isPrimary: true,
                  ),
                ),
              ],
            ),
            heightBox(16),

            // Use current location button
            ActionButton(
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

      try {
        // Save location to user profile
        authCubit.saveUserLocation(
          currentUser.id,
          widget.point.latitude,
          widget.point.longitude,
          locationName ?? 'موقع محفوظ',
        );

        // Show processing message
        showCustomTopSnackBar(
          context: context,
          message: 'تم حفظ الموقع بنجاح',
        );

        // Close the bottom sheet
        Navigator.pop(context);
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
