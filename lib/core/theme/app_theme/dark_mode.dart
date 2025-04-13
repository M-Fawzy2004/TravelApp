import 'package:flutter/material.dart';
import 'package:travel_app/core/theme/app_color.dart';

ThemeData darkMode = ThemeData(
  fontFamily: 'font',
  scaffoldBackgroundColor: AppColors.black,
  colorScheme: ColorScheme.dark(
    primary: AppColors.primaryColor,
    secondary: AppColors.lightGrey,
    surface: AppColors.darkGrey,
    tertiary: AppColors.black,
    inversePrimary: AppColors.white,
  ),
  textTheme: const TextTheme(
    bodyMedium: TextStyle(color: AppColors.white),
  ),
);
