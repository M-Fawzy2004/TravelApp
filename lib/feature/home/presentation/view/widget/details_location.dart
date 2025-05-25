import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:travel_app/core/helper/get_user.dart';
import 'package:travel_app/core/helper/spacing.dart';
import 'package:travel_app/core/theme/app_color.dart';
import 'package:travel_app/core/theme/styles.dart';
import 'package:travel_app/core/utils/assets.dart';
import 'package:travel_app/core/utils/top_snakbar_app.dart';
import 'package:travel_app/feature/auth/domain/entity/user_entity.dart';
import 'package:travel_app/feature/auth/presentation/manager/cubit/auth_cubit.dart';
import 'package:travel_app/feature/home/presentation/view/widget/share_location_button.dart';

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
          return _loadingLocationMap();
        }

        final locationName =
            state is AuthAuthenticated ? state.user.locationName : null;

        if (locationName == null || locationName.isEmpty) {
          return _buildDefaultLocationMap();
        } else {
          return _buildSavedLocation(locationName);
        }
      },
    );
  }

  Widget _loadingLocationMap() {
    return Column(
      children: [
        Container(
          padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 10.h),
          margin: EdgeInsets.symmetric(horizontal: 10.w),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(5.r),
            color: AppColors.getSurfaceColor(context),
          ),
          child: Center(
            child: SpinKitCircle(
              color: AppColors.getPrimaryColor(context),
              size: 50.h,
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildDefaultLocationMap() {
    return Column(
      children: [
        Container(
          margin: EdgeInsets.symmetric(horizontal: 4.w),
          width: double.infinity,
          height: 130.h,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            color: AppColors.getBackgroundColor(context),
            image: const DecorationImage(
              image: AssetImage(Assets.imagesLoactionMap),
              fit: BoxFit.fill,
            ),
          ),
          child: ShareLocationButton(
            title: 'شارك موقعك',
            onLocationUpdated: () {
              context.read<AuthCubit>().getCurrentUser();
            },
          ),
        ),
        heightBox(10),
        if (role == UserRole.passenger)
          Padding(
            padding: EdgeInsets.only(right: 10.w),
            child: Text(
              'تفاصيل الموقع : الموقع الذى ستشاركه هنا هو الموقع الذى سيظهر للسائق لمعرفه مكانك للوصول إليك ',
              style: Styles.font14GreyExtraBold(context),
            ),
          ),
      ],
    );
  }

  Widget _buildSavedLocation(String locationName) {
    return Column(
      children: [
        Container(
          padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 10.h),
          margin: EdgeInsets.symmetric(horizontal: 10.w),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(5.r),
            color: AppColors.getSurfaceColor(context),
          ),
          child: Row(
            children: [
              Icon(Icons.location_on,
                  color: AppColors.getPrimaryColor(context)),
              widthBox(10),
              Expanded(
                child:
                    Text(locationName, style: Styles.font16BlackBold(context)),
              ),
              ShareLocationButton(
                title: 'تعديل',
                onLocationUpdated: () {
                  context.read<AuthCubit>().getCurrentUser();
                },
              ),
            ],
          ),
        ),
        heightBox(10),
        if (role == UserRole.passenger) ...[
          Padding(
            padding: EdgeInsets.only(right: 10.w),
            child: Text(
              'تفاصيل الموقع : الموقع الذى ستشاركه هنا هو الموقع الذى سيظهر للسائق لمعرفه مكانك للوصول إليك ',
              style: Styles.font14GreyExtraBold(context),
            ),
          ),
        ]
      ],
    );
  }
}
