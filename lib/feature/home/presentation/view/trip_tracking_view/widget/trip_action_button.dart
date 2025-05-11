import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:go_router/go_router.dart';
import 'package:slide_to_act/slide_to_act.dart';
import 'package:travel_app/core/helper/app_router.dart';
import 'package:travel_app/core/helper/spacing.dart';
import 'package:travel_app/core/theme/app_color.dart';
import 'package:travel_app/core/theme/styles.dart';
import 'package:travel_app/core/widget/custom_button.dart';

class TripActionButton extends StatefulWidget {
  const TripActionButton({super.key});

  @override
  State<TripActionButton> createState() => _TripActionButtonState();
}

class _TripActionButtonState extends State<TripActionButton> {
  String tripStatus = "جار التجهيز";
  bool _isTripStarted = false;
  bool _isTripEnded = false;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        if (!_isTripStarted)
          SlideAction(
            height: 60.h,
            sliderButtonIconPadding: 13.w,
            sliderButtonIcon: const Icon(
              FontAwesomeIcons.play,
              color: AppColors.lightGrey,
            ),
            animationDuration: const Duration(milliseconds: 500),
            borderRadius: 15.r,
            outerColor: AppColors.primaryColor,
            innerColor: AppColors.grey,
            sliderRotate: false,
            elevation: 6,
            onSubmit: () {
              setState(() {
                _isTripStarted = true;
                tripStatus = "في الطريق";
              });
              return null;
            },
            child: Text(
              'بدء الرحلة',
              style: Styles.font16WhiteBold,
            ),
          )
        else
          CustomButton(
            buttonText: 'إنهاء الرحلة',
            onPressed: _isTripEnded
                ? null
                : () {
                    setState(() {
                      _isTripEnded = true;
                      tripStatus = "مكتمل";
                    });
                    Navigator.pop(context);
                  },
          ),
        heightBox(8),
        if (_isTripStarted && !_isTripEnded)
          CustomButton(
            buttonText: 'دردشه مع الراكب',
            backgroundColor: Colors.green,
            onPressed: () {
              context.push(AppRouter.chatView);
            },
          ),
      ],
    );
  }
}
