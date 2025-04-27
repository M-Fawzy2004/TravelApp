import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:travel_app/core/helper/spacing.dart';
import 'package:travel_app/core/utils/show_logout_dialog.dart';
import 'package:travel_app/feature/profile/presentation/view/widget/icon_text_tile.dart';

class AccountOptions extends StatelessWidget {
  const AccountOptions({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        IconTextTile(
          onTap: () {},
          title: 'الحساب الشخصي',
          icon: FontAwesomeIcons.user,
        ),
        heightBox(2),
        IconTextTile(
          onTap: () {},
          title: 'الإشعارات',
          icon: FontAwesomeIcons.solidBell,
        ),
        heightBox(2),
        IconTextTile(
          onTap: () {},
          title: 'الوضع الداكن',
          icon: FontAwesomeIcons.moon,
        ),
        heightBox(2),
        IconTextTile(
          onTap: () {},
          title: 'الخصوصية',
          icon: FontAwesomeIcons.lock,
        ),
        heightBox(2),
        IconTextTile(
          onTap: () {},
          title: 'من نحن',
          icon: FontAwesomeIcons.infoCircle,
        ),
        heightBox(2),
        IconTextTile(
          onTap: () {
            showLogoutConfirmationDialog(context);
          },
          title: 'تسجيل الخروج',
          icon: FontAwesomeIcons.rightFromBracket,
          color: Colors.red,
          backgroundColor: Colors.red,
        ),
      ],
    );
  }
}
