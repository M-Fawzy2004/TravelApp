// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:travel_app/core/utils/top_snakbar_app.dart';
import 'package:travel_app/feature/add_travel/presentation/manager/trip_form_cubit/trip_form_cubit.dart';
import 'package:travel_app/feature/add_travel/presentation/manager/trip_form_cubit/trip_form_state.dart';

class AddTravelBlocConsumer extends StatelessWidget {
  final Widget Function(BuildContext, TripFormState) builder;
  final bool isEditMode;

  const AddTravelBlocConsumer({
    super.key,
    required this.builder,
    this.isEditMode = false,
  });

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<TripFormCubit, TripFormState>(
      listener: (context, state) {
        if (state.error != null) {
          showCustomTopSnackBar(
            context: context,
            message: 'يرجي إكمال البيانات بشكل صحيح',
          );
        }

        if (state.isSubmitting == false && state == const TripFormState()) {
          // This means the form was successfully submitted and reset
          showCustomTopSnackBar(
            context: context,
            message:
                isEditMode ? 'تم تحديث الرحلة بنجاح' : 'تم إضافة الرحلة بنجاح',
          );

          if (isEditMode) {
            // Navigate back after successful update
            Future.delayed(const Duration(seconds: 1), () {
              Navigator.pop(context);
            });
          }
        }
      },
      builder: (context, state) {
        return builder(context, state);
      },
    );
  }
}
