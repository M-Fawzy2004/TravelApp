import 'package:flutter/material.dart';

class AppColors {
  // Light Theme Colors
  static const Color primaryColor = Color(0xFF0A84FF);
  static const Color darkGrey = Color(0xFF000000);
  static const Color black = Color(0xFF000000);
  static const Color white = Color(0xFFFFFFFF);
  static const Color whitewithOpacity = Color(0xFFF3F2F8);
  static const Color grey = Color(0xFFF3F2F8);
  static const Color lightGrey = Color(0xFFA1A5B1);

  // Dark Theme Colors
  static const Color darkPrimaryColor = Color(0xFF0A84FF);
  static const Color darkBackgroundColor = Color(0xFF1C1C1E);
  static const Color darkSurfaceColor = Color(0xFF2C2C2E);
  static const Color darkTextColor = Color(0xFFFFFFFF);
  static const Color darkGreyBackground = Color(0xFF3A3A3C);
  static const Color darkLightGrey = Color(0xFF8E8E93);
  static const Color darkCardColor = Color(0xFF2C2C2E);
  static const Color darkBorderColor = Color(0xFF48484A);

  static Color getBackgroundColor(BuildContext context) {
    return Theme.of(context).brightness == Brightness.dark
        ? darkBackgroundColor
        : grey;
  }

  static Color getTextColor(BuildContext context) {
    return Theme.of(context).brightness == Brightness.dark
        ? darkTextColor
        : black;
  }

  static Color getSurfaceColor(BuildContext context) {
    return Theme.of(context).brightness == Brightness.dark
        ? darkCardColor
        : white;
  }

  static Color getGreyColor(BuildContext context) {
    return Theme.of(context).brightness == Brightness.dark
        ? darkGreyBackground
        : grey;
  }

  static Color getLightGreyColor(BuildContext context) {
    return Theme.of(context).brightness == Brightness.dark
        ? darkLightGrey
        : lightGrey;
  }

  static Color getPrimaryColor(BuildContext context) {
    return primaryColor;
  }

  static Color getDarkGreyColor(BuildContext context) {
    return Theme.of(context).brightness == Brightness.dark
        ? const Color.fromARGB(255, 156, 154, 154)
        : darkGrey;
  }

  static Color getGreyShade600(BuildContext context) {
    return Theme.of(context).brightness == Brightness.dark
        ? const Color.fromARGB(255, 156, 154, 154)
        : const Color(0xFF757575);
  }
}
