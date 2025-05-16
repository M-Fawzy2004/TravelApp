import 'package:flutter/material.dart';
import 'package:travel_app/core/helper/spacing.dart';
import 'package:travel_app/core/theme/app_color.dart';
import 'package:travel_app/core/widget/custom_text_form_field.dart';
import 'package:travel_app/feature/home/presentation/view/widget/share_location_button.dart';

class TextFieldRow extends StatelessWidget {
  const TextFieldRow({
    super.key,
    this.icon,
    required this.hintText,
    this.keyboardType,
  });

  final IconData? icon;
  final String hintText;
  final TextInputType? keyboardType;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          children: [
            icon == null
                ? const SizedBox()
                : Icon(
                    icon,
                    color: AppColors.primaryColor,
                  ),
            widthBox(10),
            Expanded(
              flex: 5,
              child: CustomTextFormField(
                onChanged: (value) {},
                onSaved: (saved){},
                hintText: hintText,
                fillColor: AppColors.whitewithOpacity,
                keyboardType: keyboardType,
              ),
            ),
            if (icon != null)
              const SizedBox()
            else
              const Expanded(
                flex: 2,
                child: ShareLocationButton(title: 'موقعك'),
              ),
          ],
        ),
        heightBox(10),
      ],
    );
  }
}
