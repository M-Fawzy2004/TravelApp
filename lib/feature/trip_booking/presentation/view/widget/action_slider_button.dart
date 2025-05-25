import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:slide_to_act/slide_to_act.dart';
import 'package:travel_app/core/helper/spacing.dart';
import 'package:travel_app/core/theme/app_color.dart';
import 'package:travel_app/core/theme/styles.dart';

class ActionSliderButton extends StatelessWidget {
  const ActionSliderButton({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return SlideAction(
      height: 60.h,
      sliderButtonIconPadding: 13.w,
      sliderButtonIcon: const Icon(
        FontAwesomeIcons.dollar,
        color: AppColors.darkGrey,
      ),
      animationDuration: const Duration(milliseconds: 500),
      borderRadius: 15.r,
      outerColor: AppColors.getPrimaryColor(context),
      innerColor: AppColors.getBackgroundColor(context),
      sliderRotate: false,
      elevation: 6,
      onSubmit: () {
        _showBookingConfirmationDialog(context);
        Future.delayed(const Duration(seconds: 2), () {
          return null;
        });
        return null;
      },
      child: Text(
        'تأكيد الحجز  ',
        style: Styles.font16WhiteBold(context),
      ),
    );
  }

  void _showBookingConfirmationDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return CupertinoAlertDialog(
          title: Center(
            child: Text(
              'تم قبول طلب الحجز',
              style: Styles.font20BlackBold(context),
              textAlign: TextAlign.center,
            ),
          ),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              heightBox(10),
              Icon(
                FontAwesomeIcons.checkCircle,
                color: AppColors.getPrimaryColor(context),
                size: 50.h,
              ),
              SizedBox(height: 16.h),
              Text(
                'سيتم التواصل معك عند قبول الكابتن للحجز',
                style: Styles.font14GreyExtraBold(context),
                textAlign: TextAlign.center,
              ),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text(
                'حسناً',
                style: TextStyle(
                  color: AppColors.getPrimaryColor(context),
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ],
        );
      },
    );
  }
}
