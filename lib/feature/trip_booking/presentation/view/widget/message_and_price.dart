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
          style: Styles.font12GreyExtraBold(context).copyWith(
            color: AppColors.getPrimaryColor(context),
          ),
        ),
        const Spacer(),
        IconButton(
          onPressed: () {},
          icon: Icon(
            FontAwesomeIcons.message,
            color: AppColors.getPrimaryColor(context),
          ),
        ),
      ],
    );
  }
}
