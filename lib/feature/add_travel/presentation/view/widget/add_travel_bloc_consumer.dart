import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:travel_app/feature/add_travel/presentation/manager/trip_form_cubit/trip_form_cubit.dart';
import 'package:travel_app/feature/add_travel/presentation/manager/trip_form_cubit/trip_form_state.dart';

class AddTravelBlocConsumer extends StatelessWidget {
  final Widget Function(BuildContext, TripFormState) builder;
  
  const AddTravelBlocConsumer({
    super.key,
    required this.builder,
  });

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<TripFormCubit, TripFormState>(
      listener: (context, state) {
        if (state.error != null) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text(state.error!)),
          );
        }
      },
      builder: (context, state) {
        return builder(context, state);
      },
    );
  }
}