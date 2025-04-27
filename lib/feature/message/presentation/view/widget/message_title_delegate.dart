import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:travel_app/core/theme/styles.dart';

class MessagesTitleDelegate extends SliverPersistentHeaderDelegate {
  @override
  double get minExtent => 45.h;
  @override
  double get maxExtent => 45.h;

  @override
  Widget build(
      BuildContext context, double shrinkOffset, bool overlapsContent) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 5.h),
      alignment: Alignment.centerRight,
      decoration: const BoxDecoration(
        color: Colors.white,
        // boxShadow: [
        //   BoxShadow(
        //     color: AppColors.black.withOpacity(.2),
        //     blurRadius: 6,
        //     spreadRadius: 0,
        //     offset: Offset(0, 1),
        //   ),
        // ],
      ),
      child: Text(
        'المحادثات',
        style: Styles.font20ExtraBlackBold,
      ),
    );
  }

  @override
  bool shouldRebuild(covariant SliverPersistentHeaderDelegate oldDelegate) {
    return false;
  }
}
