import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:shimmer/shimmer.dart';
import 'package:travel_app/core/theme/app_color.dart';
import 'package:travel_app/core/utils/get_cagtegory_skeletonizer.dart';
import 'package:travel_app/feature/home/presentation/view/captain_view/view/widget/add_travel_captain.dart';

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
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 1,
          crossAxisSpacing: 10.w,
          mainAxisExtent: 220.h,
        ),
        delegate: SliverChildBuilderDelegate(
          (context, index) {
            return Shimmer.fromColors(
              baseColor: AppColors.getPrimaryColor(context).withOpacity(0.1),
              highlightColor: Colors.grey[100]!,
              child: AddTravelCaptain(
                trip: getCategorySkeletonizer(),
              ),
            );
          },
          childCount: 5,
        ),
      ),
    );
  }
}
