import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:travel_app/core/services/get_it_setup.dart';
import 'package:travel_app/feature/add_travel/data/model/trip_model.dart';
import 'package:travel_app/feature/add_travel/presentation/manager/trip_cubit/trip_cubit.dart';
import 'package:travel_app/feature/trips_details/presentation/view/widget/details_view_bloc_listener.dart';

class DetailsTripView extends StatelessWidget {
  const DetailsTripView({
    super.key,
    required this.trip,
    required this.index,
  });

  final TripModel trip;
  final int index;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => getIt<TripCubit>(),
      child: Scaffold(
        body: SafeArea(
          child: Padding(
            padding: EdgeInsets.symmetric(
              horizontal: 10.w,
            ),
            child: DetailsViewBlocListener(
              trip: trip,
              index: index,
            ),
          ),
        ),
      ),
    );
  }
}
