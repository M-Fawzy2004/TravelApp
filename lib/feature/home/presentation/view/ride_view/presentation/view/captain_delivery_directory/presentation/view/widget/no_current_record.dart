import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:travel_app/core/helper/spacing.dart';
import 'package:travel_app/core/theme/styles.dart';
import 'package:travel_app/core/utils/assets.dart';

class NoCurrentRecord extends StatelessWidget {
  const NoCurrentRecord({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            'لا يوجد سجل رحلات لك في هذا الوقت الحالى',
            style: Styles.font16BlackBold(context),
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
