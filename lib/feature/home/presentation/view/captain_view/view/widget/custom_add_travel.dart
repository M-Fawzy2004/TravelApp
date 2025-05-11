import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:go_router/go_router.dart';
import 'package:travel_app/core/helper/app_router.dart';
import 'package:travel_app/core/helper/spacing.dart';
import 'package:travel_app/core/theme/app_color.dart';
import 'package:travel_app/core/theme/styles.dart';

import 'add_trip_button.dart';

class CustomAddTravel extends StatelessWidget {
  const CustomAddTravel({super.key});

  @override
  Widget build(BuildContext context) {
    return FloatingActionButton(
      shape: const CircleBorder(),
      mini: true,
      backgroundColor: AppColors.primaryColor,
      onPressed: () {
        showModalBottomSheet(
          context: context,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.vertical(
              top: Radius.circular(10.r),
            ),
          ),
          backgroundColor: AppColors.grey,
          builder: (context) => Padding(
            padding: const EdgeInsets.all(16.0),
            child: SizedBox(
              height: 120.h,
              width: double.infinity,
              child: Column(
                children: [
                  Container(
                    height: 10.h,
                    width: 70.w,
                    decoration: BoxDecoration(
                      color: AppColors.grey,
                      borderRadius: BorderRadius.circular(20.r),
                    ),
                  ),
                  heightBox(10),
                  Text(
                    'أضف الوجهه القادمه',
                    style: Styles.font20BlackBold,
                  ),
                  heightBox(10),
                  AddTripButton(
                    onTap: () {
                      context.push(AppRouter.addTravel);
                    },
                    text: 'أضف رحلتك أو عرض توصيلك',
                  ),
                ],
              ),
            ),
          ),
        );
      },
      child: FaIcon(
        FontAwesomeIcons.plus,
        size: 15.sp,
        color: AppColors.white,
      ),
    );
  }
}
