import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:travel_app/core/theme/styles.dart';
import 'package:travel_app/core/theme/app_color.dart';

class PhoneTextField extends StatefulWidget {
  final String countryCode;
  final Function(bool, String)? onValidationChanged;

  const PhoneTextField({
    super.key,
    required this.countryCode,
    this.onValidationChanged,
  });

  @override
  State<PhoneTextField> createState() => _PhoneTextFieldState();
}

class _PhoneTextFieldState extends State<PhoneTextField> {
  final TextEditingController _controller = TextEditingController();
  String? _errorText;
  RegExp _phoneRegex = RegExp(r'^01[0125][0-9]{8}$');
  String lastCountryCode = 'EG';

  @override
  void initState() {
    super.initState();
    lastCountryCode = widget.countryCode;
    _updateRegexForCountry(widget.countryCode);
  }

  @override
  void didUpdateWidget(PhoneTextField oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.countryCode != widget.countryCode) {
      lastCountryCode = widget.countryCode;
      _updateRegexForCountry(widget.countryCode);
      Future.microtask(() {
        _validateNumber(_controller.text);
      });
    }
  }

  void _updateRegexForCountry(String countryCode) {
    switch (countryCode) {
      case 'EG':
        _phoneRegex = RegExp(r'^01[0125][0-9]{8}$');
        break;
      case 'SA':
        _phoneRegex = RegExp(r'^05[0-9]{8}$');
        break;
      case 'AE':
        _phoneRegex = RegExp(r'^(05|04|02|03|06|07|09)[0-9]{7,8}$');
        break;
      default:
        _phoneRegex = RegExp(r'^[0-9]{8,15}$');
    }
  }

  void _validateNumber(String value) {
    String cleanNumber = value.replaceAll(RegExp(r'[^0-9]'), '');
    bool isValid = _phoneRegex.hasMatch(cleanNumber);

    String? newErrorText;
    if (cleanNumber.isEmpty) {
      newErrorText = 'الرجاء إدخال رقم الهاتف';
    } else if (!isValid) {
      newErrorText = 'رقم هاتف غير صالح للدولة المحددة';
    } else {
      newErrorText = null;
    }

    if (newErrorText != _errorText) {
      setState(() {
        _errorText = newErrorText;
      });
    }

    widget.onValidationChanged?.call(isValid, cleanNumber);
  }

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: _controller,
      onChanged: _validateNumber,
      validator: (value) {
        if (value == null || value.isEmpty) {
          return 'الرجاء إدخال رقم الهاتف';
        }
        if (_errorText != null) {
          return _errorText;
        }
        return null;
      },
      keyboardType: TextInputType.phone,
      textAlign: TextAlign.left,
      style: Styles.font16BlackBold,
      decoration: InputDecoration(
        hintText: 'ادخل رقم الهاتف',
        hintStyle: Styles.font14DarkGreyExtraBold,
        errorText: _errorText,
        isDense: true,
        contentPadding: EdgeInsets.symmetric(
          vertical: 14.h,
          horizontal: 16.w,
        ),
        filled: true,
        fillColor: AppColors.white,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10.r),
          borderSide: BorderSide.none,
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10.r),
          borderSide: BorderSide(
            color: AppColors.primaryColor,
            width: 2.w,
          ),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10.r),
          borderSide: BorderSide(
            color: AppColors.grey,
            width: 2.w,
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }
}
