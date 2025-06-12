import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:travel_app/core/helper/get_user.dart';
import 'package:travel_app/core/services/get_it_setup.dart';
import 'package:travel_app/feature/add_travel/presentation/manager/trip_cubit/trip_cubit.dart';
import 'package:travel_app/feature/auth/domain/entity/user_entity.dart';
import 'package:travel_app/feature/auth/presentation/view/login_view.dart';
import 'package:travel_app/feature/home/presentation/manager/cubit/connectivity_cubit.dart';
import 'package:travel_app/feature/home/presentation/view/captain_view/view/captain_home_view.dart';
import 'package:travel_app/feature/home/presentation/view/passenger_view/view/passenger_home_view.dart';
import 'package:travel_app/feature/trip_booking/presentation/manager/booking_cubit/booking_cubit.dart';

Widget buildHomeScreenByRole(UserRole? role) {
  final user = getUser();
  switch (role) {
    case UserRole.passenger:
      return MultiBlocProvider(
        providers: [
          BlocProvider(create: (_) => getIt<TripCubit>()..getAllTrips()),
          BlocProvider(create: (_) => getIt<ConnectivityCubit>()),
          BlocProvider(create: (_) => getIt<BookingCubit>()),
        ],
        child: const PassengerHomeView(),
      );
    case UserRole.captain:
      return MultiBlocProvider(
        providers: [
          BlocProvider(
            create: (_) => getIt<TripCubit>()..getTripsByCaptainId(user!.id),
          ),
          BlocProvider(create: (_) => getIt<ConnectivityCubit>()),
          BlocProvider(create: (_) => getIt<BookingCubit>()),
        ],
        child: const CaptainHomeView(),
      );
    default:
      return const LoginView();
  }
}
