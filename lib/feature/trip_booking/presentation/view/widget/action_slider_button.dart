import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';
import 'package:slide_to_act/slide_to_act.dart';
import 'package:travel_app/core/helper/spacing.dart';
import 'package:travel_app/core/theme/app_color.dart';
import 'package:travel_app/core/theme/styles.dart';
import 'package:travel_app/feature/trip_booking/presentation/manager/booking_cubit/booking_cubit.dart';

class ActionSliderButton extends StatelessWidget {
  const ActionSliderButton({super.key});

  @override
  Widget build(BuildContext context) {
    bool hasBookings = true;
    return Container(
      width: double.infinity,
      padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 12.h),
      margin: EdgeInsets.only(bottom: 10.h),
      decoration: BoxDecoration(
        color: AppColors.getSurfaceColor(context),
        borderRadius: BorderRadius.circular(12.r),
        boxShadow: const [
          BoxShadow(
            color: Colors.black12,
            blurRadius: 6,
            offset: Offset(0, 3),
          ),
        ],
      ),
      child: Column(
        children: [
          if (hasBookings) ...[
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'عدد الحجوزات: ${context.watch<BookingCubit>().bookingEntity.bookingItems.length}',
                  style: Styles.font14GreyExtraBold(context),
                ),
                Text(
                  'السعر: ${context.watch<BookingCubit>().bookingEntity.calculateTotalPrice()} ج.م',
                  style: Styles.font14GreyExtraBold(context),
                ),
                Text(
                  'الضريبة: ${context.watch<BookingCubit>().bookingEntity.calculateTax()} ج.م',
                  style: Styles.font14GreyExtraBold(context),
                ),
                heightBox(10),
                Container(
                  color: Colors.white,
                  width: double.infinity,
                  height: 1.h,
                ),
                heightBox(10),
                Text(
                  'المجموع الكلي: ${context.watch<BookingCubit>().bookingEntity.calculateGrandTotal()} ج.م',
                  style: Styles.font16BlackBold(context),
                ),
              ],
            ),
          ],
          heightBox(20),
          hasBookings
              ? SlideAction(
                  height: 60.h,
                  sliderButtonIconPadding: 13.w,
                  sliderButtonIcon: const Icon(FontAwesomeIcons.dollar),
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
                    'تأكيد الحجز',
                    style: Styles.font16WhiteBold(context),
                  ),
                )
              // ignore: dead_code
              : const SizedBox.shrink(),
        ],
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
              heightBox(15),
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
