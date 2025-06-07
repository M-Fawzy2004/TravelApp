import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:travel_app/core/theme/app_color.dart';
import 'package:travel_app/core/theme/styles.dart';

class SearchPoistionBusField extends StatelessWidget {
  const SearchPoistionBusField({
    super.key,
    required this.hintText,
    this.controller,
    this.onChanged,
  });

  final String hintText;
  final TextEditingController? controller;
  final Function(String)? onChanged;

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: controller,
      onChanged: onChanged,
      style: Styles.font16BlackBold(context),
      decoration: InputDecoration(
        contentPadding: EdgeInsets.symmetric(
          horizontal: 16.w,
        ),
        fillColor: AppColors.getSurfaceColor(context),
        filled: true,
        hintText: hintText,
        hintStyle: Styles.font14DarkGreyExtraBold(context).copyWith(
          fontWeight: FontWeight.w900,
        ),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10.r),
          borderSide: BorderSide.none,
        ),
        suffixIcon: controller?.text.isNotEmpty == true
            ? IconButton(
                icon: Icon(
                  Icons.clear,
                  size: 18.sp,
                  color: AppColors.darkPrimaryColor.withOpacity(0.6),
                ),
                onPressed: () {
                  controller?.clear();
                  onChanged?.call('');
                },
              )
            : null,
      ),
    );
  }
}
