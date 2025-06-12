// ignore_for_file: depend_on_referenced_packages
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:travel_app/core/helper/extension.dart';
import 'package:travel_app/core/helper/spacing.dart';
import 'package:travel_app/core/theme/app_color.dart';
import 'package:travel_app/feature/add_travel/data/model/trip_model.dart';
import 'package:travel_app/feature/trip_booking/presentation/manager/favorite_cubit/favorite_cubit.dart';
import 'package:travel_app/feature/trip_booking/presentation/view/widget/image_favorite.dart';
import 'package:travel_app/feature/trip_booking/presentation/view/widget/trip_details_column.dart';
import 'package:travel_app/feature/trips_details/presentation/view/details_trip_view.dart';

class FavoriteTripsList extends StatelessWidget {
  const FavoriteTripsList({
    super.key,
    required this.trip,
  });

  final TripModel trip;

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 4,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(25.r),
      ),
      color: AppColors.getBackgroundColor(context),
      child: InkWell(
        onTap: () {
          context.navigateWithSlideTransition(
            DetailsTripView(trip: trip),
          );
        },
        borderRadius: BorderRadius.circular(25.r),
        child: Padding(
          padding: EdgeInsets.all(12.w),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ImageFavorite(trip: trip),
              widthBox(12),
              TripDetailsColumn(trip: trip),
              IconButton(
                icon: Icon(
                  Icons.favorite,
                  color: AppColors.getPrimaryColor(context),
                  size: 24.sp,
                ),
                onPressed: () {
                  context.read<FavoriteCubit>().toggleFavorite(trip);
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
