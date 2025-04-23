import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:travel_app/core/utils/form_controller.dart';
import 'package:travel_app/core/widget/custom_text_form_field.dart';
import 'package:travel_app/feature/add_travel/presentation/manager/trip_form_cubit/trip_form_cubit.dart';
import 'package:travel_app/feature/add_travel/presentation/view/widget/row_with_label.dart';

class DetailsField extends StatefulWidget {
  const DetailsField({super.key, this.initialValue});
  final String? initialValue;

  @override
  State<DetailsField> createState() => _DetailsFieldState();
}

class _DetailsFieldState extends State<DetailsField> {
  final _formControllers = FormControllers();

  @override
  Widget build(BuildContext context) {
    return RowWithLabel(
      label: 'تفاصيل إضافية',
      widget: CustomTextFormField(
        maxLines: 5,
        hintText: 'قم بوضع التفاصيل هنا',
        controller: _formControllers.detailsController,
        onChanged: (value) {
          context.read<TripFormCubit>().setAdditionalDetails(value);
        },
      ),
    );
  }
}
