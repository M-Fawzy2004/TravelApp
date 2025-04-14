import 'package:flutter/material.dart';
import 'package:country_picker/country_picker.dart';
import 'package:go_router/go_router.dart';
import 'package:travel_app/core/helper/app_router.dart';
import 'package:travel_app/core/helper/spacing.dart';
import 'package:travel_app/core/theme/styles.dart';
import 'package:travel_app/core/utils/assets.dart';
import 'package:travel_app/core/widget/custom_button.dart';
import 'package:travel_app/feature/login/presentation/view/widget/or_login.dart';
import 'package:travel_app/feature/login/presentation/view/widget/phone_number_field.dart';
import 'package:travel_app/feature/login/presentation/view/widget/social_login.dart';

class LoginForm extends StatefulWidget {
  const LoginForm({super.key});

  @override
  State<LoginForm> createState() => _LoginFormState();
}

class _LoginFormState extends State<LoginForm> {
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  bool isPhoneValid = false;
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
    if (isPhoneValid != isValid || phoneNumber != number) {
      setState(() {
        isPhoneValid = isValid;
        phoneNumber = number;
      });
    }
  }

  void _selectCountry() {
    Future.delayed(Duration.zero, () {
      showCountryPicker(
        // ignore: use_build_context_synchronously
        context: context,
        showPhoneCode: true,
        countryListTheme: CountryListThemeData(
          borderRadius: BorderRadius.circular(15),
        ),
        onSelect: (Country country) {
          setState(() {
            selectedCountry = country;
            isPhoneValid = false;
          });
        },
      );
    });
  }

  void _continueToVerification() {
    if (formKey.currentState!.validate()) {
      final fullPhoneNumber = '+${selectedCountry.phoneCode}$phoneNumber';
      debugPrint('Phone number: $fullPhoneNumber');
      context.push(AppRouter.otpVerf, extra: fullPhoneNumber);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: formKey,
      child: Column(
        children: [
          heightBox(28),
          PhoneNumberField(
            selectedCountry: selectedCountry,
            onCountryTap: _selectCountry,
            onPhoneValidation: _onPhoneValidation,
          ),
          heightBox(15),
          CustomButton(
            onPressed: _continueToVerification,
            buttonText: 'الاستمرار',
            textStyle: Styles.font16WhiteBold,
            isEnabled: isPhoneValid,
          ),
          heightBox(10),
          const OrLogin(),
          heightBox(10),
          SocialLogin(
            onTap: () {},
            image: Assets.imagesAppleLogo,
            text: 'الدخول بواسطه ابل',
          ),
          heightBox(10),
          SocialLogin(
            onTap: () {},
            image: Assets.imagesGoogleLogo,
            text: 'الدخول بواسطه جوجل',
          ),
          heightBox(10),
          SocialLogin(
            onTap: () {
              context.push(AppRouter.loginwithEmail);
            },
            image: Assets.imagesMailLogo,
            text: 'الدخول بواسطه البريد الالكتروني',
          ),
        ],
      ),
    );
  }
}