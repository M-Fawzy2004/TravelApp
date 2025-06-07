import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:travel_app/core/helper/extension.dart';
import 'package:travel_app/core/helper/get_user.dart';
import 'package:travel_app/core/helper/spacing.dart';
import 'package:travel_app/core/theme/app_color.dart';
import 'package:travel_app/core/theme/styles.dart';
import 'package:travel_app/core/utils/top_snakbar_app.dart';
import 'package:travel_app/feature/auth/domain/entity/user_entity.dart';
import 'package:travel_app/feature/auth/presentation/manager/cubit/auth_cubit.dart';
import 'package:travel_app/feature/share_location/presentation/view/share_location_view_multi_provider.dart';

class DetailsLocation extends StatefulWidget {
  const DetailsLocation({super.key});

  @override
  State<DetailsLocation> createState() => _DetailsLocationState();
}

class _DetailsLocationState extends State<DetailsLocation> {
  final role = getUser()?.role;

  @override
  void initState() {
    super.initState();
    Future.delayed(const Duration(milliseconds: 700), () {
      if (mounted) {
        context.read<AuthCubit>().getCurrentUser();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AuthCubit, AuthState>(
      listener: (context, state) {
        if (state is AuthError) {
          showCustomTopSnackBar(context: context, message: 'حدث خطأ');
        }
      },
      builder: (context, state) {
        if (state is AuthLoading) {
          return _buildLoadingState();
        }

        final locationName =
            state is AuthAuthenticated ? state.user.locationName : null;

        return _buildLocationCard(locationName);
      },
    );
  }

  Widget _buildLoadingState() {
    return Container(
      padding: EdgeInsets.all(16.w),
      margin: EdgeInsets.symmetric(horizontal: 16.w),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12.r),
        color: AppColors.getSurfaceColor(context),
      ),
      child: Center(
        child: SpinKitThreeBounce(
          color: AppColors.getPrimaryColor(context),
          size: 20.h,
        ),
      ),
    );
  }

  Widget _buildLocationCard(String? locationName) {
    final hasLocation = locationName != null && locationName.isNotEmpty;

    return Container(
      padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 12.h),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12.r),
        color: AppColors.getSurfaceColor(context),
        border: Border.all(
          color: AppColors.getPrimaryColor(context).withOpacity(0.1),
          width: 1,
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          Row(
            children: [
              Icon(
                hasLocation ? Icons.location_on : Icons.location_off,
                color: hasLocation
                    ? AppColors.getPrimaryColor(context)
                    : Colors.grey,
                size: 20.sp,
              ),
              widthBox(8),
              Expanded(
                child: Text(
                  hasLocation ? locationName : 'لم يتم تحديد الموقع',
                  style: hasLocation
                      ? Styles.font14DarkGreyExtraBold(context)
                      : Styles.font14GreyExtraBold(context),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
              _buildActionButton(hasLocation),
            ],
          ),
          if (role == UserRole.passenger) ...[
            heightBox(8),
            Text(
              hasLocation
                  ? 'سيظهر هذا الموقع للسائق للوصول إليك'
                  : 'لم يتم تحديد الموقع',
              style: Styles.font12GreyExtraBold(context),
            ),
          ],
        ],
      ),
    );
  }

  Widget _buildActionButton(bool hasLocation) {
    return TextButton.icon(
      onPressed: () {
        context.navigateWithSlideTransition(
          const ShareLocationViewMultiProvider(),
        );
        context.read<AuthCubit>().getCurrentUser();
      },
      style: TextButton.styleFrom(
        padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 6.h),
        minimumSize: Size.zero,
        tapTargetSize: MaterialTapTargetSize.shrinkWrap,
      ),
      icon: Icon(
        hasLocation ? Icons.edit : Icons.add_location_alt,
        size: 16.sp,
        color: AppColors.getPrimaryColor(context),
      ),
      label: Text(
        hasLocation ? 'تعديل' : 'إضافة',
        style: Styles.font14GreyExtraBold(context).copyWith(
          color: AppColors.primaryColor,
        ),
      ),
    );
  }
}
