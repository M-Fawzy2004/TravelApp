import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:travel_app/core/helper/get_user.dart';
import 'package:travel_app/core/theme/styles.dart';
import 'package:travel_app/feature/auth/domain/entity/user_entity.dart';
import 'package:travel_app/feature/home/presentation/view/widget/add_travel_captain.dart';

class CustomTripGrid extends StatelessWidget {
  const CustomTripGrid({
    super.key,
    required this.trips,
    this.index,
  });

  final List trips;
  final int? index;

  @override
  Widget build(BuildContext context) {
    final role = getUser()?.role;
    if (trips.isEmpty) {
      return SliverToBoxAdapter(
        child: Center(
          child: Padding(
            padding: EdgeInsets.only(top: 200.h),
            child: Text(
              role == UserRole.passenger
                  ? 'لم يتم اضافة رحلات بعد'
                  : 'لم تضيف رحلات بعد',
              style: Styles.font18BlackBold,
            ),
          ),
        ),
      );
    }
    return SliverPadding(
      padding: EdgeInsets.only(bottom: 80.h),
      sliver: SliverGrid(
        delegate: SliverChildBuilderDelegate(
          (context, index) {
            final trip = trips[index];
            return Padding(
              padding: EdgeInsets.symmetric(vertical: 4.w),
              child: AddTravelCaptain(
                trip: trip,
                index: index,
              ),
            );
          },
          childCount: trips.length,
        ),
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 1,
          mainAxisExtent: 230.h,
        ),
      ),
    );
  }
}
