// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:travel_app/core/helper/spacing.dart';
import 'package:travel_app/core/utils/form_controller.dart';
import 'package:travel_app/core/widget/custom_text_form_field.dart';
import 'package:travel_app/feature/add_travel/presentation/manager/trip_form_cubit/trip_form_cubit.dart';
import 'package:travel_app/feature/add_travel/presentation/view/widget/row_with_label.dart';

class DurationPriceField extends StatefulWidget {
  const DurationPriceField({
    super.key,
    this.errorTextPrice,
    this.initialDuration,
    this.initialPrice,
  });

  final String? errorTextPrice;
  final String? initialDuration;
  final String? initialPrice;

  @override
  State<DurationPriceField> createState() => _DurationPriceFieldState();
}

class _DurationPriceFieldState extends State<DurationPriceField> {
  final _formControllers = FormControllers();
  @override
  void initState() {
    super.initState();
    _formControllers.durationController.text = widget.initialDuration ?? '';
    _formControllers.priceController.text = widget.initialPrice ?? '';

    if (widget.initialDuration != null && widget.initialDuration!.isNotEmpty) {
      Future.microtask(
        () {
          context.read<TripFormCubit>().setDuration(widget.initialDuration!);
        },
      );
    }

    if (widget.initialPrice != null && widget.initialPrice!.isNotEmpty) {
      Future.microtask(
        () {
          context.read<TripFormCubit>().setPrice(
                double.tryParse(widget.initialPrice!) ?? 0.0,
              );
        },
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return RowWithLabel(
      label: 'المدة المتوقعة / سعر الفرد',
      widget: Row(
        children: [
          Expanded(
            child: CustomTextFormField(
              hintText: 'المدة المتوقعة',
              controller: _formControllers.durationController,
              onChanged: (value) {
                context.read<TripFormCubit>().setDuration(value);
              },
            ),
          ),
          widthBox(10),
          Expanded(
            child: CustomTextFormField(
              hintText: 'سعر الفرد',
              keyboardType: TextInputType.number,
              controller: _formControllers.priceController,
              errorText: widget.errorTextPrice,
              onChanged: (value) {
                context.read<TripFormCubit>().setPrice(
                      double.tryParse(value) ?? 0.0,
                    );
              },
            ),
          ),
        ],
      ),
    );
  }
}
