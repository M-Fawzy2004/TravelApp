// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:travel_app/core/helper/spacing.dart';
import 'package:travel_app/core/utils/form_controller.dart';
import 'package:travel_app/core/widget/custom_text_form_field.dart';
import 'package:travel_app/feature/add_travel/presentation/manager/trip_form_cubit/trip_form_cubit.dart';
import 'package:travel_app/feature/add_travel/presentation/view/widget/row_with_label.dart';

class CustomLoactionField extends StatefulWidget {
  const CustomLoactionField({
    super.key,
    this.errorTextStartLocation,
    this.errorTextEndLocation,
    this.initialStartLocation,
    this.initialEndLocation,
  });

  final String? errorTextStartLocation;
  final String? errorTextEndLocation;
  final String? initialStartLocation;
  final String? initialEndLocation;

  @override
  State<CustomLoactionField> createState() => _CustomLoactionFieldState();
}

class _CustomLoactionFieldState extends State<CustomLoactionField> {
  final _formControllers = FormControllers();
  @override
  void initState() {
    super.initState();
    _formControllers.departureLocationController.text =
        widget.initialStartLocation ?? '';
    _formControllers.arrivalLocationController.text =
        widget.initialEndLocation ?? '';

    if (widget.initialStartLocation != null &&
        widget.initialStartLocation!.isNotEmpty) {
      Future.microtask(
        () {
          context
              .read<TripFormCubit>()
              .setDepartureLocation(widget.initialStartLocation!);
        },
      );
    }

    if (widget.initialEndLocation != null &&
        widget.initialEndLocation!.isNotEmpty) {
      Future.microtask(
        () {
          context
              .read<TripFormCubit>()
              .setArrivalLocation(widget.initialEndLocation!);
        },
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return RowWithLabel(
      label: 'مكان الانطلاق / مكان الوصول',
      widget: Row(
        children: [
          Expanded(
            child: CustomTextFormField(
              hintText: 'مكان الانطلاق',
              controller: _formControllers.departureLocationController,
              errorText: widget.errorTextStartLocation,
              onChanged: (value) {
                context.read<TripFormCubit>().setDepartureLocation(value);
              },
            ),
          ),
          widthBox(10),
          Expanded(
            child: CustomTextFormField(
              hintText: 'مكان الوصول',
              controller: _formControllers.arrivalLocationController,
              errorText: widget.errorTextEndLocation,
              onChanged: (value) {
                context.read<TripFormCubit>().setArrivalLocation(value);
              },
            ),
          ),
        ],
      ),
    );
  }
}
