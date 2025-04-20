import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:travel_app/core/widget/custom_button.dart';
import 'package:travel_app/feature/add_travel/presentation/manager/trip_form_cubit/trip_form_cubit.dart';

class SubmitCustomButton extends StatelessWidget {
  const SubmitCustomButton({
    super.key,
    this.onPressed,
    required this.buttonText,
    required this.textStyle,
  });

  final void Function()? onPressed;
  final String buttonText;
  final TextStyle textStyle;

  @override
  Widget build(BuildContext context) {
    return CustomButton(
      onPressed: onPressed == null
          ? null
          : () {
              context.read<TripFormCubit>().submitForm();
            },
      buttonText: buttonText,
      textStyle: textStyle,
    );
  }
}
