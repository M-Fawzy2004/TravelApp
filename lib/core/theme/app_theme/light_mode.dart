import 'package:flutter/material.dart';
import 'package:travel_app/core/theme/app_color.dart';

ThemeData lightMode = ThemeData(
  fontFamily: 'font',
  scaffoldBackgroundColor: AppColors.white,
  colorScheme: ColorScheme.light(
    primary: AppColors.primaryColor,
    secondary: AppColors.lightGrey,
    surface: AppColors.white,
    tertiary: AppColors.white,
    inversePrimary: AppColors.black,
  ),
  textTheme: const TextTheme(
    bodyMedium: TextStyle(color: AppColors.black),
  ),
);
