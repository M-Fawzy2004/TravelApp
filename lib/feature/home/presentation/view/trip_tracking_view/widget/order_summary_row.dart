import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:travel_app/core/helper/spacing.dart';
import 'package:travel_app/core/theme/app_color.dart';
import 'package:travel_app/core/theme/styles.dart';

class OrderSummaryRow extends StatelessWidget {
  const OrderSummaryRow({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(
        horizontal: 10.w,
        vertical: 8.h,
      ),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10.r),
        color: AppColors.primaryColor.withOpacity(.1),
      ),
      child: Row(
        children: [
          Icon(FontAwesomeIcons.users, color: Colors.purple, size: 20.sp),
          widthBox(8),
          Text(
            'عدد الأفراد: 2',
            style: Styles.font16BlackBold,
          ),
          const Spacer(),
          Icon(FontAwesomeIcons.dollar, color: Colors.amber, size: 20.sp),
          widthBox(8),
          Text(
            'السعر:50 جنيه',
            style: Styles.font16BlackBold,
          ),
        ],
      ),
    );
  }
}
