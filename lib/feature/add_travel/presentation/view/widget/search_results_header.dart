import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:travel_app/core/helper/spacing.dart';
import 'package:travel_app/core/theme/styles.dart';

class SearchResultsHeader extends StatelessWidget {
  final int resultsCount;

  const SearchResultsHeader({
    super.key,
    required this.resultsCount,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          'النتايج ($resultsCount صورة)',
          style: Styles.font14GreyExtraBold,
        ),
        Container(
          padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 5.h),
          decoration: BoxDecoration(
            color: Colors.green[100],
            borderRadius: BorderRadius.circular(5.r),
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(
                Icons.diversity_3,
                size: 12.sp,
                color: Colors.green[700],
              ),
              widthBox(4),
              Text(
                'صور متنوعة',
                style: Styles.font12GreyExtraBold.copyWith(
                  color: Colors.green[700],
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
