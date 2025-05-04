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

  const RoleDropdownTextField({
    super.key,
    this.onRoleSelected,
    this.onVehicleTypeSelected,
    this.seatCountController,
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
          dropdownColor: AppColors.white,
          style: Styles.font20ExtraBlackBold,
          padding: const EdgeInsets.symmetric(horizontal: 10),
          borderRadius: BorderRadius.circular(10.r),
          items: [
            DropdownMenuItem(
              value: 'كابتن',
              child: Text(
                'كابتن',
                style: Styles.font16BlackBold.copyWith(
                  fontFamily: 'font',
                ),
              ),
            ),
            DropdownMenuItem(
              value: 'راكب',
              child: Text(
                'راكب',
                style: Styles.font16BlackBold.copyWith(
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
            labelText: 'نوع المستخدم',
          ).copyWith(
            filled: true,
            fillColor: AppColors.white,
          ),
        ),
        if (selectedRole == 'كابتن') ...[
          heightBox(20),
          DropdownButtonFormField<String>(
            dropdownColor: AppColors.white,
            style: Styles.font20ExtraBlackBold,
            padding: const EdgeInsets.symmetric(horizontal: 10),
            borderRadius: BorderRadius.circular(10.r),
            value: selectedVehicleType,
            items: vehicleTypes.map((type) {
              return DropdownMenuItem(
                value: type,
                child: Text(
                  type,
                  style: Styles.font16BlackBold,
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
              labelText: 'نوع المركبة',
            ).copyWith(
              filled: true,
              fillColor: AppColors.white,
            ),
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
