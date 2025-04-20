import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:travel_app/feature/home/presentation/view/widget/category_travel.dart';

class CustomTripGrid extends StatelessWidget {
  const CustomTripGrid({
    super.key,
    required this.trips,
  });

  final List trips;

  @override
  Widget build(BuildContext context) {
    if (trips.isEmpty) {
      return SliverToBoxAdapter(
        child: Center(
          child: Padding(
            padding: EdgeInsets.only(top: 200.h),
            child: Text(
              'لا توجد رحلات متاحة حاليًا',
              style: TextStyle(
                fontSize: 18.sp,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ),
      );
    }
    return SliverPadding(
      padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 10.h),
      sliver: SliverGrid(
        delegate: SliverChildBuilderDelegate(
          (context, index) {
            final trip = trips[index];
            return TweenAnimationBuilder<double>(
              tween: Tween<double>(begin: 0, end: 1),
              duration: Duration(milliseconds: 300 + (index * 50)),
              builder: (context, value, child) {
                return Opacity(
                  opacity: value,
                  child: Transform.translate(
                    offset: Offset(0, 20 * (1 - value)),
                    child: child,
                  ),
                );
              },
              child: CategoryTravel(trip: trip),
            );
          },
          childCount: trips.length,
        ),
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 1,
          mainAxisSpacing: 10.h,
          crossAxisSpacing: 10.w,
          childAspectRatio: 1.45.h,
        ),
      ),
    );
  }
}
