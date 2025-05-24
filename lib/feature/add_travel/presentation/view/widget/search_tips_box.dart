import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:travel_app/core/helper/spacing.dart';
import 'package:travel_app/core/theme/app_color.dart';
import 'package:travel_app/core/theme/styles.dart';

class SearchTipsBox extends StatelessWidget {
  const SearchTipsBox({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.all(12.w),
      decoration: BoxDecoration(
        color: Colors.blue[50],
        borderRadius: BorderRadius.circular(8.r),
        border: Border.all(color: Colors.blue[200]!),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(
                Icons.lightbulb_outline,
                color: Colors.blue[600],
                size: 16.sp,
              ),
              widthBox(6),
              Text(
                'نصائح للبحث:',
                style: TextStyle(
                  fontSize: 12.sp,
                  fontWeight: FontWeight.w600,
                  color: Colors.blue[800],
                ),
              ),
            ],
          ),
          heightBox(6),
          Text(
            '• من الأفضل البحث باستخدام أسماء المدن باللغة الإنجليزية للحصول على صور أدق.\n'
            '• جرب إضافة كلمات مثل "pyramids" أو "Giza" مع اسم المدينة لتحسين النتائج.\n'
            '• اضغط "صور جديدة" للحصول على مجموعة مختلفة من الصور.\n'
            '• تأكد من اتصال الإنترنت لتحصل على نتائج أسرع وأحدث.',
            style: Styles.font12GreyExtraBold.copyWith(
              height: 1.5,
              color: AppColors.lightGrey,
            ),
          ),
        ],
      ),
    );
  }
}
