import 'package:flutter/material.dart';
import 'package:travel_app/core/helper/get_user.dart';
import 'package:travel_app/core/theme/styles.dart';

class CaptainHomeHeader extends StatelessWidget {
  const CaptainHomeHeader({super.key});

  @override
  Widget build(BuildContext context) {
    final user = getUser();
    final name = user?.firstName ?? 'كابتن';

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'مرحباً بك، $name 👋',
          style: Styles.font20BlackBold(context),
        ),
        const SizedBox(height: 10),
        Text(
          'نتمنى لك يوماً سعيداً ومليئاً بالرحلات! 🚗',
          style: Styles.font14GreyExtraBold(context),
        ),
      ],
    );
  }
}
