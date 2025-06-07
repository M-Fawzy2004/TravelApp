import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:travel_app/core/theme/app_color.dart';
import 'package:travel_app/core/theme/styles.dart';
import 'package:travel_app/core/utils/custom_input_decoration.dart';
import 'package:travel_app/core/widget/custom_text_form_field.dart';
import 'package:travel_app/core/helper/spacing.dart';

class RoleDropdownTextField extends StatefulWidget {
  final Function(String?)? onRoleSelected;
  final Function(String?)? onVehicleTypeSelected;
  final TextEditingController? seatCountController;
  final TextEditingController? brandController;
  final TextEditingController? modelController;
  final TextEditingController? licenseController;

  const RoleDropdownTextField({
    super.key,
    this.onRoleSelected,
    this.onVehicleTypeSelected,
    this.seatCountController,
    this.brandController,
    this.modelController,
    this.licenseController,
  });

  @override
  State<RoleDropdownTextField> createState() => _RoleDropdownTextFieldState();
}

class _RoleDropdownTextFieldState extends State<RoleDropdownTextField> {
  String? selectedRole;
  String? selectedVehicleType;

  final List<String> vehicleTypes = [
    'ملاكي',
    'ميكروباص',
    'ميني باص',
    'باص',
    'موتسيكل',
  ];

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        DropdownButtonFormField<String>(
          value: selectedRole,
          dropdownColor: AppColors.getSurfaceColor(context),
          style: Styles.font20ExtraBlackBold(context),
          padding: const EdgeInsets.symmetric(horizontal: 10),
          borderRadius: BorderRadius.circular(10.r),
          items: [
            DropdownMenuItem(
              value: 'كابتن رحلات',
              child: Text(
                'كابتن رحلات',
                style: Styles.font16BlackBold(context).copyWith(
                  fontFamily: 'font',
                ),
              ),
            ),
            DropdownMenuItem(
              value: 'راكب',
              child: Text(
                'راكب',
                style: Styles.font16BlackBold(context).copyWith(
                  fontFamily: 'font',
                ),
              ),
            ),
          ],
          onChanged: (value) {
            setState(() {
              selectedRole = value;
              widget.onRoleSelected?.call(value);
            });
          },
          decoration: customInputDecoration(
            context: context,
            labelText: 'نوع المستخدم',
          ).copyWith(
            filled: true,
            fillColor: AppColors.getSurfaceColor(context),
          ),
        ),
        if (selectedRole == 'كابتن رحلات') ...[
          heightBox(20),
          DropdownButtonFormField<String>(
            dropdownColor: AppColors.getSurfaceColor(context),
            style: Styles.font20ExtraBlackBold(context),
            padding: const EdgeInsets.symmetric(horizontal: 10),
            borderRadius: BorderRadius.circular(10.r),
            value: selectedVehicleType,
            items: vehicleTypes.map((type) {
              return DropdownMenuItem(
                value: type,
                child: Text(
                  type,
                  style: Styles.font16BlackBold(context),
                ),
              );
            }).toList(),
            onChanged: (value) {
              setState(() {
                selectedVehicleType = value;
                widget.onVehicleTypeSelected?.call(value);
              });
            },
            decoration: customInputDecoration(
              context: context,
              labelText: 'نوع المركبة',
            ).copyWith(
              filled: true,
              fillColor: AppColors.getSurfaceColor(context),
            ),
          ),
          heightBox(20),
          CustomTextFormField(
            hintText: 'ماركة السيارة',
            controller: widget.brandController,
          ),
          heightBox(20),
          CustomTextFormField(
            hintText: 'موديل السيارة',
            controller: widget.modelController,
          ),
          heightBox(20),
          CustomTextFormField(
            hintText: 'رقم رخصة السيارة',
            controller: widget.licenseController,
          ),
          heightBox(20),
          CustomTextFormField(
            hintText: 'عدد المقاعد',
            controller: widget.seatCountController,
            keyboardType: TextInputType.number,
          ),
        ],
      ],
    );
  }
}
