// ignore_for_file: unrelated_type_equality_checks

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:travel_app/core/helper/get_user.dart';
import 'package:travel_app/core/services/get_it_setup.dart';
import 'package:travel_app/feature/add_travel/presentation/manager/trip_cubit/trip_cubit.dart';
import 'package:travel_app/feature/auth/domain/entity/user_entity.dart';
import 'package:travel_app/feature/home/presentation/view/widget/custom_add_travel.dart';
import 'package:travel_app/feature/home/presentation/view/widget/home_view_body.dart';

class HomeView extends StatelessWidget {
  const HomeView({super.key});

  @override
  Widget build(BuildContext context) {
    final userRole = getUser()?.role;
    final isCaptain = userRole == UserRole.captain;
    return BlocProvider(
      create: (_) => getIt<TripCubit>()..getAllTrips(),
      child: Scaffold(
        floatingActionButtonLocation: FloatingActionButtonLocation.miniEndFloat,
        floatingActionButton: isCaptain ? const CustomAddTravel() : null,
        body: SafeArea(
          child: HomeViewBody(),
        ),
      ),
    );
  }
}
