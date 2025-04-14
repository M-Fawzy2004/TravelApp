import 'package:flutter/material.dart';
import 'package:country_picker/country_picker.dart';
import 'package:travel_app/core/helper/spacing.dart';
import 'package:travel_app/core/theme/app_color.dart';
import 'package:travel_app/core/theme/styles.dart';
import 'package:travel_app/feature/login/presentation/view/widget/phone_text_field.dart';

class PhoneNumberField extends StatelessWidget {
  final Country selectedCountry;
  final VoidCallback onCountryTap;
  final Function(bool, String) onPhoneValidation;

  const PhoneNumberField({
    super.key,
    required this.selectedCountry,
    required this.onCountryTap,
    required this.onPhoneValidation,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          flex: 5,
          child: PhoneTextField(
            countryCode: selectedCountry.countryCode,
            onValidationChanged: onPhoneValidation,
          ),
        ),
        widthBox(10),
        Expanded(
          flex: 2,
          child: GestureDetector(
            onTap: onCountryTap,
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
              decoration: BoxDecoration(
                color: AppColors.grey,
                borderRadius: BorderRadius.circular(10),
              ),
              child: Row(
                children: [
                  Text(
                    selectedCountry.flagEmoji,
                    style: const TextStyle(fontSize: 20),
                  ),
                  widthBox(6),
                  Text(
                    "+${selectedCountry.phoneCode}",
                    style: Styles.font16BlackBold,
                  ),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }
}