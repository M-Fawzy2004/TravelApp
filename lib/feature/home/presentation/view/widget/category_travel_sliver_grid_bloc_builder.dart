import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:travel_app/feature/add_travel/presentation/manager/trip_cubit/trip_cubit.dart';
import 'package:travel_app/feature/add_travel/presentation/manager/trip_cubit/trip_state.dart';
import 'package:travel_app/feature/home/presentation/view/widget/custom_error_message.dart';
import 'package:travel_app/feature/home/presentation/view/widget/custom_loading_grid.dart';
import 'package:travel_app/feature/home/presentation/view/widget/custom_trip_grid.dart';

class CategorySliverGridGridBlocBuilder extends StatelessWidget {
  const CategorySliverGridGridBlocBuilder({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<TripCubit, TripState>(
      builder: (context, state) {
        if (state is TripLoading) {
          return CustomLoadingGrid();
        } else if (state is TripsLoadedSuccess) {
          return CustomTripGrid(trips: state.trips);
        } else if (state is TripError) {
          return CustomErrorMessage(message: state.message);
        } else {
          return const SliverToBoxAdapter(child: SizedBox.shrink());
        }
      },
    );
  }
}

