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
          icon: FontAwesomeIcons.sun,
        ),
        heightBox(2),
        IconTextTile(
          onTap: () {},
          title: 'القييمات والمراجعات',
          icon: FontAwesomeIcons.star,
        ),
        heightBox(2),
        IconTextTile(
          onTap: () {},
          title: 'الرحلات السابقه',
          icon: FontAwesomeIcons.history,
        ),
        heightBox(2),
        IconTextTile(
          onTap: () {},
          title: 'المستندات الشخصيه',
          icon: FontAwesomeIcons.file,
        ),
        heightBox(2),
        IconTextTile(
          onTap: () {},
          title: 'اللغه',
          icon: FontAwesomeIcons.language,
        ),
        heightBox(2),
        IconTextTile(
          onTap: () {},
          title: 'الأمان وتسجيل الدخول',
          icon: FontAwesomeIcons.lock,
        ),
        heightBox(2),
        IconTextTile(
          onTap: () {},
          title: 'الدعم الفنى أو تواصل معنا',
          icon: FontAwesomeIcons.headset,
        ),
        heightBox(2),
        IconTextTile(
          onTap: () {},
          title: 'من نحن',
          icon: FontAwesomeIcons.infoCircle,
        ),
        heightBox(2),
        IconTextTile(
          onTap: () {},
          title: 'الخصوصية',
          icon: FontAwesomeIcons.shield,
        ),
        heightBox(2),
        IconTextTile(
          onTap: () {},
          title: 'مشاركه التطبيق',
          icon: FontAwesomeIcons.share,
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
