import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:travel_app/core/helper/spacing.dart';
import 'package:travel_app/core/theme/app_color.dart';
import 'package:travel_app/core/theme/styles.dart';

class NoInternetWidget extends StatelessWidget {
  const NoInternetWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return SliverToBoxAdapter(
      child: Center(
        child: Padding(
          padding: EdgeInsets.only(top: 50.h),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                Icons.wifi_off,
                size: 64.sp,
                color: AppColors.getPrimaryColor(context),
              ),
              heightBox(15),
              Text(
                'لا يوجد اتصال بالإنترنت',
                style: Styles.font18BlackBold(context),
              ),
              heightBox(10),
              Text(
                'يرجى التحقق من اتصالك والمحاولة مرة أخرى',
                style: Styles.font14GreyExtraBold(context),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
