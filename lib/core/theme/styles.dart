import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:travel_app/core/theme/font_weight_helper.dart';

class Styles {
  static TextStyle headline20Bold(BuildContext context) => TextStyle(
        fontSize: 20.sp,
        fontWeight: FontWeightHelper.extraBold,
        color: Theme.of(context).colorScheme.inversePrimary,
      );

  static TextStyle body14PrimarySemiBold(BuildContext context) => TextStyle(
        fontSize: 14.sp,
        fontWeight: FontWeightHelper.semiBold,
        color: Theme.of(context).colorScheme.primary,
      );

  static TextStyle body14PrimaryExtraBold(BuildContext context) => TextStyle(
        fontSize: 14.sp,
        fontWeight: FontWeightHelper.extraBold,
        color: Theme.of(context).colorScheme.primary,
      );

  static TextStyle body16SurfaceBold(BuildContext context) => TextStyle(
        fontSize: 16.sp,
        fontWeight: FontWeightHelper.bold,
        color: Theme.of(context).colorScheme.surface,
      );

  static TextStyle body16TertiaryBold(BuildContext context) => TextStyle(
        fontSize: 16.sp,
        fontWeight: FontWeightHelper.bold,
        color: Theme.of(context).colorScheme.tertiary,
      );

  static TextStyle button16PrimaryBold(BuildContext context) => TextStyle(
        fontSize: 16.sp,
        fontWeight: FontWeightHelper.bold,
        color: Theme.of(context).colorScheme.inversePrimary,
      );
}
