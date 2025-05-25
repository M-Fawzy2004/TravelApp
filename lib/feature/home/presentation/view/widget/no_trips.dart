import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:travel_app/core/helper/get_user.dart';
import 'package:travel_app/core/helper/spacing.dart';
import 'package:travel_app/core/theme/styles.dart';
import 'package:travel_app/core/utils/assets.dart';
import 'package:travel_app/feature/auth/domain/entity/user_entity.dart';

class NoTrips extends StatelessWidget {
  const NoTrips({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final role = getUser()?.role;

    return SliverToBoxAdapter(
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            if (role == UserRole.passenger) ...[
              heightBox(50)
            ] else ...[
              heightBox(200)
            ],
            Text(
              role == UserRole.passenger
                  ? "لا توجد رحلات متاحة حالياً"
                  : "ابدأ بإضافة رحلتك الأولى الآن!",
              style: Styles.font18BlackBold(context),
            ),
            heightBox(30),
            Image.asset(Assets.imagesNoTripsLogo, height: 100.h),
          ],
        ),
      ),
    );
  }
}
