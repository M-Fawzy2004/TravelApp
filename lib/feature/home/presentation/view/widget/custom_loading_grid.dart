import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:skeletonizer/skeletonizer.dart';
import 'package:travel_app/core/utils/get_cagtegory_skeletonizer.dart';
import 'package:travel_app/feature/home/presentation/view/widget/category_travel.dart';

class CustomLoadingGrid extends StatelessWidget {
  const CustomLoadingGrid({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return SliverPadding(
      padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 10.h),
      sliver: SliverGrid(
        delegate: SliverChildBuilderDelegate(
          (context, index) {
            return Skeletonizer(
              enabled: true,
              child: CategoryTravel(
                trip: getCategorySkeletonizer(),
              ),
            );
          },
          childCount: 6,
        ),
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          mainAxisSpacing: 10.h,
          crossAxisSpacing: 10.w,
          childAspectRatio: 0.8,
        ),
      ),
    );
  }
}
