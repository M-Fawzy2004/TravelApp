import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:travel_app/core/helper/spacing.dart';
import 'package:travel_app/core/theme/app_color.dart';
import 'package:travel_app/core/theme/styles.dart';
import 'package:travel_app/feature/add_travel/presentation/view/widget/h_search_text.dart';

class SearchHeaderRow extends StatelessWidget {
  final int currentSearchCount;

  const SearchHeaderRow({
    super.key,
    required this.currentSearchCount,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Icon(
          Icons.image_search,
          color: AppColors.getPrimaryColor(context),
          size: 24.sp,
        ),
        widthBox(8),
        Expanded(
          child: Text(
            'اختر صورة للوجهة',
            style: Styles.font16BlackBold(context),
          ),
        ),
        if (currentSearchCount > 0)
          HSearchText(currentSearchCount: currentSearchCount),
      ],
    );
  }
}
