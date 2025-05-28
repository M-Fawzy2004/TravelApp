import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:travel_app/core/services/get_it_setup.dart';
import 'package:travel_app/feature/add_travel/data/model/trip_model.dart';
import 'package:travel_app/feature/add_travel/presentation/manager/trip_cubit/trip_cubit.dart';
import 'package:travel_app/feature/trip_booking/presentation/manager/booking_cubit/booking_cubit.dart';
import 'package:travel_app/feature/trip_booking/presentation/manager/favorite_cubit/favorite_cubit.dart';
import 'package:travel_app/feature/trips_details/presentation/view/widget/details_view_bloc_listener.dart';

class DetailsTripView extends StatelessWidget {
  const DetailsTripView({
    super.key,
    required this.trip,
  });

  final TripModel trip;

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider.value(value: getIt<BookingCubit>()),
        BlocProvider(create: (_) => getIt<TripCubit>()),
        BlocProvider.value(value: getIt<FavoriteCubit>()),
      ],
      child: Scaffold(
        body: SafeArea(
          child: DetailsViewBlocListener(
            trip: trip,
          ),
        ),
      ),
    );
  }
}
