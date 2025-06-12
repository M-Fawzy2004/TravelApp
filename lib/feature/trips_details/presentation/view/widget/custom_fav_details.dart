import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:travel_app/core/theme/app_color.dart';
import 'package:travel_app/feature/add_travel/data/model/trip_model.dart';
import 'package:travel_app/feature/trip_booking/presentation/manager/favorite_cubit/favorite_cubit.dart';

class CustomFavDetails extends StatelessWidget {
  const CustomFavDetails({super.key, required this.trip});

  final TripModel trip;

  @override
  Widget build(BuildContext context) {
    final isFavorite =
        context.watch<FavoriteCubit>().favoriteEntity.isExist(trip);
    return GestureDetector(
      onTap: () {
        context.read<FavoriteCubit>().toggleFavorite(trip);
      },
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 300),
        padding: EdgeInsets.symmetric(
          horizontal: 10.w,
          vertical: 12.5.h,
        ),
        decoration: BoxDecoration(
          color: isFavorite
              ? AppColors.primaryColor.withOpacity(0.4)
              : AppColors.getBackgroundColor(context),
          borderRadius: BorderRadius.circular(25.r),
        ),
        child: Icon(
          isFavorite ? FontAwesomeIcons.solidHeart : FontAwesomeIcons.heart,
          color: AppColors.primaryColor,
        ),
      ),
    );
  }
}
