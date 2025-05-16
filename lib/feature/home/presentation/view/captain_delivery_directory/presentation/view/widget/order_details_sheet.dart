import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:travel_app/core/theme/app_color.dart';
import 'package:travel_app/feature/home/presentation/view/captain_delivery_directory/presentation/view/widget/new_order_section.dart';

class OrderDetailsSheet extends StatelessWidget {
  const OrderDetailsSheet({
    super.key,
    this.onAccept,
  });

  final void Function()? onAccept;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 10.w),
      decoration: BoxDecoration(
        color: AppColors.grey,
        borderRadius: BorderRadius.circular(20.r),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            blurRadius: 10,
            offset: const Offset(0, -5),
          ),
        ],
      ),
      child: Padding(
        padding: EdgeInsets.all(15.sp),
        child: NewOrderSection(
          onAccept: onAccept,
        ),
      ),
    );
  }
}
