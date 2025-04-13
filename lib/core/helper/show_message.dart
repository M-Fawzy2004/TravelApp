import 'package:another_flushbar/flushbar.dart';
import 'package:flutter/material.dart';
import 'package:travel_app/core/theme/app_color.dart';

void showMessage(BuildContext context, String? message) {
  Flushbar(
    message: message ?? 'حدث خطأ ما',
    icon: Icon(
      Icons.info_outline,
      size: 28.0,
      color: AppColors.primaryColor,
    ),
    margin: EdgeInsets.all(6.0),
    flushbarStyle: FlushbarStyle.FLOATING,
    flushbarPosition: FlushbarPosition.TOP,
    textDirection: Directionality.of(context),
    borderRadius: BorderRadius.circular(12),
    duration: Duration(seconds: 3),
    leftBarIndicatorColor: Colors.blue[300],
  ).show(context);
}
