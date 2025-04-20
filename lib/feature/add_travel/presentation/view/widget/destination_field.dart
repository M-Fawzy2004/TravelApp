import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:travel_app/core/utils/form_controller.dart';
import 'package:travel_app/core/widget/custom_text_form_field.dart';
import 'package:travel_app/feature/add_travel/presentation/manager/trip_form_cubit/trip_form_cubit.dart';
import 'package:travel_app/feature/add_travel/presentation/view/widget/row_with_label.dart';

class DestinationField extends StatefulWidget {
  const DestinationField({
    super.key,
    this.controller,
    this.errorText,
  });

  final TextEditingController? controller;
  final String? errorText;

  @override
  State<DestinationField> createState() => _DestinationFieldState();
}

class _DestinationFieldState extends State<DestinationField> {
  final _formControllers = FormControllers();

  @override
  Widget build(BuildContext context) {
    return RowWithLabel(
      label: 'اسم الوجهة أو عنوان الرحلة',
      widget: CustomTextFormField(
        hintText: 'اسم الوجهة أو عنوان الرحلة',
        controller: _formControllers.destinationController,
        errorText: widget.errorText,
        onChanged: (value) {
          context.read<TripFormCubit>().setDestinationName(value);
        },
      ),
    );
  }
}
