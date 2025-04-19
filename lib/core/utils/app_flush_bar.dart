import 'package:another_flushbar/flushbar.dart';
import 'package:flutter/material.dart';
import 'package:travel_app/core/theme/app_color.dart';

class CustomFlushBarWidget extends StatelessWidget {
  final String message;
  final Color? backgroundColor;

  const CustomFlushBarWidget({
    super.key,
    required this.message,
    this.backgroundColor,
  });

  @override
  Widget build(BuildContext context) {
    Future.microtask(() {
      Flushbar(
        flushbarStyle: FlushbarStyle.FLOATING,
        message: message,
        duration: const Duration(seconds: 3),
        backgroundColor: backgroundColor ?? AppColors.primaryColor,
        borderRadius: BorderRadius.circular(8),
        margin: const EdgeInsets.all(8),
      ).show(context);
    });

    return const SizedBox.shrink();
  }
}
