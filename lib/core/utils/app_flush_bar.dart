// ignore_for_file: deprecated_member_use

import 'package:another_flushbar/flushbar.dart';
import 'package:flutter/material.dart';
import 'package:travel_app/core/theme/app_color.dart';

class CustomFlushBar {
  static Future showMessage({
    required BuildContext context,
    required String message,
    Color backgroundStartColor = AppColors.primaryColor,
    Color backgroundEndColor = AppColors.darkGrey,
    Color shadowColor = Colors.blue,
    Duration duration = const Duration(seconds: 3),
  }) async {
    Flushbar(
      message: message,
      duration: duration,
      backgroundGradient: LinearGradient(
        colors: [backgroundStartColor, backgroundEndColor],
      ),
      boxShadows: [
        BoxShadow(
          color: shadowColor.withOpacity(0.8),
          offset: Offset(0.0, 2.0),
          blurRadius: 3.0,
        )
      ],
      borderRadius: BorderRadius.circular(8),
      margin: EdgeInsets.all(8),
    ).show(context);
  }
}
