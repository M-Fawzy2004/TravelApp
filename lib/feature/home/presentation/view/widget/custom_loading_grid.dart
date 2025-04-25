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
      padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 10.h),
      sliver: SliverGrid(
        delegate: SliverChildBuilderDelegate(
          (context, index) {
            return Skeletonizer(
              enabled: true,
              child: Padding(
                padding: EdgeInsets.only(bottom: 25.h),
                child: AddTravelCaptain(
                  trip: getCategorySkeletonizer(),
                  index: index,
                ),
              ),
            );
          },
          childCount: 6,
        ),
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 1,
          mainAxisExtent: 280.h,
        ),
      ),
    );
  }
}
