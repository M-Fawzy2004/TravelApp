import 'package:flutter/material.dart';
import 'package:travel_app/core/helper/spacing.dart';
import 'package:travel_app/feature/profile/presentation/view/widget/profile_option_card.dart';

class ProfileOptionsRow extends StatelessWidget {
  const ProfileOptionsRow({
    super.key,
    required this.selectedIndex,
    required this.onSelect,
  });

  final int selectedIndex;
  final Function(int) onSelect;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: ProfileOptionCard(
            title: 'الحساب',
            icon: Icons.person,
            isSelected: selectedIndex == 0,
            onTap: () => onSelect(0),
          ),
        ),
        widthBox(10),
        Expanded(
          child: ProfileOptionCard(
            title: 'المحفظه',
            icon: Icons.wallet,
            isSelected: selectedIndex == 1,
            onTap: () => onSelect(1),
          ),
        ),
        widthBox(10),
        Expanded(
          child: ProfileOptionCard(
            title: 'مساعده',
            icon: Icons.info,
            isSelected: selectedIndex == 2,
            onTap: () => onSelect(2),
          ),
        ),
      ],
    );
  }
}
