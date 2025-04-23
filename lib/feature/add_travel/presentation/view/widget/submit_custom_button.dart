import 'package:flutter/material.dart';
import 'package:travel_app/core/widget/custom_button.dart';

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
      onPressed:onPressed,
      buttonText: buttonText,
    );
  }
}
