import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:travel_app/core/helper/spacing.dart';
import 'package:travel_app/core/theme/app_color.dart';
import 'package:travel_app/core/theme/styles.dart';
import 'package:travel_app/core/utils/assets.dart';

class NoTripFavorite extends StatelessWidget {
  const NoTripFavorite({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Image.asset(
          Assets.imagesNoFavorites,
          height: 200.h,
          color: AppColors.primaryColor,
        ),
        heightBox(16),
        Text(
          "لا يوجد رحلات مفضلة",
          style: Styles.font20ExtraBlackBold(context),
        ),
      ],
    );
  }
}
