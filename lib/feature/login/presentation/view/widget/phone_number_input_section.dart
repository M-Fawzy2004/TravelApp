// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:country_picker/country_picker.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:travel_app/feature/login/presentation/view/widget/phone_number_field.dart';

class PhoneNumberInputSection extends StatefulWidget {
  final Function(String fullPhoneNumber) onPhoneChanged;

  const PhoneNumberInputSection({
    super.key,
    required this.onPhoneChanged,
  });

  @override
  State<PhoneNumberInputSection> createState() => _PhoneNumberInputSectionState();
}

class _PhoneNumberInputSectionState extends State<PhoneNumberInputSection> {
  String phoneNumber = '';
  Country selectedCountry = Country(
    phoneCode: '20',
    countryCode: 'EG',
    e164Sc: 0,
    geographic: true,
    level: 1,
    name: 'Egypt',
    example: 'Egypt',
    displayName: 'Egypt',
    displayNameNoCountryCode: 'EG',
    e164Key: '',
  );

  void _onPhoneValidation(bool isValid, String number) {
    if (isValid) {
      phoneNumber = number;
      final fullPhone = '+${selectedCountry.phoneCode}$phoneNumber';
      widget.onPhoneChanged(fullPhone);
    } else {
      widget.onPhoneChanged('');
    }
  }

  void _selectCountry() {
    Future.delayed(Duration.zero, () {
      showCountryPicker(
        context: context,
        showPhoneCode: true,
        countryListTheme: CountryListThemeData(
          borderRadius: BorderRadius.circular(15),
          bottomSheetHeight: 500.h,
        ),
        onSelect: (Country country) {
          setState(() {
            selectedCountry = country;
          });
        },
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return PhoneNumberField(
      selectedCountry: selectedCountry,
      onCountryTap: _selectCountry,
      onPhoneValidation: _onPhoneValidation,
    );
  }
}
