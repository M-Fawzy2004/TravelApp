import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:travel_app/core/theme/app_color.dart';
import 'package:travel_app/core/theme/styles.dart';

class DetailsInfoRow extends StatelessWidget {
  const DetailsInfoRow({
    super.key,
    required this.icon,
    required this.label,
    required this.value,
  });

  final IconData icon;
  final String label;
  final String value;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Icon(icon, color: AppColors.getPrimaryColor(context), size: 20.sp),
        SizedBox(width: 10.w),
        Expanded(
          child: Text(
            label,
            style: Styles.font14DarkGreyBold(context),
          ),
        ),
        Text(
          value,
          style: Styles.font14GreyExtraBold(context),
        ),
      ],
    );
  }
}
