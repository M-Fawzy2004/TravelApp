import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:travel_app/core/utils/top_snakbar_app.dart';
import 'package:travel_app/feature/add_travel/data/model/trip_model.dart';
import 'package:travel_app/feature/add_travel/presentation/manager/trip_cubit/trip_cubit.dart';
import 'package:travel_app/feature/add_travel/presentation/manager/trip_cubit/trip_state.dart';
import 'package:travel_app/feature/trips_details/presentation/view/widget/details_trip_view_body.dart';

class DetailsViewBlocListener extends StatelessWidget {
  const DetailsViewBlocListener({
    super.key,
    required this.trip,
    required this.index,
  });

  final TripModel trip;
  final int index;

  @override
  Widget build(BuildContext context) {
    return BlocListener<TripCubit, TripState>(
      listener: (context, state) {
        if (state is TripOperationSuccess) {
          Navigator.pop(context);
          showCustomTopSnackBar(
            context: context,
            message: 'تم حذف الرحله بنجاح',
          );
        } else if (state is TripError) {
          showCustomTopSnackBar(
            context: context,
            message: 'حدث خطاء في حذف الرحله',
          );
        }
      },
      child: DetailsTripViewBody(
        trip: trip,
        index: index,
      ),
    );
  }
}
