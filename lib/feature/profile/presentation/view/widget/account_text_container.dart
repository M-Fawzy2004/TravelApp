import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:travel_app/core/theme/app_color.dart';
import 'package:travel_app/core/theme/styles.dart';

class AccountTextContainer extends StatelessWidget {
  const AccountTextContainer({
    super.key,
    required this.title,
  });

  final String title;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.symmetric(vertical: 7.h),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(25.r),
        color: AppColors.getPrimaryColor(context).withOpacity(0.1),
      ),
      child: Center(
        child: Text(
          title,
          style: Styles.font20ExtraBlackBold(context),
        ),
      ),
    );
  }
}
