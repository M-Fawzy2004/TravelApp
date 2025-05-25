import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:travel_app/core/helper/spacing.dart';
import 'package:travel_app/core/theme/styles.dart';

class NoSearchResultsBox extends StatelessWidget {
  const NoSearchResultsBox({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.all(16.w),
      decoration: BoxDecoration(
        color: Colors.grey[100],
        borderRadius: BorderRadius.circular(8.r),
      ),
      child: Column(
        children: [
          Icon(
            Icons.search_off,
            size: 40.sp,
            color: Colors.grey[400],
          ),
          heightBox(8),
          Text(
            'لم يتم العثور على نتائج',
            style: Styles.font14GreyExtraBold(context),
          ),
          heightBox(4),
          Text(
            'جرب البحث بكلمات مختلفة أو تحقق من الاتصال بالإنترنت',
            style: TextStyle(
              fontSize: 12.sp,
              color: Colors.grey[500],
            ),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }
}
