import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:travel_app/feature/add_travel/presentation/manager/trip_cubit/trip_cubit.dart';
import 'package:travel_app/feature/add_travel/presentation/manager/trip_cubit/trip_state.dart';
import 'package:travel_app/feature/home/presentation/view/widget/custom_error_message.dart';
import 'package:travel_app/feature/home/presentation/view/widget/custom_loading_grid.dart';
import 'package:travel_app/feature/home/presentation/view/widget/custom_trip_grid.dart';

class TravelSliverGridBlocBuilder extends StatelessWidget {
  const TravelSliverGridBlocBuilder({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<TripCubit, TripState>(
      builder: (context, tripState) {
        if (tripState is TripLoading) {
          return const CustomLoadingGrid();
        } else if (tripState is TripsLoadedSuccess) {
          return CustomTripGrid(trips: tripState.trips);
        } else if (tripState is TripError) {
          return CustomErrorMessage(message: tripState.message);
        } else {
          return const SliverToBoxAdapter(child: SizedBox.shrink());
        }
      },
    );
  }
}
