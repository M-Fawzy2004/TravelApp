// station_rating_summary.dart
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:travel_app/core/helper/spacing.dart';
import 'package:travel_app/core/theme/app_color.dart';
import 'package:travel_app/core/theme/styles.dart';

class StationRatingSummary extends StatelessWidget {
  final double averageRating;
  final int totalComments;

  const StationRatingSummary({
    super.key,
    required this.averageRating,
    required this.totalComments,
  });

  @override
  Widget build(BuildContext context) {
    if (totalComments == 0) {
      return const SizedBox.shrink();
    }

    return Container(
      padding: EdgeInsets.all(16.w),
      decoration: BoxDecoration(
        color: AppColors.getPrimaryColor(context).withOpacity(0.05),
        borderRadius: BorderRadius.circular(25.r),
        border: Border.all(
          color: AppColors.getPrimaryColor(context).withOpacity(0.1),
        ),
      ),
      child: Row(
        children: [
          // Rating Display
          Column(
            children: [
              Text(
                averageRating.toStringAsFixed(1),
                style: TextStyle(
                  fontSize: 24.sp,
                  fontWeight: FontWeight.bold,
                  color: AppColors.getPrimaryColor(context),
                ),
              ),
              Row(
                children: List.generate(5, (index) {
                  return Icon(
                    index < averageRating.round()
                        ? Icons.star
                        : Icons.star_border,
                    color: Colors.amber,
                    size: 16.sp,
                  );
                }),
              ),
            ],
          ),
          widthBox(16),

          // Rating Text and Stats
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  _getRatingText(averageRating),
                  style: Styles.font16BlackBold(context),
                ),
                heightBox(4),
                Text(
                  'بناءً على $totalComments ${totalComments == 1 ? 'تقييم' : 'تقييمات'}',
                  style: Styles.font12GreyExtraBold(context),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  String _getRatingText(double rating) {
    if (rating >= 4.5) {
      return 'ممتاز';
    } else if (rating >= 3.5) {
      return 'جيد جداً';
    } else if (rating >= 2.5) {
      return 'جيد';
    } else if (rating >= 1.5) {
      return 'مقبول';
    } else {
      return 'ضعيف';
    }
  }
}
