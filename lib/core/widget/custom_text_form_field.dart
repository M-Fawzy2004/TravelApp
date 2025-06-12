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
    this.showClearIcon,
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
  final bool? showClearIcon;

  @override
  State<CustomTextFormField> createState() => _CustomTextFormFieldState();
}

class _CustomTextFormFieldState extends State<CustomTextFormField> {
  TextEditingController? _internalController;
  bool _showClearButton = false;

  TextEditingController get _effectiveController =>
      widget.controller ?? _internalController!;

  @override
  void initState() {
    super.initState();
    if (widget.controller == null) {
      _internalController = TextEditingController();
    }
    _effectiveController.addListener(_updateClearButtonVisibility);
    _updateClearButtonVisibility();
  }

  @override
  void didUpdateWidget(CustomTextFormField oldWidget) {
    super.didUpdateWidget(oldWidget);

    if (oldWidget.controller != widget.controller) {
      if (oldWidget.controller != null) {
        oldWidget.controller!.removeListener(_updateClearButtonVisibility);
      } else {
        _internalController?.removeListener(_updateClearButtonVisibility);
      }
      _effectiveController.addListener(_updateClearButtonVisibility);
      _updateClearButtonVisibility();
    }
  }

  void _updateClearButtonVisibility() {
    if (mounted) {
      setState(() {
        _showClearButton = _effectiveController.text.isNotEmpty;
      });
    }
  }

  void _clearText() {
    _effectiveController.clear();
    if (widget.onChanged != null) {
      widget.onChanged!('');
    }
    _updateClearButtonVisibility();
  }

  @override
  void dispose() {
    _effectiveController.removeListener(_updateClearButtonVisibility);
    _internalController?.dispose();
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
          onChanged: (value) {
            _updateClearButtonVisibility();
            if (widget.onChanged != null) {
              widget.onChanged!(value);
            }
          },
          controller: _effectiveController,
          maxLines: widget.maxLines ?? 1,
          obscureText: widget.obscureText ?? false,
          style: Styles.font14DarkGreyExtraBold(context),
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
            hintStyle:
                widget.inputTextStyle ?? Styles.font14GreyExtraBold(context),
            filled: true,
            fillColor: widget.fillColor ?? AppColors.getSurfaceColor(context),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(25.r),
              borderSide: BorderSide(
                color: AppColors.getPrimaryColor(context),
                width: 2.w,
              ),
            ),
            prefixIcon: widget.prefixIcon,
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(25.r),
              borderSide: BorderSide.none,
            ),
            suffixIcon: widget.showClearIcon == true && _showClearButton
                ? IconButton(
                    icon: Icon(
                      Icons.clear,
                      size: 20.sp,
                      color: AppColors.getPrimaryColor(context),
                    ),
                    onPressed: _clearText,
                  )
                : widget.suffixIcon,
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
