import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:travel_app/core/helper/get_user.dart';
import 'package:travel_app/core/utils/show_logout_dialog.dart';
import 'package:travel_app/feature/auth/domain/entity/user_entity.dart';
import 'package:travel_app/feature/profile/presentation/view/widget/icon_text_tile.dart';

class AccountOptions extends StatelessWidget {
  const AccountOptions({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final role = getUser()?.role;
    return Column(
      children: [
        IconTextTile(
          onTap: () {},
          title: 'الحساب الشخصي',
          icon: FontAwesomeIcons.user,
        ),
        IconTextTile(
          onTap: () {},
          title: 'الإشعارات',
          icon: FontAwesomeIcons.solidBell,
        ),
        IconTextTile(
          onTap: () {},
          title: 'الوضع الداكن',
          icon: FontAwesomeIcons.sun,
        ),
        IconTextTile(
          onTap: () {},
          title: 'القييمات والمراجعات',
          icon: FontAwesomeIcons.star,
        ),
        IconTextTile(
          onTap: () {},
          title: 'الرحلات السابقه',
          icon: FontAwesomeIcons.history,
        ),
        role == UserRole.captain
            ? IconTextTile(
                onTap: () {},
                title: 'المستندات الشخصيه',
                icon: FontAwesomeIcons.file,
              )
            : const SizedBox.shrink(),
        IconTextTile(
          onTap: () {},
          title: 'اللغه',
          icon: Icons.language,
        ),
        IconTextTile(
          onTap: () {},
          title: 'الأمان وتسجيل الدخول',
          icon: FontAwesomeIcons.lock,
        ),
        IconTextTile(
          onTap: () {},
          title: 'الدعم الفنى أو تواصل معنا',
          icon: FontAwesomeIcons.headset,
        ),
        IconTextTile(
          onTap: () {},
          title: 'من نحن',
          icon: FontAwesomeIcons.infoCircle,
        ),
        IconTextTile(
          onTap: () {},
          title: 'الخصوصية',
          icon: FontAwesomeIcons.shield,
        ),
        IconTextTile(
          onTap: () {},
          title: 'مشاركه التطبيق',
          icon: FontAwesomeIcons.share,
        ),
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
