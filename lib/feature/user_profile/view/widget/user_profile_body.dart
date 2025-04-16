import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:travel_app/core/helper/spacing.dart';
import 'package:travel_app/core/theme/styles.dart';
import 'package:travel_app/core/utils/app_flush_bar.dart';
import 'package:travel_app/core/widget/custom_button.dart';
import 'package:travel_app/core/widget/custom_text_form_field.dart';
import 'package:travel_app/core/widget/icon_back.dart';
import 'package:travel_app/feature/login/domain/entity/user_entity.dart';
import 'package:travel_app/feature/login/presentation/manager/cubit/auth_cubit.dart';
import 'package:travel_app/feature/login/presentation/view/widget/phone_number_input_section.dart';
import 'package:travel_app/feature/user_profile/view/widget/role_dropdown_text_field.dart';

class UserProfileBody extends StatefulWidget {
  const UserProfileBody({super.key});

  @override
  State<UserProfileBody> createState() => _UserProfileBodyState();
}

class _UserProfileBodyState extends State<UserProfileBody> {
  final TextEditingController _firstNameController = TextEditingController();
  final TextEditingController _lastNameController = TextEditingController();
  final TextEditingController _cityController = TextEditingController();
  final TextEditingController _seatCountController = TextEditingController();

  UserRole? selectedRole;
  VehicleType? selectedVehicleType;

  String fullPhoneNumber = '';
  bool isPhoneValid = false;
  bool isLoading = false;
  bool requirePhoneVerification = false;
  bool isPhoneLogin = false;

  @override
  void initState() {
    super.initState();
    final authState = context.read<AuthCubit>().state;
    if (authState is AuthAuthenticated) {
      final user = authState.user;
      _firstNameController.text = user.firstName ?? '';
      _lastNameController.text = user.lastName ?? '';
      _cityController.text = user.city ?? '';

      // Check if this is a phone login or other login type
      isPhoneLogin = user.email?.isEmpty ?? true;

      if (isPhoneLogin) {
        // If phone login, we already have the phone number
        fullPhoneNumber = user.phoneNumber;
        isPhoneValid = fullPhoneNumber.isNotEmpty;
        requirePhoneVerification = false;
      } else {
        // If email/apple login, we might need phone verification
        fullPhoneNumber = user.phoneNumber;
        isPhoneValid = fullPhoneNumber.isNotEmpty;
        requirePhoneVerification = fullPhoneNumber.isEmpty;
      }

      selectedRole = user.role;
      selectedVehicleType = user.vehicleType;
      if (user.seatCount != null) {
        _seatCountController.text = user.seatCount.toString();
      }
    }
  }

  void _onPhoneChanged(String phone) {
    setState(() {
      fullPhoneNumber = phone;
      isPhoneValid = phone.isNotEmpty;
    });
  }

  void _saveProfile() {
    if (_firstNameController.text.isEmpty ||
        _lastNameController.text.isEmpty ||
        selectedRole == null) {
      CustomFlushBar.showMessage(
        context: context,
        message: 'الرجاء إدخال جميع البيانات المطلوبة',
      );
      return;
    }

    if (!isPhoneLogin && (fullPhoneNumber.isEmpty || !isPhoneValid)) {
      CustomFlushBar.showMessage(
        context: context,
        message: 'الرجاء إدخال رقم هاتف صحيح',
      );
      return;
    }

    setState(() {
      isLoading = true;
    });

    final authState = context.read<AuthCubit>().state;
    if (authState is AuthAuthenticated) {
      final updatedUser = UserEntity(
        id: authState.user.id,
        phoneNumber: fullPhoneNumber,
        email: authState.user.email,
        firstName: _firstNameController.text,
        lastName: _lastNameController.text,
        city: _cityController.text,
        role: selectedRole,
        vehicleType:
            selectedRole == UserRole.captain ? selectedVehicleType : null,
        seatCount: selectedRole == UserRole.captain
            ? int.tryParse(_seatCountController.text)
            : null,
        isEmailVerified: authState.user.isEmailVerified,
      );

      // If non-phone login and phone number is provided but not yet verified
      if (!isPhoneLogin && isPhoneValid && requirePhoneVerification) {
        // Save user data first
        context.read<AuthCubit>().saveUser(updatedUser);
        // Then initiate phone verification
        context.read<AuthCubit>().signInWithPhone(fullPhoneNumber);
      } else {
        // Just save the user data
        context.read<AuthCubit>().saveUser(updatedUser);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      physics: const BouncingScrollPhysics(),
      child: Column(
        children: [
          const Align(
            alignment: Alignment.topRight,
            child: IconBack(),
          ),
          heightBox(20),
          Row(
            children: [
              Expanded(
                child: CustomTextFormField(
                  controller: _firstNameController,
                  hintText: 'الإسم الاول',
                ),
              ),
              widthBox(10),
              Expanded(
                child: CustomTextFormField(
                  controller: _lastNameController,
                  hintText: 'الاسم الثاني',
                ),
              ),
            ],
          ),
          heightBox(20),
          Align(
            alignment: Alignment.centerRight,
            child: Text('المدينة', style: Styles.font16BlackBold),
          ),
          heightBox(10),
          CustomTextFormField(
            controller: _cityController,
            hintText: 'مثال : الغربية / المحلة الكبرى',
          ),
          heightBox(20),
          if (!isPhoneLogin) ...[
            PhoneNumberInputSection(onPhoneChanged: _onPhoneChanged),
            heightBox(20),
          ],
          RoleDropdownTextField(
            onRoleSelected: (role) {
              setState(() {
                selectedRole = _parseRole(role);
              });
            },
            onVehicleTypeSelected: (type) {
              setState(() {
                selectedVehicleType = _parseVehicleType(type);
              });
            },
            seatCountController: _seatCountController,
          ),
          heightBox(20),
          CustomButton(
            buttonText: isLoading ? 'جاري التحميل' : 'استمرار',
            textStyle: Styles.font16WhiteBold,
            onPressed: isLoading ? null : _saveProfile,
          ),
        ],
      ),
    );
  }

  UserRole? _parseRole(String? role) {
    if (role == null) return null;
    return role == 'كابتن' ? UserRole.captain : UserRole.passenger;
  }

  VehicleType? _parseVehicleType(String? type) {
    switch (type) {
      case 'ملاكي':
        return VehicleType.privateCar;
      case 'ميكروباص':
        return VehicleType.microbus;
      case 'ميني باص':
        return VehicleType.minibus;
      case 'باص':
        return VehicleType.bus;
      case 'موتسيكل':
        return VehicleType.motorcycle;
      default:
        return null;
    }
  }
}
