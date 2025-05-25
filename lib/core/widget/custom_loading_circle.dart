import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:travel_app/core/theme/app_color.dart';

class CustomLoadingCircle extends StatelessWidget {
  const CustomLoadingCircle({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return SpinKitCircle(
      color: AppColors.getPrimaryColor(context),
      size: 50.h,
    );
  }
}
