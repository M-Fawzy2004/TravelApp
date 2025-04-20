import 'package:flutter/material.dart';
import 'package:top_snackbar_flutter/top_snack_bar.dart';
import 'package:top_snackbar_flutter/custom_snack_bar.dart';

enum SnackBarType { success, error, info }

void showCustomTopSnackBar({
  required BuildContext context,
  required String message,
  SnackBarType type = SnackBarType.info,
}) {
  final overlay = Overlay.of(context);

  showTopSnackBar(
    overlay,
    _getSnackBarByType(message, type),
    displayDuration: const Duration(seconds: 2),
  );
}

Widget _getSnackBarByType(String message, SnackBarType type) {
  switch (type) {
    case SnackBarType.success:
      return CustomSnackBar.success(message: message);
    case SnackBarType.error:
      return CustomSnackBar.error(message: message);
    case SnackBarType.info:
      return CustomSnackBar.info(message: message);
  }
}
