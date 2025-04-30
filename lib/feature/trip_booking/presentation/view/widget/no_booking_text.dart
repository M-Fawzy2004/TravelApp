import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:travel_app/core/helper/get_user.dart';
import 'package:travel_app/core/helper/spacing.dart';
import 'package:travel_app/core/theme/styles.dart';
import 'package:travel_app/core/utils/assets.dart';
import 'package:travel_app/feature/auth/domain/entity/user_entity.dart';

class NoBookingText extends StatelessWidget {
  const NoBookingText({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final role = getUser()!.role;
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            role == UserRole.passenger
                ? "قائمة الحجوزات فارغة... احجز رحلتك القادمة!"
                : "لا توجد حجوزات حتى الآن... انتظر طلبات من الركّاب",
            style: Styles.font16BlackBold,
          ),
          heightBox(30),
          Image.asset(
            Assets.imagesBookingLogo,
            height: 150.h,
          ),
        ],
      ),
    );
  }
}
