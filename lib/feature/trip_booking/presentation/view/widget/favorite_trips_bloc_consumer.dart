import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:travel_app/core/helper/spacing.dart';
import 'package:travel_app/core/theme/styles.dart';
import 'package:travel_app/core/utils/top_snakbar_app.dart';
import 'package:travel_app/feature/add_travel/data/model/trip_model.dart';
import 'package:travel_app/feature/trip_booking/presentation/view/widget/favorite_trips_list.dart';
import 'package:travel_app/feature/trip_booking/presentation/manager/favorite_cubit/favorite_cubit.dart';
import 'package:travel_app/feature/trip_booking/presentation/manager/favorite_cubit/favorite_state.dart';
import 'package:travel_app/feature/trip_booking/presentation/view/widget/no_trip_favorite.dart';
import 'package:travel_app/feature/trip_booking/presentation/view/widget/skeleton_list_loader.dart';

class FavoriteTripsBlocConsumer extends StatelessWidget {
  const FavoriteTripsBlocConsumer({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<FavoriteCubit, FavoriteState>(
      listener: (context, state) {
        if (state is FavoriteAdded) {
          showCustomTopSnackBar(
            context: context,
            message: 'تم إضافة الرحلة إلى المفضلة',
          );
        } else if (state is FavoriteRemoved) {
          ScaffoldMessenger.of(context).hideCurrentSnackBar();
          showCustomTopSnackBar(
            context: context,
            message: 'تم إضافة الرحلة إلى المفضلة',
            label: 'تراجع',
            onPressed: () {
              context
                  .read<FavoriteCubit>()
                  .undoRemoveFavorite(state.removedTrip);
            },
          );
        } else if (state is FavoriteError) {
          showCustomTopSnackBar(
            context: context,
            message: state.failure.message,
          );
        }
      },
      builder: (context, state) {
        if (state is FavoriteLoading) {
          return const SkeletonListLoader();
        } else if (state is FavoriteError) {
          return Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Icon(
                Icons.error_outline,
                size: 64,
                color: Colors.red,
              ),
              heightBox(16),
              Text(
                state.failure.message,
                style: Styles.font20ExtraBlackBold(context),
                textAlign: TextAlign.center,
              ),
            ],
          );
        } else if ((state is FavoriteLoaded && state.favorites.isNotEmpty) ||
            (state is FavoriteUpdated && state.favorites.isNotEmpty) ||
            (state is FavoriteAdded && state.favorites.isNotEmpty) ||
            (state is FavoriteRemoved && state.favorites.isNotEmpty)) {
          List<TripModel> favorites = [];
          if (state is FavoriteLoaded) {
            favorites = state.favorites;
          } else if (state is FavoriteUpdated) {
            favorites = state.favorites;
          } else if (state is FavoriteAdded) {
            favorites = state.favorites;
          } else if (state is FavoriteRemoved) {
            favorites = state.favorites;
          }
          return ListView.builder(
            physics: const BouncingScrollPhysics(),
            itemCount: favorites.length,
            itemBuilder: (context, index) {
              TripModel trip = favorites[index];
              return FavoriteTripsList(trip: trip);
            },
          );
        } else {
          return const NoTripFavorite();
        }
      },
    );
  }
}


