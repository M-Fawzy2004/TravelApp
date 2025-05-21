import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:travel_app/core/theme/styles.dart';

class CustomTextField extends StatefulWidget {
  final TextEditingController controller;
  final String hintText;
  final Function(String)? onChanged;
  final Color fillColor;
  final TextAlign textAlign;
  final TextDirection textDirection;
  final FocusNode? focusNode;
  final bool enableInteractiveSelection;
  final bool? enabled;
  final TextInputType? keyboardType;

  const CustomTextField({
    super.key,
    required this.controller,
    this.hintText = '',
    this.onChanged,
    this.fillColor = Colors.white,
    this.textAlign = TextAlign.left,
    this.textDirection = TextDirection.ltr,
    this.focusNode,
    this.enableInteractiveSelection = true,
    this.enabled = true,
    this.keyboardType,
  });

  @override
  State<CustomTextField> createState() => _CustomTextFieldState();
}

class _CustomTextFieldState extends State<CustomTextField> {
  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: widget.controller,
      focusNode: widget.focusNode,
      enabled: widget.enabled,
      keyboardType: widget.keyboardType ?? TextInputType.text,
      textAlign: widget.textAlign,
      textDirection: widget.textDirection,
      enableInteractiveSelection: widget.enableInteractiveSelection,
      decoration: InputDecoration(
        hintText: widget.hintText,
        hintTextDirection: TextDirection.rtl,
        hintStyle: Styles.font14GreyExtraBold,
        filled: true,
        fillColor: widget.fillColor,
        contentPadding: EdgeInsets.symmetric(
          horizontal: 12.w,
          vertical: 12.h,
        ),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8.r),
          borderSide: BorderSide.none,
        ),
        suffixIconConstraints: const BoxConstraints(maxHeight: 0, maxWidth: 0),
      ),
      onChanged: (value) {
        if (widget.onChanged != null) {
          widget.onChanged!(value);
        }
      },
      autocorrect: false,
      enableSuggestions: false,
    );
  }
}
