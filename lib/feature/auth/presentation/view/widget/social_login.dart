import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:travel_app/core/helper/spacing.dart';
import 'package:travel_app/core/theme/app_color.dart';
import 'package:travel_app/core/theme/styles.dart';

class SocialLogin extends StatelessWidget {
  const SocialLogin({
    super.key,
    required this.image,
    required this.text,
    this.onTap,
  });

  final String image, text;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        height: 50.h,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10.r),
          color: AppColors.getSurfaceColor(context),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(
              image,
              height: 25.h,
            ),
            widthBox(10),
            Text(
              text,
              style: Styles.font16BlackBold(context),
            ),
          ],
        ),
      ),
    );
  }
}
