import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:travel_app/core/theme/app_color.dart';
import 'package:travel_app/feature/home/presentation/view/passenger_view/view/widget/swip_to_start_card.dart';

class ViewAllFeatured extends StatelessWidget {
  const ViewAllFeatured({
    super.key,
    required this.progress,
    required this.dragOffset,
    required this.canComplete,
  });

  final double progress;
  final double dragOffset;
  final bool canComplete;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        ...List.generate(
          2,
          (i) => Transform.translate(
            offset: Offset(-8.w * (i + 1) * (1 - progress), 0),
            child: Opacity(
              opacity: 0.3 + (progress * 0.4),
              child: Container(
                width: 130.w,
                height: 200.h,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(12.r),
                  color: AppColors.getBackgroundColor(context).withOpacity(0.2),
                ),
              ),
            ),
          ),
        ),
        Padding(
          padding: EdgeInsets.symmetric(vertical: 5.w),
          child: SwipeToStartCard(
            dragOffset: dragOffset,
            canComplete: canComplete,
            progress: progress,
          ),
        ),
      ],
    );
  }
}
