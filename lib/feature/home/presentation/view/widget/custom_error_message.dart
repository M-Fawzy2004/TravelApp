import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CustomErrorMessage extends StatelessWidget {
  const CustomErrorMessage({
    super.key,
    required this.message,
  });

  final String message;

  @override
  Widget build(BuildContext context) {
    return SliverToBoxAdapter(
      child: Center(
        child: Padding(
          padding: EdgeInsets.only(top: 50.h),
          child: Text(
            'حدث خطأ: $message',
            style: TextStyle(
              fontSize: 16.sp,
              color: Colors.red,
            ),
          ),
        ),
      ),
    );
  }
}
