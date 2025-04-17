import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_nav_bar/google_nav_bar.dart';
import 'package:travel_app/core/theme/app_color.dart';

class CustomNavigationBar extends StatelessWidget {
  const CustomNavigationBar({
    super.key,
    this.onTabChange,
  });

  final Function(int)? onTabChange;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 10.h),
      margin: EdgeInsets.only(left: 7.h, right: 7.h, bottom: 7.h),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(15),
        color: AppColors.grey,
      ),
      child: GNav(
          onTabChange: onTabChange,
          haptic: true,
          curve: Curves.easeOutExpo,
          duration: Duration(milliseconds: 200),
          color: AppColors.black,
          activeColor: AppColors.primaryColor,
          tabBackgroundColor: AppColors.lightGrey,
          iconSize: 20.h,
          padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 7.h),
          tabs: [
            GButton(
              icon: FontAwesomeIcons.home,
              text: 'الرئيسيه',
            ),
            GButton(
              icon: FontAwesomeIcons.car,
              text: 'المضاف مؤخرا',
            ),
            GButton(
              icon: FontAwesomeIcons.message,
              text: 'الرسائل',
            ),
            GButton(
              icon: FontAwesomeIcons.user,
              text: 'الملف الشخصي',
            )
          ]),
    );
  }
}
