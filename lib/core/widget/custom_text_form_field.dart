import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:travel_app/core/theme/app_color.dart';
import 'package:travel_app/core/theme/styles.dart';

class CustomTextFormField extends StatefulWidget {
  const CustomTextFormField({
    super.key,
    this.hintText,
    this.contentPadding,
    this.suffixIcon,
    this.obscureText,
    this.inputTextStyle,
    this.fillColor,
    this.onSaved,
  });

  final String? hintText;
  final EdgeInsetsGeometry? contentPadding;
  final Widget? suffixIcon;
  final bool? obscureText;
  final TextStyle? inputTextStyle;
  final Color? fillColor;
  final Function(String?)? onSaved;

  @override
  State<CustomTextFormField> createState() => _CustomTextFormFieldState();
}

class _CustomTextFormFieldState extends State<CustomTextFormField> {
  late TextEditingController _controller;

  @override
  void initState() {
    super.initState();
    _controller = TextEditingController();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      onSaved: widget.onSaved,
      validator: (val) {
        if (val == null || val.isEmpty) {
          return 'الحقل مطلوب';
        } else {
          return null;
        }
      },
      obscureText: widget.obscureText ?? false,
      style: Styles.body14PrimaryExtraBold(context),
      decoration: InputDecoration(
        isDense: true,
        contentPadding: widget.contentPadding ??
            EdgeInsets.symmetric(
              vertical: 15.h,
              horizontal: 16.w,
            ),
        hintText: widget.hintText,
        hintStyle:
            widget.inputTextStyle ?? Styles.body14PrimaryExtraBold(context),
        filled: true,
        fillColor: widget.fillColor ?? AppColors.lightGrey,
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(15.r),
          borderSide: BorderSide(
            color: AppColors.primaryColor,
            width: 2.w,
          ),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(15.r),
          borderSide: BorderSide(
            color: AppColors.lightGrey,
            width: 2.w,
          ),
        ),
        suffixIcon: widget.suffixIcon,
      ),
    );
  }
}
