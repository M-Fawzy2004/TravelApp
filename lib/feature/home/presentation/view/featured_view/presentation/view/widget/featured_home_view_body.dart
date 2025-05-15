import 'package:flutter/material.dart';
import 'package:travel_app/core/theme/styles.dart';
import 'package:travel_app/core/widget/icon_back.dart';
import 'package:travel_app/feature/home/presentation/view/featured_view/presentation/view/widget/featured_travel_card_list_view.dart';

class FeaturedHomeViewBody extends StatelessWidget {
  const FeaturedHomeViewBody({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          children: [
            const IconBack(),
            const Spacer(),
            Text(
              'الرحلات المميزة',
              style: Styles.font20BlackBold,
            ),
          ],
        ),
        const FeaturedTravelCardListView(),
      ],
    );
  }
}
