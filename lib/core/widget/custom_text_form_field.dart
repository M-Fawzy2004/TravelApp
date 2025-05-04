// ignore_for_file: deprecated_member_use

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
    this.keyboardType,
    this.readOnly,
    this.textAlign,
    this.controller,
    this.maxLines,
    this.onChanged,
    this.errorText,
    this.prefixIcon,
  });

  final String? hintText;
  final EdgeInsetsGeometry? contentPadding;
  final Widget? suffixIcon;
  final Widget? prefixIcon;
  final bool? obscureText;
  final bool? readOnly;
  final TextStyle? inputTextStyle;
  final Color? fillColor;
  final Function(String?)? onSaved;
  final TextInputType? keyboardType;
  final TextAlign? textAlign;
  final TextEditingController? controller;
  final int? maxLines;
  final Function(String)? onChanged;
  final String? errorText;

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
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        TextFormField(
          onSaved: widget.onSaved,
          validator: (val) {
            if (val == null || val.isEmpty) {
              return 'هذا الحقل مطلوب';
            } else {
              return null;
            }
          },
          onChanged: widget.onChanged,
          controller: widget.controller,
          maxLines: widget.maxLines ?? 1,
          obscureText: widget.obscureText ?? false,
          style: Styles.font14DarkGreyExtraBold,
          readOnly: widget.readOnly ?? false,
          keyboardType: widget.keyboardType,
          textAlign: widget.textAlign ?? TextAlign.start,
          decoration: InputDecoration(
            isDense: true,
            contentPadding: widget.contentPadding ??
                EdgeInsets.symmetric(
                  vertical: 15.h,
                  horizontal: 16.w,
                ),
            hintText: widget.hintText,
            hintStyle: widget.inputTextStyle ?? Styles.font14GreyExtraBold,
            filled: true,
            fillColor: widget.fillColor ?? AppColors.white,
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10.r),
              borderSide: BorderSide(
                color: AppColors.primaryColor,
                width: 2.w,
              ),
            ),
            prefixIcon: widget.prefixIcon,
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10.r),
              borderSide: BorderSide.none,
            ),
            suffixIcon: widget.suffixIcon,
          ),
        ),
        if (widget.errorText != null)
          Padding(
            padding: EdgeInsets.only(top: 5.h, right: 10.w),
            child: Text(
              widget.errorText!,
              style: TextStyle(color: Colors.red, fontSize: 12.sp),
            ),
          ),
      ],
    );
  }
}
