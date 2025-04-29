import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:skeletonizer/skeletonizer.dart';
import 'package:travel_app/core/utils/get_cagtegory_skeletonizer.dart';
import 'package:travel_app/feature/home/presentation/view/widget/add_travel_captain.dart';

class CustomLoadingGrid extends StatelessWidget {
  const CustomLoadingGrid({
    super.key,
    this.index,
  });

  final int? index;

  @override
  Widget build(BuildContext context) {
    return SliverPadding(
      padding: const EdgeInsets.only(bottom: 80),
      sliver: SliverGrid(
        delegate: SliverChildBuilderDelegate(
          (context, index) {
            return Skeletonizer(
              enabled: true,
              child: Padding(
                padding: EdgeInsets.symmetric(vertical: 4.w),
                child: AddTravelCaptain(
                  trip: getCategorySkeletonizer(),
                  index: index,
                ),
              ),
            );
          },
          childCount: 4,
        ),
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 1,
          crossAxisSpacing: 10.w,
          mainAxisExtent: 230.h,
        ),
      ),
    );
  }
}
