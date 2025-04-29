import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:travel_app/core/helper/spacing.dart';
import 'package:travel_app/core/theme/styles.dart';
import 'package:travel_app/core/utils/assets.dart';

class NoBookingText extends StatelessWidget {
  const NoBookingText({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          "قائمة الحجوزات فارغة... احجز رحلتك القادمة!",
          style: Styles.font16BlackBold,
        ),
        heightBox(30),
        Image.asset(
          Assets.imagesBookingLogo,
          height: 150.h,
        ),
      ],
    );
  }
}
