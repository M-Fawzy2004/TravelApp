// ignore_for_file: deprecated_member_use

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:travel_app/core/theme/app_color.dart';
import 'package:travel_app/core/theme/styles.dart';

class SearchTextField extends StatelessWidget {
  const SearchTextField({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return TextField(
      style: Styles.font16BlackBold,
      decoration: InputDecoration(
        contentPadding: EdgeInsets.symmetric(
          vertical: 15.h,
          horizontal: 16.w,
        ),
        fillColor: AppColors.grey,
        filled: true,
        hintText: 'بحث عن رحلة معينه....',
        hintStyle: Styles.font14DarkGreyExtraBold.copyWith(
          fontWeight: FontWeight.w900,
        ),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(20.r),
          borderSide: BorderSide.none,
        ),
        suffixIcon: Padding(
          padding: const EdgeInsets.all(10.0),
          child: FaIcon(
            FontAwesomeIcons.search,
            size: 20.sp,
          ),
        ),
      ),
    );
  }
}
