import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:travel_app/core/theme/app_color.dart';
import 'package:travel_app/core/theme/styles.dart';

class MessageAndPrice extends StatelessWidget {
  const MessageAndPrice({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Text(
          'السعر الإجمالي: 300 ج.م',
          style: Styles.font12GreyExtraBold.copyWith(
            color: AppColors.primaryColor,
          ),
        ),
        const Spacer(),
        IconButton(
          onPressed: () {},
          icon: const Icon(
            FontAwesomeIcons.message,
            color: AppColors.primaryColor,
          ),
        ),
      ],
    );
  }
}
