import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:travel_app/core/utils/form_controller.dart';
import 'package:travel_app/core/widget/custom_text_form_field.dart';
import 'package:travel_app/feature/add_travel/presentation/manager/trip_form_cubit/trip_form_cubit.dart';
import 'package:travel_app/feature/add_travel/presentation/view/widget/row_with_label.dart';

class SeatsField extends StatefulWidget {
  const SeatsField({
    super.key,
    this.controller,
    this.errorText,
  });

  final TextEditingController? controller;
  final String? errorText;

  @override
  State<SeatsField> createState() => _SeatsFieldState();
}

class _SeatsFieldState extends State<SeatsField> {
  final _formControllers = FormControllers();

  @override
  Widget build(BuildContext context) {
    return RowWithLabel(
      label: 'عدد المقاعد الفارغة',
      widget: CustomTextFormField(
        hintText: 'عدد المقاعد الفارغة',
        keyboardType: TextInputType.number,
        controller: _formControllers.seatsController,
        errorText: widget.errorText,
        onChanged: (value) {
          context.read<TripFormCubit>().setAvailableSeats(
                int.tryParse(value) ?? 0,
              );
        },
      ),
    );
  }
}
