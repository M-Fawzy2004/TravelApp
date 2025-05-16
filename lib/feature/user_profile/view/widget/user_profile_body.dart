import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:travel_app/core/helper/spacing.dart';
import 'package:travel_app/core/theme/styles.dart';
import 'package:travel_app/core/utils/top_snakbar_app.dart';
import 'package:travel_app/core/widget/custom_button.dart';
import 'package:travel_app/core/widget/custom_text_form_field.dart';
import 'package:travel_app/feature/auth/domain/entity/user_entity.dart';
import 'package:travel_app/feature/auth/presentation/manager/cubit/auth_cubit.dart';
import 'package:travel_app/feature/auth/presentation/view/widget/phone_number_input_section.dart';
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
  final TextEditingController _brandController = TextEditingController();
  final TextEditingController _modelController = TextEditingController();
  final TextEditingController _licenseController = TextEditingController();

  String? selectedRoleText;
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

      isPhoneLogin = user.email?.isEmpty ?? true;

      if (isPhoneLogin) {
        fullPhoneNumber = user.phoneNumber;
        isPhoneValid = fullPhoneNumber.isNotEmpty;
        requirePhoneVerification = false;
      } else {
        fullPhoneNumber = user.phoneNumber;
        isPhoneValid = fullPhoneNumber.isNotEmpty;
        requirePhoneVerification = fullPhoneNumber.isEmpty;
      }

      selectedRole = user.role;
      selectedVehicleType = user.vehicleType;
      if (user.seatCount != null) {
        _seatCountController.text = user.seatCount.toString();
      }
      // Set the appropriate role text based on the role enum
      if (user.role == UserRole.captain) {
        selectedRoleText = 'كابتن رحلات';
      } else if (user.role == UserRole.directDelivery) {
        selectedRoleText = 'كابتن توصيل مباشر';
      } else if (user.role == UserRole.passenger) {
        selectedRoleText = 'راكب';
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
      showCustomTopSnackBar(
        context: context,
        message: 'الرجاء إدخال جميع البيانات المطلوبة',
      );
      return;
    }

    if (!isPhoneLogin && (fullPhoneNumber.isEmpty || !isPhoneValid)) {
      showCustomTopSnackBar(
        context: context,
        message: 'الرجاء إدخال رقم هاتف صحيح',
      );
      return;
    }

    if ((selectedRole == UserRole.captain ||
            selectedRole == UserRole.directDelivery) &&
        (selectedVehicleType == null ||
            _brandController.text.isEmpty ||
            _modelController.text.isEmpty ||
            _licenseController.text.isEmpty ||
            _seatCountController.text.isEmpty)) {
      showCustomTopSnackBar(
        context: context,
        message: 'الرجاء إدخال جميع بيانات المركبة',
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
        vehicleType: (selectedRole == UserRole.captain ||
                selectedRole == UserRole.directDelivery)
            ? selectedVehicleType
            : null,
        seatCount: (selectedRole == UserRole.captain ||
                selectedRole == UserRole.directDelivery)
            ? int.tryParse(_seatCountController.text)
            : null,
        vehicleBrand: (selectedRole == UserRole.captain ||
                selectedRole == UserRole.directDelivery)
            ? _brandController.text
            : null,
        vehicleModel: (selectedRole == UserRole.captain ||
                selectedRole == UserRole.directDelivery)
            ? _modelController.text
            : null,
        vehicleLicense: (selectedRole == UserRole.captain ||
                selectedRole == UserRole.directDelivery)
            ? _licenseController.text
            : null,
        isEmailVerified: authState.user.isEmailVerified,
      );

      // If non-phone login and phone number is provided but not yet verified
      if (!isPhoneLogin && isPhoneValid && requirePhoneVerification) {
        // Save user data first
        context.read<AuthCubit>().saveUser(updatedUser);
        // Then initiate phone verification
        context.read<AuthCubit>().linkPhoneToCurrentUser(fullPhoneNumber);
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
                selectedRoleText = role;
                selectedRole = _parseRole(role);
              });
            },
            onVehicleTypeSelected: (type) {
              setState(() {
                selectedVehicleType = _parseVehicleType(type);
              });
            },
            seatCountController: _seatCountController,
            brandController: _brandController,
            modelController: _modelController,
            licenseController: _licenseController,
          ),
          heightBox(20),
          CustomButton(
            buttonText: isLoading ? 'جاري التحميل' : 'استمرار',
            onPressed: isLoading ? null : _saveProfile,
          ),
        ],
      ),
    );
  }

  UserRole? _parseRole(String? role) {
    if (role == null) return null;
    if (role == 'كابتن رحلات') return UserRole.captain;
    if (role == 'كابتن توصيل مباشر') return UserRole.directDelivery;
    return UserRole.passenger;
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
