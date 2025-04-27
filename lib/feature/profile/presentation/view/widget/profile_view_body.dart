import 'package:flutter/material.dart';
import 'package:travel_app/core/helper/spacing.dart';
import 'package:travel_app/feature/profile/presentation/view/account_view.dart';
import 'package:travel_app/feature/profile/presentation/view/help_view.dart';
import 'package:travel_app/feature/profile/presentation/view/wallet_view.dart';
import 'package:travel_app/feature/profile/presentation/view/widget/account_text_container.dart';
import 'package:travel_app/feature/profile/presentation/view/widget/profile_header.dart';
import 'package:travel_app/feature/profile/presentation/view/widget/profile_options_row.dart';

class ProfileViewBody extends StatefulWidget {
  const ProfileViewBody({super.key});

  @override
  State<ProfileViewBody> createState() => _ProfileViewBodyState();
}

class _ProfileViewBodyState extends State<ProfileViewBody> {
  int selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const ProfileHeader(),
        heightBox(10),
        ProfileOptionsRow(
          onSelect: (index) {
            setState(() {
              selectedIndex = index;
            });
          },
          selectedIndex: selectedIndex,
        ),
        heightBox(10),
        getText(),
        heightBox(10),
        Expanded(
          child: getSelectedScreen(),
        ),
      ],
    );
  }

  Widget getSelectedScreen() {
    switch (selectedIndex) {
      case 0:
        return const AccountView();
      case 1:
        return const WalletView();
      case 2:
        return const HelpView();
      default:
        return const Center(child: Text("Select an option"));
    }
  }

  Widget getText() {
    switch (selectedIndex) {
      case 0:
        return const AccountTextContainer(title: 'الحساب');
      case 1:
        return const AccountTextContainer(title: 'المحفظه');
      case 2:
        return const AccountTextContainer(title: 'مساعده');
      default:
        return const Center(child: Text("Select an option"));
    }
  }
}
