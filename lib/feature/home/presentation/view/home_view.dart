import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:travel_app/core/services/get_it_setup.dart';
import 'package:travel_app/feature/add_travel/presentation/manager/trip_cubit/trip_cubit.dart';
import 'package:travel_app/feature/home/presentation/view/widget/custom_add_travel.dart';
import 'package:travel_app/feature/home/presentation/view/widget/home_view_body.dart';

class HomeView extends StatelessWidget {
  const HomeView({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => getIt<TripCubit>()..getAllTrips(),
      child: Scaffold(
        floatingActionButtonLocation: FloatingActionButtonLocation.miniEndFloat,
        floatingActionButton: CustomAddTravel(),
        body: SafeArea(
          child: HomeViewBody(),
        ),
      ),
    );
  }
}